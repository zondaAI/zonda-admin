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
.ui-dialog .ui-dialog-titlebar-close:before,
.ui-jqdialog .ui-dialog-titlebar-close:before,
.ui-dialog .ui-jqdialog-titlebar-close:before,
.ui-jqdialog .ui-jqdialog-titlebar-close:before {
  content: "";
  display: inline;
  font-family: FontAwesome;
  font-size: 16px;
}
#handleTemplate table {
    border-collapse: separate;
    border-spacing: 2px;
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
							<form action="workflow/task/list.do" method="post" name="taskForm" id="taskForm">
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
									</tr>
								</table>
								<!-- 检索  -->
								<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
									<thead>
										<tr>
											<th class="center" style="width:35px;"><label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label></th>
											<th class="center" style="width:50px;">序号</th>
											<th class="center">任务ID</th>
											<th class="center">任务KEY</th>
											<th class="center">任务名称</th>
											<th class="center">流程定义ID</th>
											<th class="center">流程实例ID</th>
											<th class="center">优先级</th>
											<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>创建日期</th>
											<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>逾期日期</th>
											<th class="center">任务描述</th>
											<th class="center">任务所属人</th>
											<th class="center" style="width:50px;">操作</th>
										</tr>
									</thead>
									<tbody>
										<!-- 开始循环 -->
										<c:choose>
											<c:when test="${not empty taskList}">
												<c:if test="${QX.cha == 1 }">
													<c:forEach items="${taskList}" var="task" varStatus="vs">
														<tr>
															<td class='center' style="width: 30px;"><label><input type='checkbox' name='ids' value="${task.id }" id="${task.taskDefinitionKey }" alt="${task.name }" class="ace" /><span class="lbl"></span></label></td>
															<td class='center' style="width: 30px;">${vs.index + 1}</td>
															<td class='center'>${task.id }</td>
															<td class='center'>${task.taskDefinitionKey }</td>
															<td class='center'>${task.name }</td>
															<td class='center'>${task.processDefinitionId }</td>
															<td class='center'>${task.processInstanceId }</td>
															<td class='center'>${task.priority }</td>
															<td class='center'><fmt:formatDate value="${task.createTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
															<td class='center'><fmt:formatDate value="${task.dueDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
															<td class='center'>${task.description }</td>
															<td class='center'>${task.owner }</td>
															<td>
																<c:if test="${QX.del != 1 }">
																	<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
																</c:if>
																<div class="hidden-sm hidden-xs btn-group">
																	<c:if test="${empty task.assignee }">
																		<a class="btn btn-xs btn-purple claim" href="${ctx }/workflow/task/claim/${task.id}"><i class="ace-icon fa fa-file-text-o bigger-120" title="办理"></i>签收</a>
																	</c:if>
																	<c:if test="${not empty task.assignee }">
																		<!-- 此处用taskDefinitionKey记录当前节点的名称 -->
																		<a class="btn btn-xs btn-pink handle" title="办理" href="javascript:void(0);" tkey='${task.taskDefinitionKey }' tname='${task.name }' tid='${task.id }'> <i class="ace-icon fa fa-gears bigger-120" title="办理"></i>办理</a>
																	</c:if>
																</div>
															</td>
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
							<script type="text/javascript" src="static/activiti/js/module/form/dynamic/dynamic-form-handler.js?v=20161120"></script>

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
			$("#taskForm").submit();
		}
	</script>
</body>
</html>