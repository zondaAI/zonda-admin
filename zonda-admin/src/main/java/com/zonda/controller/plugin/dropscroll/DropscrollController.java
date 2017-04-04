package com.zonda.controller.plugin.dropscroll;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zonda.controller.base.BaseController;
import com.zonda.entity.Page;
import com.zonda.util.Jurisdiction;
import com.zonda.util.PageData;

/**
 * 手机端H5下拉刷新上拉加载更多插件控制层. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2016年11月07日 上午10:26:45
 * <p>
 * Company: 风之子AI亚洲研究院
 * <p>
 * 
 * @author zonda
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "/plugin")
public class DropscrollController extends BaseController {

	String menuUrl = "plugin/dropscroll.do"; // 菜单地址(权限用)

	public static final String Load_Up_Fn_Data = "admin/json/more.json"; // 下拉更新配置路径

	public static final String Load_Down_Fn_Data = "admin/json/update.json"; // 上拉加载更多配置路径

	/**
	 * 手机端H5下拉刷新上拉加载更多插件入口
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/dropscroll")
	public ModelAndView getDropscrollPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			mv.setViewName("plugin/drop-scroll");
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

}