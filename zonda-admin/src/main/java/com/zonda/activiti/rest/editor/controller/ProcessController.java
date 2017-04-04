package com.zonda.activiti.rest.editor.controller;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.zip.ZipInputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ProcessEngineConfiguration;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.form.StartFormDataImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.image.ProcessDiagramGenerator;
import org.activiti.spring.ProcessEngineFactoryBean;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.zonda.activiti.rest.editor.service.WorkflowTraceService;
import com.zonda.controller.base.BaseController;
import com.zonda.entity.Page;
import com.zonda.util.AppUtil;
import com.zonda.util.Const;
import com.zonda.util.Jurisdiction;
import com.zonda.util.PageData;
import com.zonda.util.PathUtil;
import com.zonda.util.WorkflowUtils;

/**
 * 流程部署定义管理控制器. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2016年11月16日 下午4:22:07
 * <p>
 * Company: 风之子AI亚洲研究院
 * <p>
 * 
 * @author zhujl@c-platform.com
 * @version 1.0.0
 */
@Controller
@RequestMapping("/workflow/process")
public class ProcessController extends BaseController {

	String menuUrl = "workflow/process/list.do"; // 菜单地址(权限用)

	@Autowired
	private FormService formService;

	@Autowired
	private RuntimeService runtimeService;

	@Autowired
	private HistoryService historyService;

	@Autowired
	private IdentityService identityService;

	@Autowired
	private RepositoryService repositoryService;

	@Autowired
	private WorkflowTraceService workflowTraceService;

	@Autowired
	private ProcessEngineFactoryBean processEngine;

	@Autowired
	private ProcessEngineConfiguration processEngineConfiguration;

	/**
	 * 部署列表
	 */
	@RequestMapping(value = "/list")
	public ModelAndView modelList(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String keywords = pd.getString("keywords"); // 检索条件 关键词
			if (StringUtils.isNoneBlank(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			// 分页查询
			page.setEntityOrField(true);
			Long totalResult = repositoryService.createProcessDefinitionQuery().orderByProcessDefinitionId().desc().count();
			page.setTotalResult(totalResult.intValue());
			page.getTotalPage();
			List<ProcessDefinition> processList = repositoryService.createProcessDefinitionQuery().orderByProcessDefinitionId().desc().listPage((page.getCurrentPage() - 1) * page.getShowCount(), page.getShowCount());// 分页查询
			mv.setViewName("activiti/workflow/process/process-list");
			mv.addObject("processList", processList);
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 去手动部署页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddP")
	public ModelAndView goAddP() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("activiti/workflow/process/process-add");
		mv.addObject("msg", "saveP");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 部署新流程
	 * 
	 * @param exportDir
	 * @param file
	 * @return
	 */
	@RequestMapping(value = "/saveP")
	public ModelAndView deploy(@RequestParam(value = "file", required = false) MultipartFile file) {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "部署新流程");
		ModelAndView mv = this.getModelAndView();
		try {
			InputStream fileInputStream = file.getInputStream();
			Deployment deployment = null;
			String fileName = file.getOriginalFilename();
			String extension = FilenameUtils.getExtension(fileName);
			if (extension.equals("zip") || extension.equals("bar")) {
				ZipInputStream zip = new ZipInputStream(fileInputStream);
				deployment = repositoryService.createDeployment().addZipInputStream(zip).deploy();
			} else {
				deployment = repositoryService.createDeployment().addInputStream(fileName, fileInputStream).deploy();
			}
			List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).list();
			String exportDir = PathUtil.getClasspath() + Const.FILEPATH_DIAGRAMS;
			for (ProcessDefinition processDefinition : list) {
				WorkflowUtils.exportDiagramToFile(repositoryService, processDefinition, exportDir);
			}
			mv.addObject("msg", "success");
		}
		catch (Exception e) {
			logger.error("error on deploy process, because of file input stream", e);
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 读取资源，通过部署ID
	 *
	 * @param processDefinitionId
	 *            流程定义
	 * @param resourceType
	 *            资源类型(xml|image)
	 * @throws Exception
	 */
	@RequestMapping(value = "/resource/read")
	public void loadByDeployment(@RequestParam("processDefinitionId") String processDefinitionId, @RequestParam("resourceType") String resourceType, HttpServletResponse response) throws Exception {
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
		String resourceName = "";
		if (resourceType.equals("image")) {
			resourceName = processDefinition.getDiagramResourceName();
		} else if (resourceType.equals("xml")) {
			resourceName = processDefinition.getResourceName();
		}
		InputStream resourceAsStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), resourceName);
		byte[] b = new byte[1024];
		int len = -1;
		while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
			response.getOutputStream().write(b, 0, len);
		}
	}

