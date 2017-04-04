// 输入框定位图片宽度，高度
function changeContainer() {
	var $dragDiv = $(".block");
	$dragDiv.css("left", $("#hid_x").val() + "px");
	$dragDiv.css("top", $("#hid_y").val() + "px");
	$dragDiv.css("width", parseInt($("#pw").val()) + 2 + "px");
	$dragDiv.css("height", parseInt($("#ph").val()) + 2 + "px");
	$("#hid_w").val(parseInt($("#pw").val()));
	$("#hid_h").val(parseInt($("#ph").val()));
	$(".cropper").css({
		left : parseInt($dragDiv.css("left")) + parseInt($dragDiv.width())/2 - 40,
		top : parseInt($dragDiv.css("top")) + parseInt($dragDiv.height())/2 - 20
	});
}

// 输入框图片宽度判断
function limitInputW(o) {
	o.value = o.value.replace(/\D/g, '');
	var value = o.value;
	var min = 1;
	var max = 1000;
	if (parseInt(value) < min) {
		o.value = min;
	}
	if (parseInt(value) > max) {
		o.value = max;
	}
	changeContainer();
}

// 输入框图片高度判断
function limitInputH(o) {
	o.value = o.value.replace(/\D/g, '');
	var value = o.value;
	var min = 1;
	var max = 500;
	if (parseInt(value) < min) {
		o.value = min;
	}
	if (parseInt(value) > max) {
		o.value = max;
	}
	changeContainer();
}
// 图片切割
function Create() {
	var pic = $('#container').find('img').attr('src');
	if(typeof pic == undefined || pic == null || pic == '' || pic == 'static/plugin/photocropper/images/zwtp.png'){
		toastTips("裁剪失败, 请先上传图片!");
		return false;
	}

	var x = $("#hid_x").val();
	var y = $("#hid_y").val();
	var h = $("#hid_h").val();
	var w = $("#hid_w").val();

	var uri = "x=" + x + "&y=" + y + "&w=" + w + "&h=" + h;
	console.log(uri);

	if ($("#hid_imgPath").val() != '') {
		$("#dealing-modal").modal({// 载入模态框
  			keyboard: false,
	      	backdrop: false
	    });
		$.ajax({
			type : 'POST',
			url : G_CTX_ROOT + '/plugin/ajaxSaveImgUploadJT.chtml',
			async : false,
			dataType : 'text',
			data : {
				"x" : x,
				"y" : y,
				"w" : w,
				"h" : h,
				"imgPath" : $("#hid_imgPath").val(),
				"PICTURES_ID" : $("#PICTURES_ID").val()
			},
			success : function(data) {
				var timestamp = new Date().getTime();
				var obj = JSON.parse(data);
				var path = G_CTX_ROOT + "/uploadFiles/uploadImgs/" + obj.PATH + "?d=" + timestamp;
				$("#hid_tempfile").val(path);
				$("#hid_imgPath").val(obj.PATH);
				var $bgDiv = $("#bgDiv");
				$bgDiv.find("img").each(function(i) {
					$(this).attr("src", path);
				});
				var $dragDiv = $(".block");
				$dragDiv.css("left", "0px");
				$dragDiv.css("top", "0px");
				var left = parseInt($dragDiv.css("left")), top = parseInt($dragDiv.css("top")), height = parseInt($dragDiv.height()), width = parseInt($dragDiv.width());
				$("#hid_x").val(isNaN(parseInt(left))?0:parseInt(left));
				$("#hid_y").val(isNaN(parseInt(top))?0:parseInt(top));
				$("#hid_w").val(width);
				$("#hid_h").val(height);
				$(".cropper").css({
					left : parseInt($dragDiv.css("left")) + parseInt($dragDiv.width())/2 - 40,
					top : parseInt($dragDiv.css("top")) + parseInt($dragDiv.height())/2 - 20
				});
				$("#dealing-modal").modal("hide");// 关闭模态框
			},
			error : function() {
				flag = false;
				$("#dealing-modal").modal("hide");// 关闭模态框
				toastTips("裁剪失败, 与服务器通讯异常!");
			}
		});
	}
}

