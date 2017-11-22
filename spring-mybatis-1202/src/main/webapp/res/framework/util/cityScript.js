var citySelector = {};

citySelector.pc = new Array();

/**
 * 初始化城市选择器
 */
citySelector.cityInit = function (input,valueId) {
	
  citySelector.hotCity = ["2,北京市", "708,哈尔滨市", "862,上海", "2135,广州","2161,深圳","516,大连","2507,成都","501,沈阳","1499,青岛","1009,杭州","1855,武汉","2466,重庆"];

	citySelector.hotCityhtmls = "";
	citySelector.provHtmls = "";
	for (var j = 0; j < citySelector.pc.length; j++) {
		
	    citySelector.provHtmls += "<li data-xuhao='" + j + "'><span class='provinceName'>" + citySelector.pc[j][0] + "</span></li>";
	}
	for (var i = 0; i < citySelector.hotCity.length; i++) {
		var cityName=citySelector.hotCity[i].split(",");
	    citySelector.hotCityhtmls += "<li class='js_cityName' id='"+cityName[0]+"'>" + cityName[1] + "</li>";
	}

	citySelector.template = '<div class="city-box" id="js_cityBox"><div class="prov-city" id="js_provCity"><p>热门城市</p><ul>' + citySelector.hotCityhtmls + '</ul></div><div class="provence"><div>选择省份</div><div><ul id="js_provList">' + citySelector.provHtmls + '</ul></div></div></div>';

	$("body").append(citySelector.template);
	var label = "false";
	$("#js_provList").on("click", ".provinceName", function () {
        function createUl(_this){
            _this.css({ "background": "#fff", "border-color": "#d8d8d8", "border-bottom-color": "#fff", "position": "absolute", "top": "0", "left": "0", "z-index": "999999" });
            var xuhao = _this.parent("li").attr("data-xuhao"),
                cityArr = citySelector.pc[xuhao][1].split("|"),
                cityHtmls = "<ul id='js_provCitys'>";
            for (var i = 0; i < cityArr.length; i++) {
            	var cityName=cityArr[i].split(",");
            	
                cityHtmls += "<li class='js_cityName' id=\""+cityName[0]+"\">" + cityName[1] + "</li>";
            }
            cityHtmls += "</ul>";
            $("#js_provCitys").remove();
            _this.parent("li").append(cityHtmls);
        }

        if (label == "false") {
            label = "true";
            $(this).attr("now-item", "true");
            createUl($(this));
        }
        else {
            if ($(this).attr("now-item") == "" || $(this).attr("now-item") == "false" || $(this).attr("now-item") == undefined) {
                $(this).parents("#js_provList").find("span").attr("now-item", "false");
                $(this).attr("now-item", "true");
                $("#js_provList span").css({ "background": "", "border-color": "", "border-bottom-color": "", "position": "", "top": "", "left": "", "z-index": "" });
                $("#js_provCitys").remove();
                createUl($(this));
            }
            else {
                label = "false";
                $(this).css({ "background": "", "border-color": "", "border-bottom-color": "", "position": "", "top": "", "left": "", "z-index": "" });
                $("#js_provCitys").remove();
            }
        }

    });

    var _input = input;
    $("#js_cityBox").on("click", ".js_cityName", function (e) {
        e.stopPropagation();
        
        var api = frameElement.api;
  		var w = api.opener;
  		
  		//给输入框赋城市名称
        $("#" + _input,w.document).val($(this).html());
        //给隐藏域赋城市ID值
        $("#"+valueId,w.document).val($(this).attr("id"));
  		api.close();
    });
   
	
    /*
    $("#" + input).click(function () {

        $("#js_cityBox").remove();
        

        var _top = $(this).offset().top + 40,
            _left = $(this).offset().left,
            _width = $(window).width();
        if (_width - _left < 450) {
            $("#js_cityBox").css({ "top": _top + "px", "right": "0px" }).addClass("rightSelector");
        }
        else {
            $("#js_cityBox").css({ "top": _top + "px", "left": _left + "px" });
        }

       
        
    });*/
}