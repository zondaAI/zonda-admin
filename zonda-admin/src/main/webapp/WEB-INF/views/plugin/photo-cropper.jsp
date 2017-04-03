<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<style type="text/css">
body {
	font-size: 14px;
	background-color: #fff
}
</style>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">

							<link rel="stylesheet" type="text/css" href="static/plugin/regionselect/css/zonda.toast.css?v=20161018"/>
							<script src="static/plugin/photocropper/js/jquery-1.8.3.js?v=20161018" type="text/javascript" charset="utf-8"></script>
							<script src="static/plugin/photocropper/js/bootstrap.min.js?v=20161018" type="text/javascript" charset="utf-8"></script>
							<script src="static/plugin/photocropper/js/uploadify/jquery.uploadify.modify.js?v=20161018" type="text/javascript" charset="utf-8"></script>
							<link href="static/plugin/photocropper/js/uploadify/uploadify.css?v=20161018" rel="stylesheet" type="text/css" />
							<style type="text/css">
								#container .block {
									height: ${h +2}px;
								    width: ${w +2}px;
								}
								
								#container .cropper {
									top: ${h/2 -20}px;
								    left: ${w/2 -40}px;
								}
								
								#container {
									height: ${h +180}px;
								}
								
								#container img {
									max-height: ${h + 180}px;
								}
							</style>
							<script type="text/javascript">
								$().ready(function() {
									//上传图片
									$("#uploadBannerPic").uploadify({
										width           : 90,
										height          : 35,
										removeCompleted : true,
										swf             : G_CTX_ROOT + '/static/plugin/photocropper/js/uploadify/uploadify.swf',
										uploader        : G_CTX_ROOT + '/plugin/imgUpload.chtml;jsessionid=<%=request.getRequestedSessionId()%>',
										onUploadSuccess : function(file, data, response) {
											if(data){
												var timestamp = new Date().getTime();
												var obj = JSON.parse(data);
												var path = G_CTX_ROOT + '/uploadFiles/uploadImgs/' + obj.PATH + '?d=' + timestamp;
												$("#hid_tempfile").val(path);
												$("#hid_imgPath").val(obj.PATH);
												$("#PICTURES_ID").val(obj.PICTURES_ID);
												var $bgDiv = $("#bgDiv");
												$bgDiv.find("img").each(function(i) {
													$(this).attr("src", path);
												});
											}
										}
									});
								});
							</script>
							<div class="tc_content">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tc_tb9">
									<tr>
										<th width="60px">选择图片</th>
										<td class="tc_border" style="vertical-align: middle;">
											<div style="width: 120px; position:relative; left: 10px; top: 10px;">
												<input type="file" id="uploadBannerPic" name="uploadBannerPic" style="display:none; margin-left: 10px;" size="0" />
											</div>
											<div style="padding-left: 10px;padding-top: 5px;">
												<span style="color:red;padding-left: 10px;">建议尺寸：${w} X ${h}（仅支持一张）</span>
												<span style="color:red;margin-left:5%;" id="qytsid">选中区域： 宽度：<input type="text" name="pw" id="pw" value="${w}" style="width:60px;line-height:26px;height:26px;" onkeyup="limitInputW(this);" onafterpaste="limitInputW(this);" /> 高度：<input type="text" name="ph" id="ph" value="${h}" style="width:60px;line-height:26px;height:26px;" onkeyup="limitInputH(this);" onafterpaste="limitInputH(this);" /></span>
											</div>
										</td>
									</tr>

									<tr>
										<th>裁剪图片</th>
										<td style="text-align: center;">
											<div id="bgDiv" style="position: relative; overflow: hidden; background-color: #bae2f0;">
												<ul>
													<li>
														<div id="container">
															<img style="position: absolute; left: 0px; top: 0px; " src="static/plugin/photocropper/images/zwtp.png">
														</div>
													</li>
												</ul>
											</div>
										</td>
									</tr>
								</table>
							</div>
							<div style="display: none">
								<input type="hidden" name="hid_x" id="hid_x" value="0" />
								<input type="hidden" name="hid_y" id="hid_y" value="0" />
								<input type="hidden" name="hid_w" id="hid_w" value="${w}" />
								<input type="hidden" name="hid_h" id="hid_h" value="${h}" />
								<input type="hidden" name="hid_tempfile" id="hid_tempfile" value="" />
								<input type="hidden" name="hid_imgPath" id="hid_imgPath" value="" />
								<input type="hidden" name="PICTURES_ID" id="PICTURES_ID" value="" />
							</div>
							<!-- 模态框（Modal） -->
							<div class="modal" id="dealing-modal" aria-hidden="false" style="background:rgba(0,0,0,0.4);">
								<div class="modal-dialog" style="margin:16% 47%;">
									<img src="static/plugin/photocropper/images/loading.gif" />
								</div>
							</div>
							<!-- <link href="static/plugin/photocropper/css/bootstrap.min.css?v=20161018" rel="stylesheet"/> -->
							<link href="static/plugin/photocropper/css/jquery.cropper.css?v=20161018" rel="stylesheet"/>
							<script src="static/plugin/photocropper/js/jquery.cropper.js?v=20161018" type="text/javascript" charset="utf-8"></script>
							<script type="text/javascript" src="static/plugin/regionselect/js/zepto.min.js?v=20161018"></script>
							<script type="text/javascript" src="static/plugin/regionselect/js/zonda.toast.js?v=20161018" charset="GBK"></script>
							<script type="text/javascript">
								function toastTips(b) {
									clearTimeout(a);
									var a = setTimeout(function() {
										$.toast({
											message : b,
											height : 105,
											width : 200,
											textAlign : "left",
											cls : "error-icon"
										})
									}, 500)
								}
							</script>
							
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
	</script>
</body>
</html>