(function() {
	var dBody = document.body, dDoc = document.documentElement, ie = $.browser.msie;
	var ieinit = true;
	if (!!window.ActiveXObject || "ActiveXObject" in window) {
		ie = true;
	}
	ie && ($.browser.version == "6.0") && document.execCommand("BackgroundImageCache", false, true);
	var clip = function(options) {
		this.init.call(this, options);
	}
	clip.prototype = {
		options : {
			moveCallBack : function() {
			},
			blockClass : "block",
			tipsClass : "tips"
		},
		init : function(options) {
			$.extend(this, this.options, options || {});
			if (!this.container || !this.imgC) {
				return;
			}
			this.container = $(this.container);
			var self = this;
			this.block = $('<div class="' + this.blockClass + '">\
			     <div action="rightDown" class="rRightDown"></div>\
			     <div action="leftDown" class="rLeftDown"></div>\
			     <div action="rightUp" class="rRightUp"></div>\
			     <div action="leftUp" class="rLeftUp"></div>\
			     <div action="right" class="rRight"></div>\
			     <div action="left" class="rLeft"></div>\
			     <div action="up" class="rUp"></div>\
			     <div action="down" class="rDown" ></div>\
	       </div>').bind("mousedown.r", function(e) {
				self.start(e)
			}).appendTo(this.container[0]);
			this.tips = $('<span class="' + this.tipsClass + '" />').appendTo(this.container[0]);
			this.cropper = $('<input style="width: 90px;position: absolute;border-radius: 30px;" class="cropper btn btn-default btn-block btn-primary" id="newUploadBannerPic" name="newUploadBannerPic" onclick="Create();" value="点我裁剪" type="button">').appendTo(this.container[0]);
			this.setImg();
		},
		setImg : function() {
			var block = this.block;
			var left = parseInt(block.css("left")), top = parseInt(block.css("top")), height = parseInt(block.height()), width = parseInt(block.width());
			if (ie && ieinit) {
				ieinit = false;
				height = height - 2;
				width = width - 2;
			}
			this.imgC.css({
				height : height,
				width : width,
				"background-position" : "-" + left + " -" + top
			});
			this.tips.html("left:<span>" + parseInt(left) + "</span>top:<span>" + +parseInt(top) + "</span>width:<span>" + width + "</span>height:<span>" + height + "</span>");
			this.cropper.css({
				left : left + block.width()/2 - 40,
				top : top + block.height()/2 - 20
			});
			if (width > 0) {
				$("#pw").val(width);
				$("#ph").val(height);
			}
			if(width > 0 && height > 0){
				$("#hid_x").val(isNaN(parseInt(left))?0:parseInt(left));
				$("#hid_y").val(isNaN(parseInt(top))?0:parseInt(top));
				$("#hid_w").val(width);
				$("#hid_h").val(height);
			}
		},
		start : function(e) {
			var $elem = $(e.target), block = this.block, self = this, move = false, container = this.container, action = $elem.attr("action");
			// 这个 每次都要计算 基本dom结构的改变 浏览器的缩放 都会让里面的值发生改变
			this.offset = $.extend({
				height : container.height(),
				width : container.width()
			}, container.offset());
			this.blockOriginal = {
				height : block.height(),
				width : block.width(),
				left : parseInt(block.css("left")),
				top : parseInt(block.css("top"))
			};
			if (action) {
				this.fun = this[action];
			} else {
				this.x = e.clientX - this.offset.left - this.blockOriginal.left;
				this.y = e.clientY - this.offset.top - this.blockOriginal.top;
				move = true;
			}
			ie && this.block[0].setCapture();
			this.tips.show();
			this.cropper.hide();
			$(document).bind("mousemove.r", function(e) {
				self.move(e, move)
			}).bind("mouseup.r", function() {
				self.end()
			});
		},
		end : function() {
			$(document).unbind("mousemove.r").unbind("mouseup.r");
			ie && this.block[0].releaseCapture();
			this.tips.hide();
			this.cropper.show();
		},
		move : function(e, isMove) {
			window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
			
			var block = this.block;
			if (isMove) {
				var left = Math.max(0, e.clientX - this.offset.left - this.x);
				left = Math.min(left, this.offset.width - this.blockOriginal.width);
				var top = Math.max(0, e.clientY - this.offset.top - this.y);
				top = Math.min(top, this.offset.height - this.blockOriginal.height);
				block.css({
					left : left,
					top : top
				});
				this.cropper.hide();
			} else {
				var offset = this.fun(e);
				block.css(offset);
			}
			
			this.setImg();
			this.moveCallBack();
		},
		down : function(e) {
			var blockOriginal = this.blockOriginal, sTop = Math.max(dBody.scrollTop, dDoc.scrollTop), // 出现垂直方向滚动条时候 要计算这个
			offset = this.offset;

			if (e.clientY - offset.top >= blockOriginal.top - sTop) {
				var height = Math.min(offset.height - blockOriginal.top, e.clientY - offset.top - blockOriginal.top + sTop), top = blockOriginal.top;
			} else {
				var height = Math.min(offset.top + blockOriginal.top - e.clientY - sTop, blockOriginal.top), top = Math.max(e.clientY - offset.top + sTop, 0);
			}
			return {
				height : height,
				top : top
			};
		},
		up : function(e) {
			var blockOriginal = this.blockOriginal, sTop = Math.max(dBody.scrollTop, dDoc.scrollTop), offset = this.offset;
			if (e.clientY - offset.top - blockOriginal.height <= blockOriginal.top - sTop) {
				var top = Math.max(e.clientY - offset.top + sTop, 0), maxHeight = blockOriginal.top + blockOriginal.height, height = Math.min(maxHeight, blockOriginal.top + blockOriginal.height - (e.clientY - offset.top) - sTop);
			} else {
				var height = Math.min(e.clientY - offset.top - blockOriginal.top - blockOriginal.height + sTop, offset.height - blockOriginal.top - blockOriginal.height), top = blockOriginal.top + blockOriginal.height;
			}
			return {
				height : height,
				top : top
			};
		},
		left : function(e) {
			var blockOriginal = this.blockOriginal, offset = this.offset;

			if (e.clientX - offset.left - blockOriginal.width - blockOriginal.left <= 0) {
				var left = Math.max(e.clientX - offset.left, 0), width = Math.min(blockOriginal.left + blockOriginal.width, blockOriginal.left + blockOriginal.width - (e.clientX - offset.left));
			} else {
				var width = Math.min(e.clientX - offset.left - blockOriginal.left - blockOriginal.width, offset.width - blockOriginal.left - blockOriginal.width), left = blockOriginal.left + blockOriginal.width;
			}
			return {
				left : left,
				width : width
			};
		},
		right : function(e) {
			var blockOriginal = this.blockOriginal, offset = this.offset;
			if (e.clientX - offset.left >= blockOriginal.left) {
				var width = Math.min(offset.width - blockOriginal.left, e.clientX - offset.left - blockOriginal.left), left = blockOriginal.left;
			} else {
				var width = Math.min(offset.left + blockOriginal.left - e.clientX, blockOriginal.left), left = Math.max(e.clientX - offset.left, 0);
			}
			return {
				left : left,
				width : width
			};
		},
		rightDown : function(e) {
			return $.extend(this.right(e), this.down(e));
		},
		leftDown : function(e) {
			return $.extend(this.left(e), this.down(e));
		},
		rightUp : function(e) {
			return $.extend(this.right(e), this.up(e));
		},
		leftUp : function(e) {
			return $.extend(this.left(e), this.up(e));
		},
		getValue : function() {
			var block = this.block;
			return {
				left : parseInt(block.css("left")),
				top : parseInt(block.css("top")),
				width : block.width(),
				height : block.height()
			}
		}
	}
	$.fn.clip = function(options) {
		options.container = this;
		return new clip(options);
	}
})();
xx = $("#container").clip({
	imgC : $("#imgC")
})