	/**
	 * 读取资源，通过流程ID
	 *
	 * @param resourceType
	 *            资源类型(xml|image)
	 * @param processInstanceId
	 *            流程实例ID
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/resource/process-instance")
	public void loadByProcessInstance(@RequestParam("type") String resourceType, @RequestParam("pid") String processInstanceId, HttpServletResponse response) throws Exception {
		InputStream resourceAsStream = null;
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processInstance.getProcessDefinitionId()).singleResult();

		String resourceName = "";
		if (resourceType.equals("image")) {
			resourceName = processDefinition.getDiagramResourceName();
		} else if (resourceType.equals("xml")) {
			resourceName = processDefinition.getResourceName();
		}
		resourceAsStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), resourceName);
		byte[] b = new byte[1024];
		int len = -1;
		while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
			response.getOutputStream().write(b, 0, len);
		}
	}

	/**
	 * 挂起、激活流程实例
	 * 
	 * @param state
	 *            状态(suspend-挂起 active-激活)
	 * @param processDefinitionId
	 *            流程定义ID
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/update/{state}/{processDefinitionId}")
	public String updateState(@PathVariable("state") String state, @PathVariable("processDefinitionId") String processDefinitionId, RedirectAttributes redirectAttributes) {
		if (state.equals("active")) {
			redirectAttributes.addFlashAttribute("message", "已激活ID为[" + processDefinitionId + "]的流程定义。");
			repositoryService.activateProcessDefinitionById(processDefinitionId, true, null);
		} else if (state.equals("suspend")) {
			repositoryService.suspendProcessDefinitionById(processDefinitionId, true, null);
			redirectAttributes.addFlashAttribute("message", "已挂起ID为[" + processDefinitionId + "]的流程定义。");
		}
		return "redirect:/workflow/process/list";
	}

	/**
	 * 初始化启动流程，读取启动流程的表单字段来渲染start form
	 */
	@RequestMapping(value = "/get-form/start/{processDefinitionId}")
	@ResponseBody
	public Map<String, Object> findStartForm(@PathVariable("processDefinitionId") String processDefinitionId) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		StartFormDataImpl startFormData = (StartFormDataImpl) formService.getStartFormData(processDefinitionId);

		startFormData.setProcessDefinition(null);

		result.put("startFormData", startFormData);

