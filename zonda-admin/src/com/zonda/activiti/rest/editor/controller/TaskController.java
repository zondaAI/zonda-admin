package com.zonda.activiti.rest.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.activiti.engine.FormService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.impl.form.TaskFormDataImpl;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zonda.controller.base.BaseController;
import com.zonda.entity.Page;
import com.zonda.util.Jurisdiction;
import com.zonda.util.PageData;

/**
 * 任务办理管理控制器. <br>
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
@RequestMapping("/workflow/task")
public class TaskController extends BaseController {

	String menuUrl = "workflow/task/list.do"; // 菜单地址(权限用)

	@Autowired
	private TaskService taskService;

	@Autowired
	private FormService formService;

	@Autowired
	private IdentityService identityService;

	/**
	 * 任务待办列表
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
			Long totalResult = taskService.createTaskQuery().taskCandidateOrAssigned(Jurisdiction.getUsername()).active().orderByTaskId().desc().count();
			page.setTotalResult(totalResult.intValue());
			page.getTotalPage();
			List<Task> taskList = taskService.createTaskQuery().taskCandidateOrAssigned(Jurisdiction.getUsername()).active().orderByTaskId().desc().listPage((page.getCurrentPage() - 1) * page.getShowCount(), page.getShowCount());// 分页查询
			mv.setViewName("activiti/workflow/task/task-list");
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
	 * 签收任务
	 */
	@RequestMapping(value = "/claim/{id}")
	public String claim(@PathVariable("id") String taskId, HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		taskService.claim(taskId, Jurisdiction.getUsername());
		redirectAttributes.addFlashAttribute("message", "任务已签收");
		return "redirect:/workflow/task/list";
	}

	/**
	 * 读取Task的表单
	 */
	@RequestMapping(value = "get-form/task/{taskId}")
	@ResponseBody
	public Map<String, Object> findTaskForm(@PathVariable("taskId") String taskId) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		TaskFormDataImpl taskFormData = (TaskFormDataImpl) formService.getTaskFormData(taskId);

		// 设置task为null，否则输出json的时候会报错
		taskFormData.setTask(null);

		result.put("taskFormData", taskFormData);

		// 读取enum类型数据，用于下拉框
		List<FormProperty> formProperties = taskFormData.getFormProperties();
		for (FormProperty formProperty : formProperties) {
			Map<String, String> values = (Map<String, String>) formProperty.getType().getInformation("values");
			if (values != null) {
				for (Entry<String, String> enumEntry : values.entrySet()) {
					logger.debug(String.format("enum, key: {%s}, value: {%s}", enumEntry.getKey(), enumEntry.getValue()));
				}
				result.put(formProperty.getId(), values);
			}
		}

		return result;
	}

	/**
	 * 办理任务，提交task的并保存form
	 */
	@RequestMapping(value = "/complete/{taskId}")
	public String completeTask(@PathVariable("taskId") String taskId, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "提交任务办理");
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

		logger.debug(String.format("start form parameters: {%s}", formProperties));

		try {
			identityService.setAuthenticatedUserId(Jurisdiction.getUsername());
			formService.submitTaskFormData(taskId, formProperties);
		}
		finally {
			identityService.setAuthenticatedUserId(null);
		}
		redirectAttributes.addFlashAttribute("message", "任务完成：taskId=" + taskId);
		return "redirect:/workflow/task/list";
	}

}