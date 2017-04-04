/**
 * 动态表单Javascript，负责读取表单元素、启动流程
 */
$(function() {

	$('.startup-process').click(showStartupProcessDialog);

});

/**
 * 打开启动流程
 */

function showStartupProcessDialog() {
	var $ele = $(this);

	// 当前节点的英文名称
	var tkey = $(this).attr('tkey');

	// 当前节点的中文名称
	var tname = $(this).attr('tname');

	// 当前节点的ID
	var tid = $(this).attr('tid');

	$('#handleTemplate').html('').dialog({
		modal : true,
		width : 400,
		title : '启动流程[' + tname + ']',
		open : function() {
			readFormFields.call(this, tid);
		},
		buttons : [ {
			text : '启动',
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
	$form.attr('action', G_CTX_ROOT + '/workflow/process/start-process/' + tid);

	// 读取启动时的表单
	$.getJSON(G_CTX_ROOT + '/workflow/process/get-form/start/' + tid, function(datas) {
		var trs = "";
		$.each(datas.startFormData.formProperties, function() {
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
			todayHighlight : true,
			dateFormat : "yyyy-MM-dd"
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
			result += "<td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "' class='" + className + "' value='" + prop.value + "' />";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	},
	'date' : function(prop, datas, className) {
		var result = "<td width='120'>" + prop.name + "：</td>";
		if (prop.writable === true) {
			result += "<td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "' class='date-picker " + className + "' data-date-format='yyyy-mm-dd' readonly='readonly' value='" + prop.value + "'/>";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	},
	'enum' : function(prop, datas, className) {
		var result = "<td width='120'>" + prop.name + "：</td>";
		if (prop.writable === true) {
			result += "<td><select id='" + prop.id + "' name='fp_" + prop.id + "' class='" + className + "'>";
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
			result += "<td><input type='text' id='" + prop.id + "' name='fp_" + prop.id + "' class='" + className + "' value='" + prop.value + "' />";
		} else {
			result += "<td>" + prop.value;
		}
		return result;
	}
};

/**
 * 生成一个field的HTML代码
 */
function createFieldHtml(prop, className) {
	return formFieldCreator[prop.type.name](prop, className);
}

/**
 * 发送启动流程请求
 */

function sendRequest() {
	if ($(".dynamic-form").valid()) {
		$('.dynamic-form').submit();
	}
}