		// 读取enum类型数据，用于下拉框
		List<FormProperty> formProperties = startFormData.getFormProperties();
		for (FormProperty formProperty : formProperties) {
			Map<String, String> values = (Map<String, String>) formProperty.getType().getInformation("values");
			if (values != null) {
				for (Entry<String, String> enumEntry : values.entrySet()) {
					logger.debug(String.format("enum, key: {%s}, value: {%s}", enumEntry.getKey(), enumEntry.getValue()));
				}
				result.put("enum_" + formProperty.getId(), values);
			}
		}
		return result;
	}

	/**
	 * 提交启动流程
	 */
	@RequestMapping(value = "/start-process/{processDefinitionId}")
	public String submitStartFormAndStartProcessInstance(@PathVariable("processDefinitionId") String processDefinitionId, @RequestParam(value = "processType", required = false) String processType, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "提交启动流程");
		Map<String, String> formProperties = new HashMap<String, String>();

		// 从request中读取参数然后转换
		Map<String, String[]> parameterMap = request.getParameterMap();
		Set<Entry<String, String[]>> entrySet = parameterMap.entrySet();
		for (Entry<String, String[]> entry : entrySet) {
			String key = entry.getKey();

			// fp_的意思是form parameter
			if (StringUtils.defaultString(key).startsWith("fp_")) {
				formProperties.put(key.split("_")[1], entry.getValue()[0]);
			}
		}
		formProperties.put("employeeId", Jurisdiction.getUsername());

		logger.debug(String.format("start form parameters: {%s}", formProperties));

		ProcessInstance processInstance = null;
		try {
			identityService.setAuthenticatedUserId(Jurisdiction.getUsername());
			processInstance = formService.submitStartFormData(processDefinitionId, formProperties);
			logger.debug(String.format("start a processinstance: {%s}", processInstance));
		}
		finally {
			identityService.setAuthenticatedUserId(null);
		}
		redirectAttributes.addFlashAttribute("message", "启动成功，流程ID：" + processInstance.getId());
		return "redirect:/workflow/process/list";
	}

	/**
	 * 运行中的流程实例
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/process-instance/running/list")
	public ModelAndView runningProcessList(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String keywords = pd.getString("keywords"); // 检索条件 关键词
			if (StringUtils.isNoneBlank(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			// 分页查询
			page.setEntityOrField(true);
			Long totalResult = runtimeService.createProcessInstanceQuery().orderByProcessInstanceId().desc().active().count();
			page.setTotalResult(totalResult.intValue());
			page.getTotalPage();
			List<ProcessInstance> processList = runtimeService.createProcessInstanceQuery().orderByProcessInstanceId().desc().active().listPage((page.getCurrentPage() - 1) * page.getShowCount(), page.getShowCount());// 分页查询
			mv.setViewName("activiti/workflow/process/process-list-running");
			mv.addObject("processList", processList);
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 已结束的流程实例
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/process-instance/finished/list")
	public ModelAndView finishedProcessList(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String keywords = pd.getString("keywords"); // 检索条件 关键词
			if (StringUtils.isNoneBlank(keywords)) {
				pd.put("keywords", keywords.trim());
			}
			page.setPd(pd);
			// 分页查询
			page.setEntityOrField(true);
			Long totalResult = historyService.createHistoricProcessInstanceQuery().finished().orderByProcessInstanceEndTime().desc().count();
			page.setTotalResult(totalResult.intValue());
			page.getTotalPage();
			List<HistoricProcessInstance> processList = historyService.createHistoricProcessInstanceQuery().finished().orderByProcessInstanceEndTime().desc().listPage((page.getCurrentPage() - 1) * page.getShowCount(), page.getShowCount());// 分页查询
			mv.setViewName("activiti/workflow/process/process-list-finished");
			mv.addObject("processList", processList);
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 转换为模型
	 * 
	 * @param processDefinitionId
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws XMLStreamException
	 */
	@RequestMapping(value = "/convert-to-model/{processDefinitionId}")
	public String convertToModel(@PathVariable("processDefinitionId") String processDefinitionId) throws UnsupportedEncodingException, XMLStreamException {
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
		InputStream bpmnStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), processDefinition.getResourceName());
		XMLInputFactory xif = XMLInputFactory.newInstance();
		InputStreamReader in = new InputStreamReader(bpmnStream, "UTF-8");
		XMLStreamReader xtr = xif.createXMLStreamReader(in);
		BpmnModel bpmnModel = new BpmnXMLConverter().convertToBpmnModel(xtr);

		BpmnJsonConverter converter = new BpmnJsonConverter();
		ObjectNode modelNode = converter.convertToJson(bpmnModel);
		Model modelData = repositoryService.newModel();
		modelData.setKey(processDefinition.getKey());
		modelData.setName(processDefinition.getResourceName());
		modelData.setCategory(processDefinition.getDeploymentId());

		ObjectNode modelObjectNode = new ObjectMapper().createObjectNode();
		modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, processDefinition.getName());
		modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
		modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, processDefinition.getDescription());
		modelData.setMetaInfo(modelObjectNode.toString());

		repositoryService.saveModel(modelData);// 保存模型

		repositoryService.addModelEditorSource(modelData.getId(), modelNode.toString().getBytes("utf-8"));

		return "redirect:/workflow/model/list";
	}

	/**
	 * 删除部署的流程，级联删除流程实例
	 * 
	 * @param deploymentId
	 *            流程部署ID
	 * @return
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) {
		// 校验权限
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		}
		logBefore(logger, Jurisdiction.getUsername() + "删除流程");
		PageData pd = new PageData();
		pd = this.getPageData();
		repositoryService.deleteDeployment(pd.getString("deploymentId"), true);
		out.write("success");
		out.close();
	}

	/**
	 * 删除全部部署的流程，级联删除流程实例
	 * 
	 * @param deploymentId_ids
	 *            流程部署ID
	 * @return
	 */
	@RequestMapping(value = "/deleteAllP")
	@ResponseBody
	public Object deleteAllP() throws Exception {
		// 校验权限
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		}
		logBefore(logger, Jurisdiction.getUsername() + "删除全部部署的流程");
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String deploymentId_ids = pd.getString("deploymentId_ids");
			if (StringUtils.isNoneBlank(deploymentId_ids)) {
				String deploymentId_ids_array[] = deploymentId_ids.split(",");
				for (String deploymentId : deploymentId_ids_array) {
					repositoryService.deleteDeployment(deploymentId, true);
				}
				pd.put("msg", "ok");
			} else {
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 输出跟踪流程信息
	 *
	 * @param processInstanceId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/trace")
	@ResponseBody
	public List<Map<String, Object>> traceProcess(@RequestParam("pid") String processInstanceId) throws Exception {
		List<Map<String, Object>> activityInfos = workflowTraceService.traceProcess(processInstanceId);
		return activityInfos;
	}

	/**
	 * 读取带跟踪的图片
	 */
	@RequestMapping(value = "/trace/auto/{executionId}")
	public void readResource(@PathVariable("executionId") String executionId, HttpServletResponse response) throws Exception {
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(executionId).singleResult();
		BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
		List<String> activeActivityIds = runtimeService.getActiveActivityIds(executionId);
		// 不使用spring请使用下面的两行代码
		// ProcessEngineImpl defaultProcessEngine = (ProcessEngineImpl) ProcessEngines.getDefaultProcessEngine();
		// Context.setProcessEngineConfiguration(defaultProcessEngine.getProcessEngineConfiguration());

		// 使用spring注入引擎请使用下面的这行代码
		processEngineConfiguration = processEngine.getProcessEngineConfiguration();
		Context.setProcessEngineConfiguration((ProcessEngineConfigurationImpl) processEngineConfiguration);

		ProcessDiagramGenerator diagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();
		InputStream imageStream = diagramGenerator.generateDiagram(bpmnModel, "png", activeActivityIds, new ArrayList<String>(), processEngineConfiguration.getActivityFontName(), processEngineConfiguration.getLabelFontName(), processEngineConfiguration.getAnnotationFontName(), null, 1.0);

		// 输出资源内容到相应对象
		byte[] b = new byte[1024];
		int len;
		while ((len = imageStream.read(b, 0, 1024)) != -1) {
			response.getOutputStream().write(b, 0, len);
		}
	}

}