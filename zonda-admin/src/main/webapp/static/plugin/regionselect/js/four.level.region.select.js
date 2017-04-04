/**
 * 手机端H5地市选择插件. <br>
 * 类详细说明.
 * @param n
 * 		原始页面顶层标签ID
 * @param e
 * 		地市选择页面顶层标签ID
 * @param y
 * 		触发地市选择处顶层标签ID
 * @param k
 * 		触发地市选择处标签ID
 * @param u
 * 		回调函数
 * @param D
 * 		地市数据拉取请求地址(数组)
 * @param r
 * <p>
 * Copyright: Copyright (c) 2016年10月21日 下午4:08:39
 * <p>
 * Company: 苏州宽连信息技术有限公司
 * <p>
 * 
 * @author zhujl@c-platform.com
 * @version 1.0.0
 */
function checkPageSelectAddress(n, e, y, k, u, D, r) {
	var r = r || null;
	var D = D || [ "selectProvince.action", "selectCity.action?REGION_CODE=", "selectArea.action?REGION_CODE=", "selectTown.action?REGION_CODE=" ];
	var o = document.getElementById(e);
	var n = document.getElementById(n);
	var y = document.getElementById(y);
	var i = G_CTX_ROOT + "/plugin/";
	var d = [ {
		REGION_NAME : "",
		REGION_CODE : "",
		liIndex : 0
	}, {
		REGION_NAME : "",
		REGION_CODE : "",
		liIndex : 0
	}, {
		REGION_NAME : "",
		REGION_CODE : "",
		liIndex : 0
	}, {
		REGION_NAME : "",
		REGION_CODE : "",
		liIndex : 0
	} ];
	var p = 0;
	var C = o.querySelector("#headAddressUl");
	var B = C.children;
	var b = o.querySelector("#addressContentDiv");
	var x = b.children;
	var l = "";
	var k = document.getElementById(k);
	var j;
	var h = document.getElementById("addressContainer");
	var v = document.querySelector(".head-fix");
	var E = document.querySelector("#goBack");
	var t = true;
	var A = 0;
	var s = document.querySelector(".is-loading");
	
	/**  */
	var f = function(H, F) {
		var w = "";
		j = x[0].offsetWidth;
		if (F) {
			B[parseInt(F) - 1].innerHTML = d[parseInt(F) - 1].REGION_NAME
		}
		if (!H.addressList.length) {
			for (var G = parseInt(F); G < 4; G++) {
				d[G].REGION_NAME = "";
				d[G].REGION_CODE = 0
			}
			l = d[0].REGION_NAME.trim() + d[1].REGION_NAME.trim() + d[2].REGION_NAME.trim() + d[3].REGION_NAME.trim();
			for (var G = 0; G < 4; G++) {
				globalObj.address[G].REGION_NAME = d[G].REGION_NAME.trim();
				globalObj.address[G].REGION_CODE = d[G].REGION_CODE
			}
			B[F - 1].innerHTML = "\u8bf7\u9009\u62e9";
			window.location.hash = "#checkpage"
		} else {
			B[F].innerHTML = "\u8bf7\u9009\u62e9";
			for (var G = 0; G < 4; G++) {
				B[G].classList.remove("head-address-li")
			}
			B[F].classList.add("head-address-li");
			for (var G = 0; G < H.addressList.length; G++) {
				w += "<li dataId=" + H.addressList[G].REGION_CODE + " liIndex=" + (G + 1) + ">" + H.addressList[G].REGION_NAME + "</li>"
			}
			x[F].innerHTML = w;
			b.style.transform = "translate(" + -j * F + "px,0px) translateZ(0px)";
			b.style.WebkitTransform = "translate(" + -j * F + "px,0px) translateZ(0px)"
		}
	};
	/**  */
	var c = function(I, G) {
		var w = "";
		j = document.documentElement.clientWidth;
		var F = 0;
		if (G) {
			B[parseInt(G) - 1].innerHTML = globalObj.address[parseInt(G) - 1].REGION_NAME
		}
		B[G].innerHTML = "\u8bf7\u9009\u62e9";
		for (var H = 0; H < 4; H++) {
			B[H].classList.remove("head-address-li")
		}
		B[G].classList.add("head-address-li");
		for (var H = 0; H < I.addressList.length; H++) {
			w += "<li dataId=" + I.addressList[H].REGION_CODE + " liIndex=" + (H + 1) + ">" + I.addressList[H].REGION_NAME + "</li>";
			if (I.addressList[H].REGION_CODE == globalObj.address[G].REGION_CODE) {
				F = H + 1
			}
		}
		x[G].innerHTML = w;
		x[G].children[parseInt(F - 1)].classList.add("checked-color");
		x[G].children[parseInt(F - 1)].innerHTML = x[G].children[parseInt(F - 1)].innerHTML + '<span class="check-pic"></span>';
		d[G].liIndex = F;
		A++
	};
	/** 地市数据拉取AJAX方法 */
	var z = function(F, w) {
		$.ajax({
			type : "get",
			url : F,
			dataType : "json",
			beforeSend : function() {
				s.style.display = "block"
			},
			success : function(G) {
				s.style.display = "none";
				if (t) {
					f(G, p)
				} else {
					c(G, A);
					if (w) {
						w()
					}
				}
			},
			error : function(H, G) {
				s.style.display = "none"
			}
		})
	};
	/**  */
	var m = function() {
		if (!p && !globalObj.address[0].REGION_NAME) {
			n.style.display = "none";
			s.style.display = "block";
			z(i + D[0]);
			s.style.display = "none";
			o.style.display = "block";
			if ($("#m_common_header").length > 0) {
				$("#m_common_header").hide()
			}
		} else {
			if (!p && globalObj.address[0].REGION_NAME) {
				t = false;
				A = 0;
				z(i + D[0], function() {
					n.style.display = "none";
					s.style.display = "block";
					if (globalObj.address[3].REGION_NAME) {
						z(i + D[1] + globalObj.address[0].REGION_CODE, function() {
							z(i + D[2] + globalObj.address[1].REGION_CODE, function() {
								z(i + D[3] + globalObj.address[2].REGION_CODE, F)
							})
						})
					} else {
						if (globalObj.address[2].REGION_NAME) {
							z(i + D[1] + globalObj.address[0].REGION_CODE, function() {
								z(i + D[2] + globalObj.address[1].REGION_CODE, F)
							})
						} else {
							if (globalObj.address[1].REGION_NAME) {
								z(i + D[1] + globalObj.address[0].REGION_CODE, F)
							}
						}
					}
				});
				function F() {
					for (var G = 0; G < 4; G++) {
						d[G].REGION_CODE = globalObj.address[G].REGION_CODE;
						d[G].REGION_NAME = globalObj.address[G].REGION_NAME
					}
					b.style.transform = "translate(" + -j * (A - 1) + "px,0px) translateZ(0px)";
					b.style.WebkitTransform = "translate(" + -j * (A - 1) + "px,0px) translateZ(0px)";
					t = true;
					s.style.display = "none";
					if ($("#m_common_header").length > 0) {
						$("#m_common_header").hide()
					}
					o.style.display = "block"
				}
			} else {
				n.style.display = "none";
				if ($("#m_common_header").length > 0) {
					$("#m_common_header").hide()
				}
				o.style.display = "block"
			}
		}
		setTimeout(function() {
			b.style.height = (document.documentElement.clientHeight - 89) + "px"
		}, 600);
		E.onclick = function() {
		};
		for (var w = 0; w < 4; w++) {
			(function(G) {
				x[G].onclick = function(K) {
					var I = K || event;
					var H = I.srcElement || I.target;
					if (H.getAttribute("liindex")) {
						if (H.className.indexOf("check-pic") != -1) {
							H = H.parentNode
						}
						if (parseInt(d[G].liIndex) && this.children[parseInt(d[G].liIndex) - 1] && this.children[parseInt(d[G].liIndex) - 1].className.indexOf("checked-color") != -1) {
							this.children[parseInt(d[G].liIndex) - 1].classList.remove("checked-color");
							this.children[parseInt(d[G].liIndex) - 1].innerHTML = this.children[parseInt(d[G].liIndex) - 1].innerHTML.replace('<span class="check-pic"></span>', "")
						}
						H.classList.add("checked-color");
						d[G].REGION_NAME = H.innerHTML;
						H.innerHTML = H.innerHTML + '<span class="check-pic"></span>';
						d[G].REGION_CODE = H.getAttribute("dataId");
						d[G].liIndex = H.getAttribute("liIndex");
						p = G + 1;
						if (G == 3) {
							l = d[0].REGION_NAME.trim() + d[1].REGION_NAME.trim() + d[2].REGION_NAME.trim() + d[3].REGION_NAME.trim();
							for (var J = 0; J < 4; J++) {
								globalObj.address[J].REGION_NAME = d[J].REGION_NAME.trim();
								globalObj.address[J].REGION_CODE = d[J].REGION_CODE.trim()
							}
							window.location.hash = "#checkpage"
						} else {
							z(i + D[p] + d[G].REGION_CODE)
						}
					}
				}
			})(w)
		}
		C.onclick = function(K) {
			var H = K || event;
			var G = H.srcElement || H.target;
			var I;
			if (parseInt(G.getAttribute("mytitle")) >= 0) {
				if (G.innerHTML != "" && G.innerHTML != "\u8bf7\u9009\u62e9") {
					I = G.getAttribute("mytitle");
					G.innerHTML = "\u8bf7\u9009\u62e9";
					for (var J = parseInt(I) + 1; J < 4; J++) {
						B[J].innerHTML = ""
					}
					for (var J = 0; J < 4; J++) {
						B[J].classList.remove("head-address-li")
					}
					B[I].classList.add("head-address-li");
					b.style.transform = "translate(" + -j * I + "px,0px) translateZ(0px)";
					b.style.WebkitTransform = "translate(" + -j * I + "px,0px) translateZ(0px)"
				}
			}
		}
	};
	/**  */
	var q = function() {
		n.style.display = "block";
		o.style.display = "none";
		if ($("#m_common_header").length > 0) {
			$("#m_common_header").show()
		}
		y.onclick = function() {
			window.location.hash = "#chooseAddressPage"
		};
		if (l) {
			k.innerHTML = l
		}
		if (globalObj.address[0].REGION_NAME) {
			u()
		}
	};
	/**  */
	var a = function() {
		globalObj.reNum++;
		if (globalObj.reNum > 1) {
			try {
				var F = localStorage.getItem("reNum");
				localStorage.setItem("reNum", ++F)
			} catch (G) {
			}
		}
		var w = window.location.hash;
		if (w == "#chooseAddressPage") {
			m()
		} else {
			if (w == "") {
				q();
				if (r == "orderForWanshan") {
					setTimeout(function() {
						r = "";
						window.location.hash = "#chooseAddressPage"
					}, 100)
				}
			} else {
				q()
			}
		}
	};
	/** 函数入口 */
	var g = function() {
		a()
	};
	window.addEventListener("load", g, false);
	window.addEventListener("hashchange", g, false)
}