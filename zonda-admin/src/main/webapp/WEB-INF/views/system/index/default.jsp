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
<%@ include file="../index/top.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">
							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i> 欢迎使用 zonda Admin 系统&nbsp;&nbsp; <strong class="green"> &nbsp;QQ:704523482 <!-- <a href="http://www.fhadmin.org" target="_blank"><small>(&nbsp;www.fhadmin.org&nbsp;)</small></a> -->
								</strong>
							</div>
							<div class="row">
								<div class="col-sm-7">
									<div class="widget-box transparent">
										<div class="widget-header widget-header-flat">
											<h4 class="widget-title lighter">
												<i class="ace-icon fa fa-signal"></i>
												zonda Admin用户统计
											</h4>
		
											<div class="widget-toolbar">
												<a href="#" data-action="collapse">
													<i class="ace-icon fa fa-chevron-up"></i>
												</a>
											</div>
										</div>
		
										<div class="widget-body">
											<div class="widget-main padding-4">
												<div id="main" style="width: 600px;height:300px;"></div>
											</div><!-- /.widget-main -->
										</div><!-- /.widget-body -->
									</div><!-- /.widget-box -->
								</div><!-- /.col -->
								<script type="text/javascript">
									// 基于准备好的dom，初始化echarts实例
									var myChart = echarts.init(document.getElementById('main'));
	
									// 指定图表的配置项和数据
									var option = {
										title : {
											text : 'zonda Admin用户统计'
										},
										tooltip : {},
										xAxis : {
											data : [ "系统用户", "系统会员" ]
										},
										yAxis : {},
										series : [ {
											name : '',
											type : 'bar',
											data : [ ${pd.userCount}, ${pd.appUserCount} ],
											itemStyle : {
												normal : {
													color : function(params) {
														// build a color map as your need.
														var colorList = [ '#6FB3E0', '#87B87F' ];
														return colorList[params.dataIndex];
													}
												}
											}
										} ]
									};
	
									// 使用刚指定的配置项和数据显示图表。
									myChart.setOption(option);
								</script>
							</div>
							<div class="row">
								<div class="space-6"></div>
								
								<div class="col-sm-5">
									<div class="widget-box transparent">
										<div class="widget-header widget-header-flat">
											<h4 class="widget-title lighter">
												<i class="ace-icon fa fa-star orange"></i>
												Popular Domains
											</h4>

											<div class="widget-toolbar">
												<a href="#" data-action="collapse">
													<i class="ace-icon fa fa-chevron-up"></i>
												</a>
											</div>
										</div>

										<div class="widget-body">
											<div class="widget-main no-padding">
												<table class="table table-bordered table-striped">
													<thead class="thin-border-bottom">
														<tr>
															<th>
																<i class="ace-icon fa fa-caret-right blue"></i>name
															</th>

															<th>
																<i class="ace-icon fa fa-caret-right blue"></i>price
															</th>

															<th class="hidden-480">
																<i class="ace-icon fa fa-caret-right blue"></i>status
															</th>
														</tr>
													</thead>

													<tbody>
														<tr>
															<td>internet.com</td>

															<td>
																<small>
																	<s class="red">$29.99</s>
																</small>
																<b class="green">$19.99</b>
															</td>

															<td class="hidden-480">
																<span class="label label-info arrowed-right arrowed-in">on sale</span>
															</td>
														</tr>

														<tr>
															<td>online.com</td>

															<td>
																<b class="blue">$16.45</b>
															</td>

															<td class="hidden-480">
																<span class="label label-success arrowed-in arrowed-in-right">approved</span>
															</td>
														</tr>

														<tr>
															<td>newnet.com</td>

															<td>
																<b class="blue">$15.00</b>
															</td>

															<td class="hidden-480">
																<span class="label label-danger arrowed">pending</span>
															</td>
														</tr>

														<tr>
															<td>web.com</td>

															<td>
																<small>
																	<s class="red">$24.99</s>
																</small>
																<b class="green">$19.95</b>
															</td>

															<td class="hidden-480">
																<span class="label arrowed">
																	<s>out of stock</s>
																</span>
															</td>
														</tr>

														<tr>
															<td>domain.com</td>

															<td>
																<b class="blue">$12.00</b>
															</td>

															<td class="hidden-480">
																<span class="label label-warning arrowed arrowed-right">SOLD</span>
															</td>
														</tr>
													</tbody>
												</table>
											</div><!-- /.widget-main -->
										</div><!-- /.widget-body -->
									</div><!-- /.widget-box -->
								</div><!-- /.col -->

								<div class="vspace-12-sm"></div>
								
								<div class="col-sm-7 infobox-container">
									<!-- #section:pages/dashboard.infobox -->
									<div class="infobox infobox-green">
										<div class="infobox-icon">
											<i class="ace-icon fa fa-comments"></i>
										</div>

										<div class="infobox-data">
											<span class="infobox-data-number">32</span>
											<div class="infobox-content">comments + 2 reviews</div>
										</div>

										<!-- #section:pages/dashboard.infobox.stat -->
										<div class="stat stat-success">8%</div>

										<!-- /section:pages/dashboard.infobox.stat -->
									</div>

									<div class="infobox infobox-blue">
										<div class="infobox-icon">
											<i class="ace-icon fa fa-twitter"></i>
										</div>

										<div class="infobox-data">
											<span class="infobox-data-number">11</span>
											<div class="infobox-content">new followers</div>
										</div>

										<div class="badge badge-success">
											+32%
											<i class="ace-icon fa fa-arrow-up"></i>
										</div>
									</div>

									<div class="infobox infobox-pink">
										<div class="infobox-icon">
											<i class="ace-icon fa fa-shopping-cart"></i>
										</div>

										<div class="infobox-data">
											<span class="infobox-data-number">8</span>
											<div class="infobox-content">new orders</div>
										</div>
										<div class="stat stat-important">4%</div>
									</div>

									<div class="infobox infobox-red">
										<div class="infobox-icon">
											<i class="ace-icon fa fa-flask"></i>
										</div>

										<div class="infobox-data">
											<span class="infobox-data-number">7</span>
											<div class="infobox-content">experiments</div>
										</div>
									</div>

									<div class="infobox infobox-orange2">
										<!-- #section:pages/dashboard.infobox.sparkline -->
										<div class="infobox-chart">
											<span class="sparkline" data-values="196,128,202,177,154,94,100,170,224"></span>
										</div>

										<!-- /section:pages/dashboard.infobox.sparkline -->
										<div class="infobox-data">
											<span class="infobox-data-number">6,251</span>
											<div class="infobox-content">pageviews</div>
										</div>

										<div class="badge badge-success">
											7.2%
											<i class="ace-icon fa fa-arrow-up"></i>
										</div>
									</div>

									<div class="infobox infobox-blue2">
										<div class="infobox-progress">
											<!-- #section:pages/dashboard.infobox.easypiechart -->
											<div class="easy-pie-chart percentage" data-percent="42" data-size="46">
												<span class="percent">42</span>%
											</div>

											<!-- /section:pages/dashboard.infobox.easypiechart -->
										</div>

										<div class="infobox-data">
											<span class="infobox-text">traffic used</span>

											<div class="infobox-content">
												<span class="bigger-110">~</span>
												58GB remaining
											</div>
										</div>
									</div>

									<!-- /section:pages/dashboard.infobox -->
									<div class="space-6"></div>

									<!-- #section:pages/dashboard.infobox.dark -->
									<div class="infobox infobox-green infobox-small infobox-dark">
										<div class="infobox-progress">
											<!-- #section:pages/dashboard.infobox.easypiechart -->
											<div class="easy-pie-chart percentage" data-percent="61" data-size="39">
												<span class="percent">61</span>%
											</div>

											<!-- /section:pages/dashboard.infobox.easypiechart -->
										</div>

										<div class="infobox-data">
											<div class="infobox-content">Task</div>
											<div class="infobox-content">Completion</div>
										</div>
									</div>

									<div class="infobox infobox-blue infobox-small infobox-dark">
										<!-- #section:pages/dashboard.infobox.sparkline -->
										<div class="infobox-chart">
											<span class="sparkline" data-values="3,4,2,3,4,4,2,2"></span>
										</div>

										<!-- /section:pages/dashboard.infobox.sparkline -->
										<div class="infobox-data">
											<div class="infobox-content">Earnings</div>
											<div class="infobox-content">$32,000</div>
										</div>
									</div>

									<div class="infobox infobox-grey infobox-small infobox-dark">
										<div class="infobox-icon">
											<i class="ace-icon fa fa-download"></i>
										</div>

										<div class="infobox-data">
											<div class="infobox-content">Downloads</div>
											<div class="infobox-content">1,205</div>
										</div>
									</div>

									<!-- /section:pages/dashboard.infobox.dark -->
								</div>
							</div><!-- /.row -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

		<div class="footer">
			<div class="footer-inner">
				<!-- #section:basics/footer -->
				<div class="footer-content">
					<span class="bigger-120">
						<span class="blue bolder">风之子AI亚洲研究院</span>
						zonda Admin &copy; 2012-2016
					</span>
					&nbsp; &nbsp;
					<span class="action-buttons">
						<a href="https://twitter.com">
							<i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
						</a>

						<a href="https://www.facebook.com">
							<i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i>
						</a>

						<a href="https://www.rss.com">
							<i class="ace-icon fa fa-rss-square orange bigger-150"></i>
						</a>
					</span>
				</div>
				<!-- /section:basics/footer -->
			</div>
		</div>

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<script type="text/javascript" src="static/ace/js/jquery.js"></script>
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
	</script>
</body>
</html>