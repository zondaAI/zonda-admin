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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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
							<form action="workflow/process/${msg }.do" name="modelForm" id="modelForm" method="post" enctype="multipart/form-data">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:200px;text-align: right;padding-top: 13px;">选择文件：</td>
											<td><input type="file" id="file" name="file" value="${pd.file }" maxlength="32" placeholder="请选择文件" title="请选择文件" style="width:98%;" /><span style="color:red;">支持格式：zip、bar、bpmn、bpmn20.xml</span></td>
										</tr>
										<tr>
											<td class="center" colspan="6"><a class="btn btn-mini btn-primary" onclick="save();">部署</a> <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display:none">
									<br /> <br /> <br /> <br /> <br /> <img src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">部署中...</h4>
								</div>
							</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>
<script type="text/javascript">
	$(top.hangge());

	//保存
	function save() {
		if ($("#file").val() == "") {
			$("#file").tips({
				side : 3,
				msg : '请选择文件',
				bg : '#AE81FF',
				time : 3
			});
			$("#file").focus();
			return false;
		}
		if (!$("#file").val().endWith('.zip') || !$("#file").val().endWith('.bar') || !$("#file").val().endWith('.bpmn') || !$("#file").val().endWith('.bpmn20.xml')) {
			$("#file").tips({
				side : 3,
				msg : '请选择正确格式的文件',
				bg : '#AE81FF',
				time : 3
			});
			$("#file").focus();
			return false;
		}
		$("#modelForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}

	String.prototype.startWith = function(s) {
		if (s == null || s == "" || this.length == 0 || s.length > this.length)
			return false;
		if (this.substr(0, s.length) == s)
			return true;
		else
			return false;
		return true;
	}

	String.prototype.endWith = function(s) {
		if (s == null || s == "" || this.length == 0 || s.length > this.length)
			return false;
		if (this.substring(this.length - s.length) == s)
			return true;
		else
			return false;
		return true;
	}
</script>
</html>