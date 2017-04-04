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
							<form action="workflow/model/${msg }.do" name="modelForm" id="modelForm" method="post">
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">名称:</td>
											<td><input type="text" name="name" id="name" value="${pd.name }" maxlength="32" placeholder="这里输入名称" title="名称" style="width:98%;" /></td>
											<td style="width:79px;text-align: right;padding-top: 13px;">KEY:</td>
											<td><input type="email" name="key" id="key" value="${pd.key }" maxlength="32" placeholder="这里输入KEY" title="KEY" style="width:98%;" /></td>
										</tr>
										<tr>
											<td style="width:79px;text-align: right;padding-top: 13px;">备注:</td>
											<td colspan="6"><textarea type="text" name="description" id="description" value="${pd.description }" placeholder="这里输入备注" title="备注" style="width:98%;" rows="5"></textarea></td>
										</tr>
										<tr>
											<td class="center" colspan="6"><a class="btn btn-mini btn-primary" onclick="save();">保存</a> <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display:none">
									<br />
									<br />
									<br />
									<br />
									<br />
									<img src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
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
	function save(){
		if($("#name").val()==""){
			$("#name").tips({
				side:3,
	            msg:'输入名称',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#name").focus();
			return false;
		}else{
			$("#name").val($.trim($("#name").val()));
		}
		if($("#key").val()==""){
			$("#key").tips({
				side:3,
	            msg:'输入KEY',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#key").focus();
			return false;
		}else{
			$("#key").val($.trim($("#key").val()));
		}
		$("#modelForm").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
</script>
</html>