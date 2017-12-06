/**
 * 效果类工具
 */


var effectUtils={
	icoButtonTime:200,
	liTime:200,
	//字体、图标点击
	iButtonClick:function(){
		$("i[data-type=fontIcon]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("iconActive");
			setTimeout(function(){
				iButton.removeClass("iconActive")
			},effectUtils.icoButtonTime);
	 	});
	 	$("i[data-type=fontIconWhite]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("iconActiveWhite");
			setTimeout(function(){
				iButton.removeClass("iconActiveWhite")
			},effectUtils.icoButtonTime);
	 	});
	},
	liClick:function(){
		//深色tab栏、背景块点击效果
		$("li[data-type=blackTab]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("textTabBlackActive");
			setTimeout(function(){
				iButton.removeClass("textTabBlackActive")
			},effectUtils.liTime);
	 	});
	 	//浅色tab栏、背景块点击效果
		$("li[data-type=whiteTab]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("textTabwhiteActive");
			setTimeout(function(){
				iButton.removeClass("textTabwhiteActive")
			},effectUtils.liTime);
	 	});
	},
	spanClick:function(){
		$("span[data-type=blackTab]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("textTabBlackActive");
			setTimeout(function(){
				iButton.removeClass("textTabBlackActive")
			},effectUtils.liTime);
	 	});
	 	$("span[data-type=whiteTab]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("whiteTabDiv");
			setTimeout(function(){
				iButton.removeClass("whiteTabDiv")
			},effectUtils.liTime);
	 	});
		$("span[data-type=yellowButton]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("yellowButton");
			setTimeout(function(){
				iButton.removeClass("yellowButton")
			},effectUtils.liTime);
	 	});
		$("span[data-type=blueButton]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("blueButton");
			setTimeout(function(){
				iButton.removeClass("blueButton")
			},effectUtils.liTime);
	 	});
		$("span[data-type=redButton]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("redButton");
			setTimeout(function(){
				iButton.removeClass("redButton")
			},effectUtils.liTime);
	 	});
	},
	//div
	divClick:function(){
		//红色按钮
		$("div[data-type=redButton]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("redButton");
			setTimeout(function(){
				iButton.removeClass("redButton")
			},effectUtils.liTime);
		});
		//蓝色按钮
		$("div[data-type=blueButton]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("blueButton");
			setTimeout(function(){
				iButton.removeClass("blueButton")
			},effectUtils.liTime);
		});
		//黄色按钮
		$("div[data-type=yellowButton]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("yellowButton");
			setTimeout(function(){
				iButton.removeClass("yellowButton")
			},effectUtils.liTime);
		});
		//白色块
		$("div[data-type=whiteTab]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("whiteTabDiv");
			setTimeout(function(){
				iButton.removeClass("whiteTabDiv")
			},effectUtils.liTime);
		});
		//深色块
		$("div[data-type=blackTab]").on("click",function(){
			var iButton=$(this);
			iButton.addClass("textTabBlackActive");
			setTimeout(function(){
				iButton.removeClass("textTabBlackActive")
			},effectUtils.liTime);
		});
	}
}

/**
 * 初始化
 */
$(function(){
	//特效绑定
	effectUtils.iButtonClick();
	effectUtils.liClick();
	effectUtils.divClick();
	effectUtils.spanClick();
})



/**=====================================================*/

(function($){
	var Page=function(settings){
		this.name=settings.name;
		this.title=settings.title;
		this.onload=settings.onload;
		this.loginButton=settings.loginButton;
	};
	
	var Button=function(settings){
		this.id=settings.id;
		this.obj=settings.obj;
		this.text=settings.text;
		this.onclick=settings.onclick;
		this.clickEffect=settings.clickEffect;
		this.obj.on("click",this.onclick)
	};
	
	var Effect=function(settings){
		this.obj=settings.obj;
		this.type=settings.type;
		if(this.type=="0"){
			this.obj.on("click",function(){
					var iButton=$(this);
					iButton.addClass("textTabBlackActive");
					setTimeout(function(){
					iButton.removeClass("textTabBlackActive")
				},effectUtils.liTime);
			})
		}
	}
	
	var page=new Page({
		name:"test",
		title:"首页",
		onload:function(){
			console.log("页面加载");
		},
		loginButton:new Button({
			id:"1",
			text:"登录",
			obj:$("#buttonId"),
			onclick:function(){
				console.log("按钮点击")
			},
			clickEffect:new Effect({
				obj:page.loginButton;
				type:"0"
			})
		})
	1})
})(jQuery,Zepto)





