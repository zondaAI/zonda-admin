/**
 * 动态Form办理功能
 */
$(function() {

	$('.handle').click(handle);

});

/**
 * 打开办理对话框
 */
function handle() {
	var $ele = $(this);

	// 当前节点的英文名称
	var tkey = $(this).attr('tkey');

	// 当前节点的中文名称
	var tname = $(this).attr('tname');

	// 任务ID
	var taskId = $(this).attr('tid');

	$('#handleTemplate').html('').dialog({
		modal : true,
		width : 400,
		title : '办理任务[' + tname + ']',
		open : function() {
			readFormFields.call(this, taskId);
		},
		buttons : [ {
			text : '提交',
			class : 'btn btn-mini btn-primary',
			click : sendRequest
		}, {
			text : '取消',
			class : 'btn btn-mini btn-danger',
			click : function() {
				$(this).dialog('close');
			}
		} ]
	});
}

/**
 * 读取表单字段
 */
function readFormFields(tid) {
	var dialog = this;

	// 清空对话框内容
	$(dialog).html("<form class='dynamic-form' method='post'><table class='dynamic-form-table'></table></form>");
	var $form = $('.dynamic-form');

	// 设置表单提交id
	$form.attr('action', G_CTX_ROOT + '/workflow/task/complete/' + tid);

	// 读取启动时的表单
	$.getJSON(G_CTX_ROOT + '/workflow/task/get-form/task/' + tid, function(datas) {
		var trs = "";
		$.each(datas.taskFormData.formProperties, function() {
			var className = this.required === true ? "required" : "";
			this.value = this.value ? this.value : "";
			trs += "<tr>" + createFieldHtml(this, datas, className)
			if (this.required === true) {
				trs += "<span style='color:red'>*</span>";
			}
			trs += "</td></tr>";
		});

		// 添加table内容
		$('.dynamic-form-table').html(trs);

		// 初始化日期组件
		$form.find('.date-picker').datepicker({
			autoclose : true,
			todayHighlight : true
		});

		// 表单验证
		$form.validate($.extend({}, $.common.plugin.validator));
	});
}

/**
 * form对应的string/date/long/enum/boolean类型表单组件生成器 fp_的意思是form parameter
 */
var formFieldCreator = {
	'string' : function(prop, datas, className) {
		var result = "<td width='120'>" + prop.name + "：</td>";
		if (prop.writable === true) {
			result += "<td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "' class='" + className + "' placeholder='" + prop.name + "' value='" + prop.value + "' />";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	},
	'date' : function(prop, datas, className) {
		var result = "<td width='120'>" + prop.name + "：</td>";
		if (prop.writable === true) {
			result += "<td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "' class='date-picker " + className + "' placeholder='" + prop.name + "' data-date-format='yyyy-mm-dd' readonly='readonly' value='" + prop.value + "'/>";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	},
	'enum' : function(prop, datas, className) {
		var result = "<td width='120'>" + prop.name + "：</td>";
		if (prop.writable === true) {
			result += "<td><select id='" + prop.id + "' name='fp_" + prop.id + "' class='" + className + "' style='width: 150px;'>";
			$.each(datas[prop.id], function(k, v) {
				result += "<option value='" + k + "'>" + v + "</option>";
			});
			result += "</select>";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	},
	'users' : function(prop, datas, className) {
		var result = "<td width='120'>" + prop.name + "：</td>";
		if (prop.writable === true) {
			result += "<td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "' class='" + className + "' placeholder='" + prop.name + "' value='" + prop.value + "' />";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	}
};

/**
 * 生成一个field的html代码
 */
function createFieldHtml(prop, datas, className) {
	return formFieldCreator[prop.type.name](prop, datas, className);
}

/**
 * 发送处理流程请求
 */

function sendRequest() {
	if ($(".dynamic-form").valid()) {
		$('.dynamic-form').submit();
	}
}