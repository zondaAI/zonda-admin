package com.zonda.activiti.rest.editor.controller;

import java.io.ByteArrayInputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.zonda.controller.base.BaseController;
import com.zonda.entity.Page;
import com.zonda.util.AppUtil;
import com.zonda.util.Jurisdiction;
import com.zonda.util.PageData;

/**
 * 流程模型管理控制器. <br>
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
@RequestMapping("/workflow/model")
public class ModuleController extends BaseController {

	String menuUrl = "workflow/model/list.do"; // 菜单地址(权限用)

	@Autowired
	private RepositoryService repositoryService;

	/**
	 * 模型列表
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
			Long totalResult = repositoryService.createModelQuery().count();
			page.setTotalResult(totalResult.intValue());
			page.getTotalPage();
			List<Model> taskList = repositoryService.createModelQuery().listPage((page.getCurrentPage() - 1) * page.getShowCount(), page.getShowCount());// 分页查询
			mv.setViewName("activiti/workflow/model/model-list");
			mv.addObject("taskList", taskList);
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 去新增模型页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAddM")
	public ModelAndView goAddM() throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("activiti/workflow/model/model-add");
		mv.addObject("msg", "saveM");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 创建模型
	 */
	@RequestMapping(value = "/saveM")
	public void create(HttpServletRequest request, HttpServletResponse response) {
		PageData pd = new PageData();
		try {
			logBefore(logger, Jurisdiction.getUsername() + "创建标准流程模型");
			pd = this.getPageData();
			ObjectMapper objectMapper = new ObjectMapper();
			ObjectNode editorNode = objectMapper.createObjectNode();
			editorNode.put("id", "canvas");
			editorNode.put("resourceId", "canvas");
			ObjectNode stencilSetNode = objectMapper.createObjectNode();
			stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
			editorNode.set("stencilset", stencilSetNode);
			Model modelData = repositoryService.newModel();

			ObjectNode modelObjectNode = objectMapper.createObjectNode();
			modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, pd.getString("name"));
			modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, StringUtils.defaultString(pd.getString("description")));
			modelData.setMetaInfo(modelObjectNode.toString());
			modelData.setName(pd.getString("name"));
			modelData.setKey(StringUtils.defaultString(pd.getString("key")));

			repositoryService.saveModel(modelData);
			repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));

			response.sendRedirect(request.getContextPath() + "/static/activiti/modeler.html?modelId=" + modelData.getId());
		}
		catch (Exception e) {
			logger.error("创建模型失败", e);
		}
	}

	/**
	 * 根据Model部署流程
	 */
	@RequestMapping(value = "/deploy")
	public String deploy(RedirectAttributes redirectAttributes) {
		PageData pd = new PageData();
		try {
			logBefore(logger, Jurisdiction.getUsername() + "部署流程");
			pd = this.getPageData();
			Model modelData = repositoryService.getModel(pd.getString("modelId"));// 模型ID
			ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
			byte[] bpmnBytes = null;

			BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
			bpmnBytes = new BpmnXMLConverter().convertToXML(model);

			String processName = modelData.getName() + ".bpmn20.xml";
			Deployment deployment = repositoryService.createDeployment().name(modelData.getName()).addString(processName, new String(bpmnBytes)).deploy();
			redirectAttributes.addFlashAttribute("message", "部署成功，部署ID=" + deployment.getId());
		}
		catch (Exception e) {
			logger.error("根据模型部署流程失败", e);
		}
		return "redirect:/workflow/model/list";
	}

	/**
	 * 导出model的XML文件
	 */
	@RequestMapping(value = "/export/{modelId}")
	public void export(@PathVariable("modelId") String modelId, HttpServletResponse response) {
		try {
			Model modelData = repositoryService.getModel(modelId);
			BpmnJsonConverter jsonConverter = new BpmnJsonConverter();
			JsonNode editorNode = new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
			BpmnModel bpmnModel = jsonConverter.convertToBpmnModel(editorNode);
			BpmnXMLConverter xmlConverter = new BpmnXMLConverter();
			byte[] bpmnBytes = xmlConverter.convertToXML(bpmnModel);

			ByteArrayInputStream in = new ByteArrayInputStream(bpmnBytes);
			IOUtils.copy(in, response.getOutputStream());
			String filename = bpmnModel.getMainProcess().getId() + ".bpmn20.xml";
			response.setHeader("Content-Disposition", "attachment; filename=" + filename);
			response.flushBuffer();
		}
		catch (Exception e) {
			logger.error("导出model的xml文件失败", e);
		}
	}

	/**
	 * 根据Model删除流程
	 */
	@RequestMapping(value = "/delete")
	public void deleteM(PrintWriter out) throws Exception {
		// 校验权限
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		}
		logBefore(logger, Jurisdiction.getUsername() + "删除流程");
		PageData pd = new PageData();
		pd = this.getPageData();
		repositoryService.deleteModel(pd.getString("modelId"));
		out.write("success");
		out.close();
	}

	/**
	 * 根据Model删除全部流程
	 */
	@RequestMapping(value = "/deleteAllM")
	@ResponseBody
	public Object deleteAllM() throws Exception {
		// 校验权限
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		}
		logBefore(logger, Jurisdiction.getUsername() + "删除全部流程");
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String model_ids = pd.getString("model_ids");
			if (StringUtils.isNoneBlank(model_ids)) {
				String model_ids_array[] = model_ids.split(",");
				for (String modelId : model_ids_array) {
					repositoryService.deleteModel(modelId);
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

}