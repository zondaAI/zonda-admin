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

							<link rel="stylesheet" type="text/css" href="static/plugin/regionselect/css/header.css?v=20161018"/>
							<link rel="stylesheet" type="text/css" href="static/plugin/regionselect/css/advanced-search.css?v=20161018"/>
							<link rel="stylesheet" type="text/css" href="static/plugin/regionselect/css/free-reginst-index.css?v=20161018"/>
							<link rel="stylesheet" type="text/css" href="static/plugin/regionselect/css/zonda.toast.css?v=20161018"/>
							<link rel="stylesheet" type="text/css" href="static/plugin/regionselect/css/5.0pop_layer_noprice.css?v=20161018"/>
							<!-- 5.0给结算地址页套上下面div   开始-->
							<div class="check-page" id="checkPage">
								<form action='' method="post" id="editAddressForm">
									<input type="hidden" name="address.idProvince" id="address.idProvince" value="" />
									<input type="hidden" name="address.idCity" id="address.idCity" value="" />
									<input type="hidden" name="address.idArea" id="address.idArea" value="" />
									<input type="hidden" name="address.idTown" id="address.idTown" value="" />
									<input type="hidden" name="address.provinceNameIgnore" id="address.provinceNameIgnore" value="" />
									<input type="hidden" name="address.cityNameIgnore" id="address.cityNameIgnore" value="" />
									<input type="hidden" name="address.areaNameIgnore" id="address.areaNameIgnore" value="" />
									<input type="hidden" name="address.townNameIngore" id="address.townNameIngore" value="" />

									<div class="common-wrapper">
										<div class="address02">
											<div class="fixed-top">
												<div class="s-item bdb-1px">
													<div class="sitem-l sitem-pad">
														<div class="sattr-add">收货人:</div>
														<div class="svalue add-color">
															<input type="text" id="uersNameId" name="address.name" value="" class="ad-name" />
														</div>
													</div>
													<span class="s-close" id="user-s-close"><i></i></span>
												</div>
												<div class="s-item bdb-1px">
													<div class="sitem-l sitem-pad">
														<div class="sattr-add">手机号码:</div>
														<div id="mobileInputDiv" class="svalue add-color">
															<input type="tel" id="mobilePhoneId" maxlength="11" name="address.mobile" value="" class="ad-mobile" />
														</div>
													</div>
												</div>
											</div>
											<!-- 5.0加address-big div -->
											<div class="address-big bdb-1px">
												<div class="fixed-bottom">
													<div class="col02" id="selectAddressBtn" region-data="">
														<div class="s-item bdb-1px">
															<div class="sitem-l sitem-pad add-box">
																<div class="sattr-add">所在地区:</div>
																<div class="svalue-add">
																	<span class="grey-add" id="addressLabelId"> </span>
																</div>
															</div>
															<span class="s-point"></span>
														</div>
													</div>

													<!-- 9.2详细地址输入框自适应高度 -->
													<!-- 5.0删bdb-1px -->
													<div class="s-item  change-padd">
														<div class="sitem-l sitem-pad change-wid">
															<div class="sattr-add change-padding">详细地址:</div>
															<div class="svalue w65 change-po change-padding" style="font-size:0">
																<span class="grey" id="detailedAddressId"> </span>
																<!--meijishuang 20150828-->
																<textarea class="textauto change-sty" name="address.where" rows="1" id="address_details"></textarea>
															</div>
														</div>
														<span class="s-text-close" id="s-text-close"><i></i></span>
													</div>
												</div>
												<div style="clear:both"></div>
											</div>
										</div>

										<div class="pay-bar free-pay-bar" id="pay-bar">
											<a class="payb-btn" id="ckeck_sms_verify_code_btn" href="javascript:;" onclick="check()"> 保存信息 </a>
										</div>
									</div>
									<!-- 弹层 -->

								</form>

								<!-- 5.0给结算地址页套上下面div   结束-->
							</div>

							<!-- 5.0增加内容 开始 -->
							<div class="loading-position">
								<div class="is-loading">
									<em></em>
									<!-- <span>加载中...</span> -->
								</div>
							</div>

							<div class="choose-address-page" id="chooseAddressPage">
								<!-- 通用头-->
								<div class="head-fix">
									<header>
										<div class="jd-index-header">
											<div class="jd-index-header-icon-back">
												<span id="goBack"></span>
											</div>
											<div class="jd-index-header-title">地址选择</div>
										</div>

									</header>
									<ul class="head-address-ul" id="headAddressUl">
										<li mytitle="0"></li>
										<li mytitle="1"></li>
										<li mytitle="2"></li>
										<li mytitle="3"></li>
									</ul>
								</div>

								<div class="address-container" id="addressContainer">
									<div class="address-content" id="addressContentDiv">
										<ul class="address-ul"></ul>
										<ul class="address-ul"></ul>
										<ul class="address-ul"></ul>
										<ul class="address-ul"></ul>
									</div>
								</div>

							</div>
							<!-- 5.0增加内容 结束 -->

							<script type="text/javascript" src="static/plugin/regionselect/js/zepto.min.js?v=20161018"></script>

							<!-- 9.2详细地址输入框自适应高度  结束 -->

							<!-- 5.0增加JS 开始-->
							<script type="text/javascript" src="static/plugin/regionselect/js/pingClick.js?v=20161018"></script>
							<script type="text/javascript" src="static/plugin/regionselect/js/zonda.toast.js?v=20161018" charset="GBK"></script>
							<script type="text/javascript" src="static/plugin/regionselect/js/four.level.region.select.js?v=20161018"></script>
							<script type="text/javascript">
								$(".jd-index-header-icon-back").click(function() {
									try {
										if (localStorage && localStorage.getItem('reNum')) {
											var reNum = localStorage.getItem('reNum');
											localStorage.removeItem('reNum');
											if (window.location.hash == "#chooseAddressPage") {
												window.history.go(-parseInt(reNum) + 1);
											} else {
												window.history.go(-parseInt(reNum));
											}
										} else {
											window.location.href = "/norder/address.action?sid=" + $("#sid").val() + "&flowType=" + $("#flowTypeId").val();
											//window.history.go(-1);
										}
									} catch (e) {

									}
									///window.location.href="/norder/address.action";

								});

								var flowType = '';
								function backListener(hash, next) {
									if (flowType) {
										// $("#m_common_header_goback").attr("href","javascript:history.go(-1)");
									} else {
										if (next != null) {
											//  $("#m_common_header_goback").attr("href","javascript:backListener('"+next+"')");
										}
										if (hash != null) {
											var backUrl = window.location.href;
											backUrl = backUrl.replace(window.location.hash, "");
											window.location.href = backUrl + "#" + hash;
										}
										if (hash == null || hash.indexOf('parent') != -1) {
											if ($("#wareId").val() != null && $("#wareId").val() != "") {
												$("#m_common_header_goback").bind('click', function() {
													window.location.href = '//item.m.jd.com/product/' + $("#wareId").val() + ".html";
												});

											} else {
												$("#m_common_header_goback").bind('click', function() {
													window.location.href = '/cart/cart.action?sid=aa4fd52b4e297fc579c552ac98bc07bb';

												});
											}
											;
										}
										;
									}
									;
								};

								$(document).ready(function() {
									backListener();
								});

								//--------地区组件js------start-----------------------
								try {
									if (localStorage && !localStorage.getItem('reNum')) {
										localStorage.setItem('reNum', 1);
									}
								} catch (e) {

								}
								var globalObj = {
									address : [ {
										REGION_NAME : '',
										REGION_CODE : ''
									}, {
										REGION_NAME : '',
										REGION_CODE : ''
									}, {
										REGION_NAME : '',
										REGION_CODE : ''
									}, {
										REGION_NAME : '',
										REGION_CODE : ''
									} ],
									reNum : 0
								};

								checkPageSelectAddress("checkPage", "chooseAddressPage", "selectAddressBtn", "addressLabelId", callBackFn, null);
								function callBackFn(option) {
									var provinceObj = globalObj.address && globalObj.address.length > 0 ? globalObj.address[0] : null;
									var cityObj = globalObj.address && globalObj.address.length > 1 ? globalObj.address[1] : null;
									var areaObj = globalObj.address && globalObj.address.length > 2 ? globalObj.address[2] : null;
									var townObj = globalObj.address && globalObj.address.length > 3 ? globalObj.address[3] : null;

									/**
									 * 给省、市、县和镇的id赋值。
									 */
									var idProvince = provinceObj && provinceObj.REGION_CODE ? provinceObj.REGION_CODE : 0;
									var idCity = cityObj && cityObj.REGION_CODE ? cityObj.REGION_CODE : 0;
									var idArea = areaObj && areaObj.REGION_CODE ? areaObj.REGION_CODE : 0;
									var idTown = townObj && townObj.REGION_CODE ? townObj.REGION_CODE : 0;

									var provinceNameIgnore = provinceObj && provinceObj.REGION_NAME ? provinceObj.REGION_NAME : "";
									var cityNameIgnore = cityObj && cityObj.REGION_NAME ? cityObj.REGION_NAME : "";
									var areaNameIgnore = areaObj && areaObj.REGION_NAME ? areaObj.REGION_NAME : "";
									var townNameIngore = townObj && townObj.REGION_NAME ? townObj.REGION_NAME : "";

									$("[id='address.provinceNameIgnore']").val(provinceNameIgnore);
									$("[id='address.cityNameIgnore']").val(cityNameIgnore);
									$("[id='address.areaNameIgnore']").val(areaNameIgnore);
									$("[id='address.townNameIngore']").val(townNameIngore);

									$("[id='address.idProvince']").val(idProvince);
									$("[id='address.idCity']").val(idCity);
									$("[id='address.idArea']").val(idArea);
									$("[id='address.idTown']").val(idTown);

									$("#selectAddressBtn").attr("region-data", idProvince + "," + idCity + "," + idArea + "," + idTown);
								}

								function check() {
									console.log('ceshi');
									toastError("详细地址最多为40个文字")
								}
								function toastError(b) {
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