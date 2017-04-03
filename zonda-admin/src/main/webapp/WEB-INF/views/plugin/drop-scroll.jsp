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

*{
    margin: 0;
    padding:0;
    -webkit-tap-highlight-color:rgba(0,0,0,0);
    -webkit-text-size-adjust:none;
}
html{
    font-size:10px;
}
body{
    background-color: #f5f5f5;
    font-size: 1.2em;
}
.header{
    height: 44px;
    line-height: 44px;
    border-bottom: 1px solid #ccc;
    background-color: #eee;
}
.header h1{
    text-align: center;
    font-size: 2rem;
    font-weight: normal;
    line-height: 2.2;
}
.content{
    padding-bottom: 40px;
    background-color: #fff;
}
.content .item{
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align:center;
    -webkit-box-align:center;
    box-align:center;
    -webkit-align-items:center;
    align-items:center;
    padding:3.125%;
    border-bottom: 1px solid #ddd;
    color: #333;
    text-decoration: none;
}
.content .item img{
    display: block;
    width: 40px;
    height: 40px;
    border:1px solid #ddd;
}
.content .item h3{
    display: block;
    -webkit-box-flex: 1;
    -webkit-flex: 1;
    -ms-flex: 1;
    flex: 1;
    width: 100%;
    max-height: 40px;
    overflow: hidden;
    line-height: 20px;
    margin: 0 10px;
    font-size: 1.2rem;
}
.content .item .date{
    display: block;
    height: 20px;
    line-height: 20px;
    color: #999;
}
.opacity{
    -webkit-animation: opacity 0.3s linear;
    animation: opacity 0.3s linear;
}
@-webkit-keyframes opacity {
    0% {
        opacity:0;
    }
    100% {
        opacity:1;
    }
}
@keyframes opacity {
    0% {
        opacity:0;
    }
    100% {
        opacity:1;
    }
}
.drop-footer{
    position: fixed;
    left: 0;
    bottom: 0;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    width: 100%;
    height: 40px;
}
.drop-footer a{
    position: relative;
    display: block;
    -webkit-box-flex: 1;
    -webkit-flex: 1;
    -ms-flex: 1;
    flex: 1;
    line-height: 40px;
    text-align: center;
    color: #666;
    background-color: #eee;
    text-decoration: none;
}
.drop-footer a:before{
    content: '';
    position: absolute;
    left: 0;
    top: 10px;
    width: 1px;
    height: 20px;
    background-color: #ccc;
}
.drop-footer a:first-child:before{
    display: none;
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

							<link rel="stylesheet" type="text/css" href="static/plugin/dropscroll/css/jquery.toast.css?v=20161018" />
							<link rel="stylesheet" type="text/css" href="static/plugin/dropscroll/css/jquery.dropscroll.css?v=20161018" />
							<div class="header">
								<h1>标题</h1>
							</div>
							<div class="content">
								<div class="lists">
									<a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>1文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>2文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>3文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>4文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>5文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>6文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>7文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>8文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>9文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>10文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>11文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a> <a class="item" href="#"> <img src="http://d6.yihaodianimg.com/N02/M0B/81/5A/CgQCsVMhX_mAAvXsAAJDE3K2zh485900_80x80.jpg" alt="">
										<h3>12文字描述文字描述文字描述文字描述文字描述</h3> <span class="date">2014-14-14</span>
									</a>
								</div>
							</div>
							<div class="drop-footer">
								<a href="javascript:void(0);" class="item" onclick="doComplexPopup();">复杂弹层</a>
								<a href="javascript:void(0);" class="item" onclick="$popup({title:'无底部按钮', content:'本窗口没有底部按钮!', bottom:false});">无底部按钮弹层</a>
								<a href="javascript:void(0);" class="item" onclick="$popup({title:false, content:'本窗口没有标题栏提示!'});">无标题栏弹层</a>
								<a href="javascript:void(0);" class="item" onclick="doPopup();">确认型弹层</a>
							</div>
							<!-- jQuery1.7以上 或者 Zepto 二选一，不要同时都引用 -->
							<script type="text/javascript" src="static/ace/js/jquery.js?v=20161018"></script>
							<!-- <script type="text/javascript" src="static/plugin/dropscroll/js/zepto.min.js?v=20161018"></script> -->
							<script type="text/javascript" src="static/plugin/dropscroll/js/jquery.toast.js?v=20161018"></script>
							<script type="text/javascript" src="static/plugin/dropscroll/js/jquery.dropscroll.js?v=20161018"></script>
							<script type="text/javascript" src="static/plugin/dropscroll/js/jquery.popup.js?v=20161018"></script>
							<script type="text/javascript">
								$(function() {
									var counter = 0;
									// 每页展示4个
									var num = 4;
									var pageStart = 0, pageEnd = 0;

									// dropload
									$('.content').dropload({
										scrollArea : window,
										domUp : {
											domClass : 'dropload-up',
											domRefresh : '<div class="dropload-refresh">↓下拉刷新-自定义内容</div>',
											domUpdate : '<div class="dropload-update">↑释放更新-自定义内容</div>',
											domLoad : '<div class="dropload-load"><span class="drop-loading"></span>加载中-自定义内容...</div>'
										},
										domDown : {
											domClass : 'dropload-down',
											domRefresh : '<div class="dropload-refresh">↑上拉加载更多-自定义内容</div>',
											domLoad : '<div class="dropload-load"><span class="drop-loading"></span>加载中-自定义内容...</div>',
											domNoData : '<div class="dropload-noData">暂无更多数据-自定义内容</div>'
										},
										loadUpFn : function(me) {
											var ajaxLoadUpFn = $.ajax({
												type : 'GET',
												url : G_CTX_ROOT + '/admin/json/update.json',
												dataType : 'json',
												beforeSend : function() {
													toastLoading();
												},
												success : function(data) {
													toastLoadingClose();
													var result = '';
													for (var i = 0; i < data.lists.length; i++) {
														result += '<a class="item opacity" href="'+data.lists[i].link+'">' + '<img src="'+data.lists[i].pic+'" alt="">' + '<h3>' + data.lists[i].title + '</h3>' + '<span class="date">' + data.lists[i].date + '</span>' + '</a>';
													}
													// 为了测试，延迟1秒加载
													setTimeout(function() {
														$('.lists').html(result);
														// 每次数据加载完，必须重置
														me.resetload();
														// 重置索引值，重新拼接more.json数据
														counter = 0;
														// 解锁
														me.unlock();
														me.noData(false);
													}, 1000);
												},
												error : function(xhr, type) {
													toastLoadingClose();
													toastTips('loadUpFn Ajax error!');
													// 即使加载出错，也得重置
													me.resetload();
												},
												complete : function(XMLHttpRequest, status) { // 请求完成后最终执行参数
													toastLoadingClose();
													if (status == 'timeout') {// 超时
														ajaxLoadUpFn.abort();
														toastTips('当前网络正忙，请稍后再试!');
													}
												}
											});
										},
										loadDownFn : function(me) {
											var ajaxLoadDownFn = $.ajax({
												type : 'GET',
												url : G_CTX_ROOT + '/admin/json/more.json',
												dataType : 'json',
												beforeSend : function() {
													toastLoading();
												},
												success : function(data) {
													toastLoadingClose();
													var result = '';
													counter++;
													pageEnd = num * counter;
													pageStart = pageEnd - num;

													for (var i = pageStart; i < pageEnd; i++) {
														result += '<a class="item opacity" href="'+data.lists[i].link+'">' + '<img src="'+data.lists[i].pic+'" alt="">' + '<h3>' + data.lists[i].title + '</h3>' + '<span class="date">' + data.lists[i].date + '</span>' + '</a>';
														if ((i + 1) >= data.lists.length) {
															// 锁定
															me.lock();
															// 无数据
															me.noData();
															break;
														}
													}
													// 为了测试，延迟1秒加载
													setTimeout(function() {
														$('.lists').append(result);
														// 每次数据加载完，必须重置
														me.resetload();
													}, 1000);
												},
												error : function(xhr, type) {
													toastLoadingClose();
													toastTips('loadDownFn Ajax error!');
													// 即使加载出错，也得重置
													me.resetload();
												},
												complete : function(XMLHttpRequest, status) { // 请求完成后最终执行参数
													toastLoadingClose();
													if (status == 'timeout') {// 超时
														ajaxLoadDownFn.abort();
														toastTips('当前网络正忙，请稍后再试!');
													}
												}
											});
										},
										threshold : 50
									});
								});
								/** 测试复杂弹层 */
								function doComplexPopup() {
									$popup({
										id : "pop_msg",
										title : "弹窗提醒",
										content : "提示：数据请求成功，正等待服务器回应！",
										type : "success",
										padding : 50,
										btn : ["确定按钮","按钮1","按钮2", "按钮3"],
										btn1 : function(){
											$popup("我只是一个简单的提示!");
										},
										btn2 : function(){
											toastTips("我是关闭执行");
										},
										btn3 : function(){
											$popup("我是两个参数调用后的执行效果，确定要删除这条数据吗？", function(i){
												$popup.msg("恭喜，数据删除成功！", {type: "success", lock : 1});
											});
										},
										btn4 : function(i){
											toastTips("关闭");
										},
										fixed : true
									});
								}
								/** 测试简单弹层 */
								function doPopup() {
									$popup({
										id : 'popup_follow',
										type : 'confirm',
										content : '确定不再关注此人?',
										btn : ['确定','取消'],
										onOk : function() {
											$popup.msg('执行回调函数', {lock : 1}, toastTips('执行结束'));
										}
									});
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