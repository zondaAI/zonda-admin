<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link href="static/activiti/js/common/plugins/jui/themes/redmond/jquery-ui-1.9.2.custom.css" type="text/css" rel="stylesheet" />
<link href="static/activiti/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />
<link href="static/activiti/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
<style type="text/css">
.ui-dialog .ui-dialog-titlebar, .ui-jqdialog .ui-dialog-titlebar, .ui-dialog .ui-jqdialog-titlebar, .ui-jqdialog .ui-jqdialog-titlebar {
	background-color: #F1F1F1;
	font-size: 10px;
	color: #f5f5f5;
}

button, input, optgroup, select, textarea {
	font: -webkit-control;
	margin: 0;
}

.ui-dialog .ui-dialog-titlebar-close:before, .ui-jqdialog .ui-dialog-titlebar-close:before, .ui-dialog .ui-jqdialog-titlebar-close:before, .ui-jqdialog .ui-jqdialog-titlebar-close:before {
	content: "";
	display: inline;
	font-family: FontAwesome;
	font-size: 16px;
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

							<!-- 检索  -->
							<form action="workflow/process/list.do" method="post" name="processForm" id="processForm">
								<table style="margin-top:5px;">
									<tr>
										<td>
											<div class="nav-search">
												<span class="input-icon"> <input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" /> <i class="ace-icon fa fa-search nav-search-icon"></i>
												</span>
											</div>
										</td>
										<td style="padding-left:2px;"><input class="span10 date-picker" name="lastUpdateStart" id="lastUpdateStart" value="${pd.lastUpdateStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="最近登录开始" /></td>
										<td style="padding-left:2px;"><input class="span10 date-picker" name="lastUpdateEnd" name="lastUpdateEnd" value="${pd.lastUpdateEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="最近登录结束" /></td>

										<c:if test="${QX.cha == 1 }">
											<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();" title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
											<c:if test="${QX.toExcel == 1 }">
												<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
											</c:if>
										</c:if>
										<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-xs btn-yellow" href="${ctx }/workflow/process/process-instance/running/list" title="查看运行中流程列表">运行中流程列表</a></td>
										<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-xs btn-default" href="${ctx }/workflow/process/process-instance/finished/list" title="查看已结束流程列表">已结束流程列表</a></td>
									</tr>
								</table>
								<!-- 检索  -->
								<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
									<thead>
										<tr>
											<th class="center" style="width:35px;"><label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label></th>
											<th class="center" style="width:50px;">序号</th>
											<th class="center">ProcessDefinitionId</th>
											<th class="center">部署ID</th>
											<th class="center">名称</th>
											<th class="center">KEY</th>
											<!-- <th class="center">版本号</th> -->
											<th class="center">XML</th>
											<th class="center">图片</th>
											<!-- <th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>部署时间</th> -->
											<th class="center" style="width:85px;">是否挂起</th>
											<th class="center" style="width:100px;">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty processList}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${processList}" var="process" varStatus="vs">
														<tr>
															<td class='center' style="width: 30px;"><label><input type='checkbox' name='ids' value="${process.deploymentId }" id="${process.key }" alt="${process.name }" class="ace" /><span class="lbl"></span></label></td>
															<td class='center' style="width: 30px;">${vs.index + 1}</td>
															<td>${process.id }</td>
															<td>${process.deploymentId }</td>
															<td>${process.name }</td>
															<td>${process.key }</td>
															<!-- <td>${process.version }</td> -->
															<td><a target="_blank" href='${ctx }/workflow/process/resource/read?processDefinitionId=${process.id}&resourceType=xml'>${process.resourceName }</a></td>
															<td><a target="_blank" href='${ctx }/workflow/process/resource/read?processDefinitionId=${process.id}&resourceType=image'>${process.diagramResourceName }</a></td>
															<!-- <td>${deployment.deploymentTime }</td> -->
															<td>${process.suspended}|<c:if test="${process.suspended }">
																	<a href="${ctx }/workflow/process/update/active/${process.id}">激活</a>
																</c:if> <c:if test="${!process.suspended }">
																	<a href="${ctx }/workflow/process/update/suspend/${process.id}">挂起</a>
																</c:if>
															</td>
															<td><c:if test="${QX.del != 1 }">
																	<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
																</c:if>
																<div class="hidden-sm hidden-xs btn-group">
																	<a class="btn btn-xs btn-purple" title="转换为Model" href='${ctx }/workflow/process/convert-to-model/${process.id}'> <i class="ace-icon fa fa-stack-overflow bigger-120" title="转换为Model"></i></a>
																	<c:if test="${!process.suspended }">
																		<a class="btn btn-xs btn-pink startup-process" title="启动流程" href="javascript:void(0);" tkey='${process.key }' tname='${process.name }' tid='${process.id }'> <i class="ace-icon fa fa-play-circle-o bigger-120" title="启动流程"></i></a>
																	</c:if>
																	<c:if test="${QX.del == 1 }">
																		<a class="btn btn-xs btn-danger" onclick="delProcess('${process.deploymentId }', '${process.name }');"> <i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i></a>
																	</c:if>
																</div></td>
														</tr>
													</c:forEach>
												</c:if>
												<c:if test="${QX.cha == 0 }">
													<tr>
														<td colspan="100" class="center">您无权查看</td>
													</tr>
												</c:if>
											</c:when>
											<c:otherwise>
												<tr class="main_info">
													<td colspan="100" class="center">没有相关数据</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<div class="page-header position-relative">
									<table style="width:100%;">
										<tr>
											<td style="vertical-align:top;"><c:if test="${QX.add == 1 }">
													<a class="btn btn-mini btn-success" onclick="deployment();">导入流程部署</a>
												</c:if> <c:if test="${QX.del == 1 }">
													<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');"><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
												</c:if></td>
											<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr }</div></td>
										</tr>
									</table>
								</div>
							</form>
							<!-- 办理任务对话框 -->
							<div id="handleTemplate" class="template"></div>
							<script type="text/javascript" src="static/ace/js/jquery.js?v=2.1.1"></script>
							<script type="text/javascript" src="static/js/jquery-migrate-1.4.1.min.js"></script>
							<script src="static/activiti/js/common/plugins/jui/jquery-ui-1.9.2.min.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/plugins/validate/jquery.validate.pack.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/plugins/validate/messages_cn.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/plugins/blockui/jquery.blockUI.js" type="text/javascript"></script>
							<script src="static/activiti/js/common/common.js" type="text/javascript"></script>
							<script type="text/javascript" src="static/activiti/js/module/form/dynamic/dynamic-process-list.js?v=20161120"></script>

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
	<%@ include file="../../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态

		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			});

			//下拉框
			if (!ace.vars['touch']) {
				$('.chosen-select').chosen({
					allow_single_deselect : true
				});
				$(window).off('resize.chosen').on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						var $this = $(this);
						$this.next().css({
							'width' : $this.parent().width()
						});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if (event_name != 'sidebar_collapsed')
						return;
					$('.chosen-select').each(function() {
						var $this = $(this);
						$this.next().css({
							'width' : $this.parent().width()
						});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e) {
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if (which == 2)
						$('#form-field-select-4').addClass('tag-input-style');
					else
						$('#form-field-select-4').removeClass('tag-input-style');
				});
			}

			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function() {
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function() {
					var row = this;
					if (th_checked)
						$(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else
						$(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});

		//检索
		function searchs() {
			top.jzts();
			$("#processForm").submit();
		}
		//手动部署
		function deployment(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title ="部署新标准流程";
			 diag.URL = '<%=basePath%>workflow/process/goAddP.do';
			 diag.Width = 500;
			 diag.Height = 200;
			 diag.CancelEvent = function(){ //关闭事件
				 if('${page.currentPage}' == '0'){
					 top.jzts();
					 setTimeout("self.location=self.location",100);
				 }else{
					 nextPage(${page.currentPage});
				 }
			 	 diag.close();
			 };
			 diag.show();
		}
		//删除
		function delProcess(deploymentId, msg){
			bootbox.confirm("确定要删除["+msg+"]吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>workflow/process/delete.do?deploymentId=" + deploymentId + "&tm=" + new Date().getTime();
					$.get(url, function(data) {
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i = 0; i < document.getElementsByName('ids').length; i++) {
						if(document.getElementsByName('ids')[i].checked){
						  	if(str == '') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
					  	}
					}
					if(str == ''){
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>workflow/process/deleteAllP.do?tm=' + new Date().getTime(),
								data : {
									deploymentId_ids : str
								},
								dataType : 'json',
								//beforeSend: validateData,
								cache : false,
								success : function(data) {
									$.each(data.list, function(i, list) {
										nextPage(${page.currentPage});
									});
								}
							});
						}
					}
				}
			});
		}
	</script>
</body>
</html>