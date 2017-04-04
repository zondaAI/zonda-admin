<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../system/index/top.jsp"%>
<style type="text/css">
	body{font-size:14px;background-color:#fff}
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

							<link rel="stylesheet" type="text/css" href="static/plugin/photoswipe/css/styles.css?v=20161018"/>
							<link rel="stylesheet" type="text/css" href="static/plugin/photoswipe/css/jquery.photoswipe.css?v=20161018"/>
							<div id="thumbs">
								<a href="static/plugin/photoswipe/images/1.jpg" style="background-image:url(static/plugin/photoswipe/images/1.jpg)" title="风景一"></a>
								<a href="static/plugin/photoswipe/images/2.jpg" style="background-image:url(static/plugin/photoswipe/images/2.jpg)" title="风景二"></a>
								<a href="static/plugin/photoswipe/images/3.jpg" style="background-image:url(static/plugin/photoswipe/images/3.jpg)" title="风景三"></a>
								<a href="static/plugin/photoswipe/images/4.jpg" style="background-image:url(static/plugin/photoswipe/images/4.jpg)" title="风景四"></a>
								<a href="static/plugin/photoswipe/images/5.jpg" style="background-image:url(static/plugin/photoswipe/images/5.jpg)" title="风景五"></a>
								<a href="static/plugin/photoswipe/images/6.jpg" style="background-image:url(static/plugin/photoswipe/images/6.jpg)" title="风景六"></a>
								<a href="static/plugin/photoswipe/images/7.jpg" style="background-image:url(static/plugin/photoswipe/images/7.jpg)" title="风景七"></a>
								<a href="static/plugin/photoswipe/images/8.jpg" style="background-image:url(static/plugin/photoswipe/images/8.jpg)" title="风景八"></a>
								<a href="static/plugin/photoswipe/images/9.jpg" style="background-image:url(static/plugin/photoswipe/images/9.jpg)" title="风景九"></a>
							</div>

							<p id="credit">jquery实现的触摸相册效果,适用于手机端H5，电脑PC等</p>
							<script type="text/javascript" src="static/plugin/photoswipe/js/html5.js?v=20161018"></script>
							<script type="text/javascript" src="static/plugin/photoswipe/js/jquery-1.7.1.min.js?v=20161018"></script>
							<script type="text/javascript" src="static/plugin/photoswipe/js/jquery.photoswipe.js?v=20161018"></script>
							<!--<script src="js/common/init.js"></script>-->
							<script>
								$(function() {
									$('#thumbs a').touchTouch({
										showIndex : true,
										showRadius : false,
										showThumbs : true
									});
								});
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