package com.zonda.controller.plugin.regionselect;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zonda.controller.base.BaseController;
import com.zonda.entity.Page;
import com.zonda.service.plugin.regionselect.RegionSelectManager;
import com.zonda.util.Jurisdiction;
import com.zonda.util.PageData;

/**
 * 地市选择插件控制层. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2016年10月24日 上午11:43:14
 * <p>
 * Company: 风之子AI亚洲研究院
 * <p>
 * 
 * @author zonda
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "/plugin")
public class RegionSelectController extends BaseController {

	String menuUrl = "plugin/regionSelect.do"; // 菜单地址(权限用)

	@Resource(name = "regionSelectService")
	private RegionSelectManager regionSelectService;

	/**
	 * 地市选择插件入口
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/regionSelect")
	public ModelAndView getRegionSelectPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			mv.setViewName("plugin/region-select");
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 加载省份选择数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/selectProvince", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Object getSelectProvince(HttpServletRequest request, HttpServletResponse response) {
		JSONObject resultObj = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("REGION_CODE", "0");
			List<PageData> regionList = regionSelectService.findByParentRegion(pd);
			resultObj.put("addressList", regionList);
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return resultObj;
	}

	/**
	 * 加载地市选择数据
	 * 
	 * @param idProvince
	 *            省份编号
	 * @return
	 */
	@RequestMapping(value = "/selectCity", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Object getSelectCity(HttpServletRequest request, HttpServletResponse response) {
		JSONObject resultObj = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			List<PageData> regionList = regionSelectService.findByParentRegion(pd);
			resultObj.put("addressList", regionList);
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return resultObj;
	}

	/**
	 * 加载区选择数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/selectArea", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Object getSelectArea(HttpServletRequest request, HttpServletResponse response) {
		JSONObject resultObj = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			List<PageData> regionList = regionSelectService.findByParentRegion(pd);
			resultObj.put("addressList", regionList);
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return resultObj;
	}

	/**
	 * 加载镇选择数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/selectTown", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Object getSelectTown(HttpServletRequest request, HttpServletResponse response) {
		JSONObject resultObj = new JSONObject();
		try {
			PageData pd = new PageData();
			pd = this.getPageData();
			List<PageData> regionList = regionSelectService.findByParentRegion(pd);
			resultObj.put("addressList", regionList);
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return resultObj;
	}

}