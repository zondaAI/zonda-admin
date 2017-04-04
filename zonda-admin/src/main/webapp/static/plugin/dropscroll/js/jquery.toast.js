(function(b) {
	b.fn.toast = function(c) {
		return new a(this[0], c)
	};
	var a = (function() {
		var c = function(e, d) {
			if (typeof e === "string" || e instanceof String) {
				this.container = document.getElementById(e)
			} else {
				this.container = e
			}
			if (!this.container) {
				window.alert("error finding container for toast " + e);
				return
			}
			if (typeof (d) === "string" || typeof (d) === "number") {
				d = {
					message : d
				}
			}
			this.styleType = d.styleType || 1;
			this.width = d.width || this.width;
			this.height = d.height || this.height;
			this.cls = d.cls ? d.cls : "";
			this.message = d.message || "";
			this.delay = d.delay || this.delay;
			this.position = d.position || "";
			this.cls += " " + this.position;
			this.type = d.type || "";
			this.autoClose = d.autoClose || this.autoClose;
			this.textAlign = d.textAlign || this.textAlign;
			this.keyUp = d.keyUp || this.keyUp;
			this.container = b(this.container);
			if (this.container.find(".mjdToastContainer").length === 0) {
				this.container.append("<div class='mjdToastContainer'></div>")
			}
			this.container = this.container.find(".mjdToastContainer");
			this.container.removeClass("tr tb br tl tc bc");
			if (d.autoClose === false) {
				d.autoClose = false
			}
			this.show()
		};
		c.prototype = {
			cls : null,
			message : null,
			delay : 2000,
			styleType : 1,
			el : null,
			container : null,
			timer : null,
			width : 145,
			height : 88,
			autoClose : true,
			textAlign : "center",
			marginTop : -44,
			keyUp : false,
			show : function() {
				var e = this;
				var g = this.addHtml();
				this.el = b(g).get(0);
				this.container.append(this.el);
				var f = b(e.el);
				var d = e.height;
				var i = f.find(".messge-box");
				if (e.keyUp) {
					b(".messge-box").addClass("marT")
				}
				i.css("width", e.width);
				i.css("marginLeft", -e.width / 2);
				i.css("marginTop", e.marginTop);
				i.removeClass("hidden");
				var h = f.find(".messge-box-content");
				h.css("text-align", e.textAlign);
				if (e.autoClose) {
					e.timer = setTimeout(function() {
						e.hide()
					}, this.delay)
				}
				f.bind("click", function() {
					e.hide()
				})
			},
			hide : function() {
				var d = this;
				if (d.timer != null) {
					clearTimeout(d.timer)
				}
				b(d.el).unbind("click").addClass("hidden");
				b(d.el).css("height", "0");
				d.remove()
			},
			remove : function() {
				var d = b(this.el);
				d.remove()
			},
			addHtml : function() {
				var e = this;
				var d = "";
				switch (e.styleType) {
				case 1:
					d = '<div class="message-floor">';
					d += '<div class="messge-box">';
					d += '<div class="messge-box-icon"><i class="message-icon ' + e.cls + '"></i></div>';
					d += '<div class="messge-box-content">' + e.message + "</div>";
					d += "</div>";
					d += "</div>";
					break;
				default:
					d = "";
					break
				}
				return d
			}
		};
		return c
	})();
	b.toast = function(c) {
		b(document.body).toast(c)
	}
})($);
// 弹出提示
function toastTips(b) {
	clearTimeout(a);
	var a = setTimeout(function() {
		$.toast({
			message : b,
			height : 105,
			width : 200,
			textAlign : "center",
			cls : "error-icon"
		})
	}, 500)
}
// 弹出加载中......
function toastLoading(msg) {
	var $loadDiv = $("#loadToastContainer");
	if ($loadDiv.length > 0) {
		if ($loadDiv.is(":hidden")) {
			msg ? $("#loadMsg").text(msg) : "";
			$loadDiv.show();
		}
	} else {
		$loadDiv = $('<div id="loadToastContainer">' + '<div class="modal" id="mymodal" style="display:block;">' + '<div class="modal-dialog alert-box alert-box01" style="width: 200px;margin-left: -100px;margin-top: -44px;text-align: center;position: absolute;top: 50%;left: 50%;">' + '<img style="display: inline-block;" src="/static/images/preloading.gif">' + '<p id="loadMsg" style="font-size:12px; color:#FFFFFF;; line-height:30px;">' + (msg ? msg : '') + '</p>' + '</div>' + '</div>' + '<div class="modal-backdrop in" style="opacity: .5;"></div>' + '</div>');
		$("body").append($loadDiv);
		$("#loadToastContainer").show();
	}
}
//弹出加载中......关闭
function toastLoadingClose() {
	$("#loadToastContainer").hide();
}