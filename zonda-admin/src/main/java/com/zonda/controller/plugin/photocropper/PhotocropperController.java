package com.zonda.controller.plugin.photocropper;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.zonda.controller.base.BaseController;
import com.zonda.entity.Page;
import com.zonda.service.information.pictures.PicturesManager;
import com.zonda.util.Const;
import com.zonda.util.DateUtil;
import com.zonda.util.FileUpload;
import com.zonda.util.Jurisdiction;
import com.zonda.util.OperateImage;
import com.zonda.util.PageData;
import com.zonda.util.PathUtil;
import com.zonda.util.Tools;
import com.zonda.util.Watermark;

/**
 * 图片裁剪插件控制层. <br>
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
public class PhotocropperController extends BaseController {

	String menuUrl = "plugin/photocropper.do"; // 菜单地址(权限用)

	@Resource(name = "picturesService")
	private PicturesManager picturesService;

	/**
	 * 图片裁剪插件入口
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/photocropper")
	public ModelAndView getPhotocropperPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			mv.setViewName("plugin/photo-cropper");
			mv.addObject("pd", pd);
			mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
			mv.addObject("w", 640);// 默认裁剪宽
			mv.addObject("h", 300);// 默认裁剪高
		}
		catch (Exception e) {
			logger.error("[图片裁剪]图片裁剪插件入口发生异常：" + e.getMessage());
		}
		return mv;
	}

	/**
	 * 图片上传
	 * 
	 * @param filedata
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/imgUpload")
	@ResponseBody
	public Object imgUpload(@RequestParam(required = false) MultipartFile Filedata) throws Exception {
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		logBefore(logger, Jurisdiction.getUsername() + "新增图片");
		String ffile = DateUtil.getDays(), filePath = "", fileName = "";
		PageData pd = new PageData();
		if (Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			if (null != Filedata && !Filedata.isEmpty()) {
				filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile; // 文件上传路径
				fileName = FileUpload.fileUp(Filedata, filePath, this.get32UUID()); // 执行上传
			} else {
				System.out.println("上传失败");
			}
			pd.put("PICTURES_ID", this.get32UUID()); // 主键
			pd.put("TITLE", "图片"); // 标题
			pd.put("NAME", fileName); // 文件名
			pd.put("PATH", ffile + "/" + fileName); // 路径
			pd.put("CREATETIME", Tools.date2Str(new Date())); // 创建时间
			pd.put("MASTER_ID", "1"); // 附属与
			pd.put("BZ", "图片裁剪管理处上传"); // 备注
			Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);// 加水印
			picturesService.save(pd);
		}
		return pd;
	}

	/**
	 * 图片裁剪
	 * 
	 * @param req
	 * @param resp
	 * @param session
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/ajaxSaveImgUploadJT", method = RequestMethod.POST)
	@ResponseBody
	public Object ajaxSaveImgUploadJT(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		PageData pd = new PageData();
		try {
			String x = req.getParameter("x");
			String y = req.getParameter("y");
			String w = req.getParameter("w");
			String h = req.getParameter("h");
			String imgPath = req.getParameter("imgPath");
			String PICTURES_ID = req.getParameter("PICTURES_ID");

			if (StringUtils.isNotBlank(imgPath) && StringUtils.isNotBlank(x) && StringUtils.isNotBlank(y) && StringUtils.isNotBlank(w) && StringUtils.isNotBlank(h)) {
				OperateImage o = new OperateImage(new Integer(x), new Integer(y), new Integer(w), new Integer(h));
				o.setSrcpath(PathUtil.getClasspath() + Const.FILEPATHIMG + imgPath);
				String newImgPath = o.getNewImgPath(imgPath);
				o.setSubpath(PathUtil.getClasspath() + Const.FILEPATHIMG + newImgPath);
				o.cut();
				if (StringUtils.isNotBlank(newImgPath)) {
					logger.info("图片剪切成功：" + PathUtil.getClasspath() + Const.FILEPATHIMG + newImgPath);
					pd.put("PICTURES_ID", PICTURES_ID); // 主键
					pd.put("TITLE", "裁剪图片"); // 标题
					pd.put("NAME", newImgPath.split("\\/")[1]); // 文件名
					pd.put("PATH", newImgPath); // 路径
					pd.put("CREATETIME", Tools.date2Str(new Date())); // 创建时间
					pd.put("MASTER_ID", "1"); // 附属与
					pd.put("BZ", "图片裁剪管理处上传"); // 备注
					Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + newImgPath);// 加水印
					picturesService.edit(pd); // 执行修改数据库
				}
			} else {
				logger.info("图片剪切失败：参数不全！");
			}
		}
		catch (IOException e) {
			logger.error("图片剪切出现异常:" + e.getMessage());
		}
		return pd;
	}

}