package com.zonda.controller.plugin.audioplayer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zonda.controller.base.BaseController;
import com.zonda.entity.Page;
import com.zonda.util.Jurisdiction;
import com.zonda.util.PageData;

/**
 * 音乐播放器插件控制层. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2016年11月10日 上午11:43:14
 * <p>
 * Company: 风之子AI亚洲研究院
 * <p>
 * 
 * @author zonda
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "/plugin")
public class AudioPlayerController extends BaseController {

	String menuUrl = "plugin/audioplayer.do"; // 菜单地址(权限用)

	/**
	 * 音乐播放器插件入口
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/audioplayer")
	public ModelAndView getPhotoswipePage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			mv.setViewName("plugin/audio-player");
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		}
		catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

}