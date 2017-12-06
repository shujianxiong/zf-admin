var Constants={
		SUCCESS:1,
		ERROR:0,
		PARAMETER_ERROR:22,
		NOTFIND:404,
		SYSERROR:500,
		PARAMETER_ISNULL:16,
		NOT_LOGIN:21,
		SMSCODE_ERROR:203,
		USERCODE_EXIST_ONE:201,
		USERCODE_EXIST_TWO:202,
		REPWD_ERROR:204,
		REPWD_LENGTH_ERROR:205,
		USERCODE_LENGTH_NULL:206,
		OLD_PASSWORD_ERROR:207,
		EDIT_PASSWORD_SUCCESS:208,
		IDCARD_UPLOAD_NULL:210,
		IDCARD_COMPLETE:211,
		IDCARD_FORMAT_ERROR:212,
		MOBILE_EXIST:213,
		ACCOUNTS_FREEZE:214,
		ACCOUNTS_LIMIT:215,
		OPENID_ERROR:217,
		INVITECODE_ERROR:230,
		INVITECODE_UNMATCH:231,
		tipStatus:function(status){
			status=parseInt(status);
			console.log(status)
			switch(status){
				case this.NOTFIND:
					tip.autoShow("您访问的地址被程序猿吃掉了!0_0!")
					break;
				case this.SYSERROR:
					tip.autoShow("哇！系统出错了,妈咪妈咪哄召唤攻城师！！")
					break;
				case this.PARAMETER_ERROR:
					tip.autoShow("请求参数错误! ")
					break;
				case this.SUCCESS:
					tip.autoShow("操作成功!")
					break;
				case this.ERROR:
					tip.autoShow("操作失败!")
					break;
				case this.PARAMETER_ISNULL:
					tip.autoShow("必填项不能为空!")
					break;
				case this.SMSCODE_ERROR:
					tip.autoShow("验证码错误!")
					break;
				case this.USERCODE_EXIST_ONE:
					tip.autoShow("用户名或密码不正确!")
					break;
				case this.USERCODE_EXIST_TWO:
					tip.autoShow("用户名已存在,请登录!")
					break;
				case this.REPWD_ERROR:
					tip.autoShow("两次密码输入不一致!")
					break;
				case this.REPWD_LENGTH_ERROR:
					tip.autoShow("密码必须是字母和数字组合!")
					break;
				case this.NOT_LOGIN:
					$("#loginPanel").css("display","block");
					break;
				case this.USERCODE_LENGTH_NULL:
					tip.autoShow("您的手机号还未注册!")
					break;
				case this.OLD_PASSWORD_ERROR:
					tip.autoShow("原密码输入错误!")
					break;
				case this.EDIT_PASSWORD_SUCCESS:
					tip.autoShow("密码修改成功,请重新登录!")
					break;
				case this.IDCARD_UPLOAD_NULL:
					tip.autoShow("请上传您的身份证正反面照片!")
					break;
				case this.IDCARD_COMPLETE:
					tip.autoShow("您的身份信息已提交过！")
					break;
				case this.IDCARD_FORMAT_ERROR:
					tip.autoShow("您的身份号码格式不正确！")
					break;
				case this.MOBILE_EXIST:
					tip.autoShow("该手机号已绑定！")
					break;	
				case this.ACCOUNTS_FREEZE:
					tip.autoShow("该账户已被冻结,请联系客服！")
					break;	
				case this.ACCOUNTS_LIMIT:
					tip.autoShow("该账户已被限制登陆,请联系客服！")
					break;
				case this.OPENID_ERROR:
					tip.autoShow("用户微信Openid异常！")
					break;
				case this.INVITECODE_ERROR:
					tip.autoShow("该邀请码不存在或不在活动时间内！")
					break;
				case this.INVITECODE_UNMATCH:
					tip.autoShow("该邀请码不适合当前活动！")
					break;
				default:
					tip.autoShow("默认")
					break;
			}
		}
}

/**
 * 工具
 * 20151217 v1.0
 */

function Client(){
	var me=this;
	this.maxNum=150;//最大人数
	this.minNum=20;//最小人数
	this.randomShoppingNum=function(){
		var shoppingNum={};
		while(true){
			var maxNum=Math.round(Math.random()*me.maxNum)
			if(maxNum>me.minNum){
				shoppingNum.maxNum=maxNum;
				while(true){
					var minNum=Math.round(Math.random()*maxNum)
					if(minNum>me.minNum&&minNum<maxNum){
						shoppingNum.minNum=minNum;
						return shoppingNum;
					}
				}
			}
		}
	};
}

/**
 * iscroll click判断
 * @returns
 */
function iScrollClick(){
	if (/iPhone|iPad|iPod|Macintosh/i.test(navigator.userAgent)) return false;
	if (/Chrome/i.test(navigator.userAgent)) return (/Android/i.test(navigator.userAgent));
	if (/Silk/i.test(navigator.userAgent)) return false;
	if (/Android/i.test(navigator.userAgent)) {
	   var s=navigator.userAgent.substr(navigator.userAgent.indexOf('Android')+8,3);
	   return parseFloat(s[0]+s[3]) < 44 ? false : true
    }
}

/**
 * cookie读写工具
 */
var cookieUtil={
		setCookie:function(name,value){
			var Days = 30; 
		    var exp = new Date(); 
		    exp.setTime(exp.getTime() + Days*24*60*60*1000); 
		    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString
		},
		getCookie:function(name){
			var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)"); 
		    if(arr=document.cookie.match(reg))
		        return unescape(arr[2]); 
		    else 
		        return null; 
		},
		delCookie:function(){
			var exp = new Date(); 
		    exp.setTime(exp.getTime() - 1); 
		    var cval=getCookie(name); 
		    if(cval!=null) 
		        document.cookie= name + "="+cval+";expires="+exp.toGMTString(); 
		}
}

/**
 * 数据验证
 * 参数obj 为jquery对象
 * 参数formObj 为dom对象
 */
var formValidate={
		formInputIsNotNull:function(formObj){
			var isNull=false;
			$("input[type=text]",formObj).each(function(){
				if(formValidate.isNull($(this)))
					isNull=true;
		 	});
			if(isNull){
				tip.autoShow("请完善表单填写");
				return false;
			}else{
				return true;
			}
		},
		formDataNotNull:function(formObj){
			var isNull=false;
			var str="";
			$("input[data-notnull]",formObj).each(function(){
				if(formValidate.isNull($(this))){
					isNull=true;
					str=this.placeholder+"\r\n";
				}
		 	});
			if(isNull){
				tip.autoShow(str);
				return false;
			}else{
				return true;
			}
		},
		formSubmit:function(formObj){
			if(formValidate.formDataNotNull(formObj)){
				formObj.submit();
			}
		},
		formFormatSubmit:function(formatValidate,formObj){
			if(!formatValidate())
				return;
			if(formValidate.formDataNotNull(formObj)){
				formObj.submit();
			}
		},
		isNull:function(obj){
			if(obj.val()!=null&&obj.val().length>0)
				return false;
			return true;
		},
		isPhone:function(obj){
			if(formValidate.isNull(obj))
				return false;
			var reg = /^1[3|4|5|8][0-9]\d{4,8}$/;
    		return reg.test(obj.val());
		}
}

/**
 * 提示工具
 */
var tip={
		autoHideTime:3000,
		show:function(str){
			$(".tip").text(str);
			$("#tip").show();
		},
		hide:function(){
			$(".tip").text("");
			$("#tip").hide();
		},
		autoShow:function(str){
			tip.show(str);
			var timer=setTimeout("tip.hide()",tip.autoHideTime);
		},
		//带遮罩的(比如提交成功或者关注成功提示，需要用户点击确定关闭)
		showMark:function(str){
			$("#tipTest").text(str);
			$("#remind").show();
		},
		hideMark:function(){
			$("#tipTest").text("");
			$("#determine").text("确定");
			$("#remind").hide();
		},
		autoShowMark:function(str){
			tip.showMark(str);
			$("#determine").on("click",function(){
				tip.hideMark();
			})
		}
}

/**
 * 事件类工具集合
 */
var myEvent={
		//输入框change检测，自动触发回调
		inputChange:{
			input:null,
			text:"",
			callBack:null,
			star:function(obj,callBack){
				this.input=obj;
				this.text=obj.val();
				this.callBack=callBack;
				var time=setInterval(this.check, 500)
				obj.on('blur',function(){  
		            clearInterval(time);  
		        });
			},
			check:function(){
				if(formValidate.isNull(myEvent.inputChange.input))
					return;
				if(myEvent.inputChange.input.val()!=myEvent.inputChange.text){
					myEvent.inputChange.callBack();
					myEvent.inputChange.text=myEvent.inputChange.input.val();
				}
			}
		}
}

//MyScroll对象
function MyScroll(scrollId,parameter){
	var me=this;
	//scroll相关
	me.scroll=new IScroll(scrollId,{
		click:true, //是否响应click事件
		probeType: 3,
		scrollbars: true,//滚动条可见
        fadeScrollbars: true,//滚动条渐隐
        useTransform: true,//CSS转化
        useTransition: true,//CSS过渡
	});
	me.scrollId=scrollId;
	me.scrollY;//scroll当前移动到的位置
	//MyScroll相关
	me.headerHeight=parameter.headerHeight;//拖动加载头部元素 ，整型
	me.header=parameter.header;//头部拖动加载元素，jquery对象
	me.bottom=parameter.bottom;//拖动加载底部元素 ，jquery对象
	me._bottomHtml="";//bottom原始頁面
	me.bottomEndHtml=parameter.bottomEndHtml==null?"已到达底部":parameter.bottomEndHtml;//拖动到底部显示内容 ，html文本， 字符串类型
	me.isImgCache=parameter.isImgCache==null?false:true;//是否启用延迟加载图片，默认不启用  ，布尔型
	me.isPage=parameter.isPage==null?true:parameter.isPage;//是否分页
	me.loadType=parameter.loadType;//加载数据类型:0 不加载 1底部加载 2顶部刷新 3底部加载且顶部刷新 ，整型
	me._loadType=-1;//触发加载的类型：-1 无触发 0底部触发 1顶部触发
	me.getParameter=parameter.getParameter;//加载数据获取对应请求参数方法 ，function类型
	me.goPage=parameter.goPage==null?1:parameter.goPage;//加载页码 默认1开始 ， 整型
	me._maxPage=0;//最大页数
	me.loadUrl=parameter.loadUrl;//请求数据路径 ，字符串类型
	me.loadSuccess=parameter.loadSuccess;//数据请求成功后回调 ，function类型
	me.clear=parameter.clear==null?function(){}:parameter.clear;//清除scroll内显示元素 ，function类型
	me.noDataView=parameter.noDataView;//如果没有数据显示内容对象 ，jquery对象或 html文本
	me.isLoading=parameter.isLoading==null?false:parameter.isLoading;//是否显示loading ，默认不显示 布尔型
	me._getUrl=function(){
		if(me.isPage)
			return me.loadUrl+"/"+me.goPage;
		else
			return me.loadUrl;
	};
	//加载数据
	me.load=function(){
		var url=me._getUrl();
		console.log("请求地址:"+url)
		var data=me.getParameter();
		if(me.isLoading){
			$("#loadingPanel").css("display","block");
			me.header.css("display","none");
			me.bottom.css("display","none");
		}
		$.ajax({
		    type: "post",
		    url: url,
		    data: data,
		    success: function(data){
		    	if(me.isLoading){
					$("#loadingPanel").css("display","none");
					me.header.css("display","block");
					me.bottom.css("display","block");
				}
		    	var dataObj=$.parseJSON(data);
		    	if(dataObj.status!="1"){
		    		Constants.tipStatus(dataObj.status);
		    	}
		    	
		    	var page=dataObj.page;
		    	console.log("返回数据:")
		    	console.log(dataObj)
		    	
		    	//数据重置，限刷新
		    	if((me.loadType==2||me.loadType==3)&&me._loadType==1)
		    		me.clear();
		    	
		    	//效果处理
		    	//刷新--
	    		if((me.loadType==2||me.loadType==3)&&me._loadType==1){
	    			console.log("刷新处理")
	    			//变更头部高度
		    		var wrapper=$(scrollId);
		    		var top=wrapper.offset().top;
		    		var newTop=top-me.headerHeight;
		    		wrapper.css("top",newTop+"px");
	    		}
	    		
		    	//无内容检测
	    		if(page==null&&dataObj.data==null){
	    			console.log("无内容")
	    			if(typeof(me.noDataView)=="object"){
	    				me.noDataView.css("display","block");//显示没有内容提示
	    				if(me.bottom!=null)//清空底部loading
		    				me.bottom.html("");
	    			}else if(typeof(me.noDataView)=="string"){
	    				me.bottom.html(me.noDataView);
	    			}
	    		}else if(page!=null){
	    			if((page.list==null||page.list.length<=0)&&(page.last==null||page.last<=1)){
		    			console.log("无内容")
		    			if(typeof(me.noDataView)=="object"){
		    				me.noDataView.css("display","block");//显示没有内容提示
		    				if(me.bottom!=null)//清空底部loading
			    				me.bottom.html("");
		    			}else if(typeof(me.noDataView)=="string"){
		    				me.bottom.html(me.noDataView);
		    			}
			    	}else{
			    		//底部加载,底部加载必须为分页模式--
				    	if((me.loadType==1||me.loadType==3)||me._loadType==0){
				    		me._maxPage=page.last;//保存最大页数
				    		//检测是否已到达最后一页
				    		if(me.goPage >= me._maxPage&&me.bottom!=null){
				    			console.log("已经到达最后一页")
				    			me._bottomHtml=me.bottom.html();
			    				me.bottom.html(me.bottomEndHtml);
				    		}
				    		me.goPage++;//下次请求下一页
			    			console.log("下一页："+me.goPage+"  最大页数："+me._maxPage)
			    			console.log("----------------------------------------")
				    	}
			    	}
	    		}
	    		
	    		//数据展示
		    	if(dataObj.page==null&&dataObj.data!=null)
		    		me.loadSuccess(dataObj.data);
		    	else if(dataObj.page!=null&&dataObj.data==null){
		    		if(dataObj.page.list!=null&&dataObj.page.list.length>0)
			    		me.loadSuccess(dataObj.page.list);
		    	}
		    	
		    	//事件重新绑定
		    	if(me.loadType==1||me.loadType==2||me.loadType==3)
		    		me.scroll.on("scroll",me._touch);
		    	
		    	//图片延迟加载
		    	if(me.isImgCache){
		    		var array=$("img[data-type=lazyImg]");
		    		if(array.length>0)
		    			array.unveil(me.scroll);
		    	}
		    	
		    	//scroll刷新
		    	me.scroll.refresh();
		    },
		    error:function(){
		    	
		    }
		})
	};
	me._touchEnd=function(){
		if(me._loadType==0&&me.goPage<=me._maxPage){
			//当达到最大页数不再响应底部加载
			console.log("myscroll 底部加载")
			me.load();
			me.scroll.off("scrollEnd",me._touchEnd);
		}else if(me._loadType==1){
			//变更头部高度并刷新
    		console.log("myscroll 顶部加载")
    		me.refresh();
    		me.scroll.off("scrollEnd",me._touchEnd);
		}else if(me.loadType==2||me.loadType==3){
			//底部触发造成已达到最大页数,如支持顶部刷新模式才继续绑定scroll事件
			me.scroll.on("scroll",me._touch);
			me.scroll.off("scrollEnd",me._touchEnd);
		}
	};
	me._touch=function(){
		if(this.y<=this.maxScrollY&&(me.loadType==1||me.loadType==3)){
			me._loadType=0;//底部触发
			me.scroll.off("scroll",me._touch);
			me.scroll.on("scrollEnd",me._touchEnd);
		}
		if(this.y>=(me.headerHeight+40)&&(me.loadType==2||me.loadType==3)){
			me._loadType=1//顶部触发
			me.scroll.off("scroll",me._touch);
			me.scroll.on("scrollEnd",me._touchEnd);
		}
	};
	//刷新
	me.refresh=function(){
		me.scroll.off("scroll",me._touch);
		me.scroll.off("scroll",me._touchEnd);
		var wrapper=$(scrollId);
		var top=wrapper.offset().top;
		var newTop=top+me.headerHeight;
		wrapper.css("top",newTop+"px");
		me.scroll.refresh();
		//恢復原始bottomHtml樣式
		if((me.loadType==1||me.loadType==3)&&//启用底部加载模式
				me.goPage>me._maxPage&&//已达到底部，修改了底部加载样式
				me._bottomHtml!=null&&//原始样式未丢失
				me._bottomHtml!="")
			me.bottom.html(me._bottomHtml);
		//重置页码
		me.goPage=1;
		me._loadType=1;
		me.scrollY=0;
		me.load();
	};
	//暂停scroll
	me.suspend=function(){
		if(me.scroll==null)
			return;
		me.scrollY=me.scroll.y//保存当前浏览位置
		me.scroll.destroy();//销毁scroll
		me.scroll=null;//清除引用
	};
	//重新激活scroll
	me.active=function(){
		if(me.scroll!=null)
			return;
		//重新创建scroll
		me.scroll=new IScroll(me.scrollId,{
			click:true, //是否响应click事件
			probeType: 3,
			scrollbars: true,//滚动条可见
	        fadeScrollbars: true,//滚动条渐隐
	        useTransform: true,//CSS转化
	        useTransition: true,//CSS过渡
		});
		//恢复浏览位置
		me.scroll.scrollTo(0, me.scrollY, 0)
		//重新绑定事件
		me.scroll.on("scroll",me._touch);
	};
	//构造即初始化
	console.log("myscroll 初始化完毕")
	me.load();
	console.log("myscroll 数据加载中")
}

/**
 * ajax 工具
 */
var ajax={
		submit:function(type,url,data,successCallBack,errCallBack){
			$("#loadingPanel").css("display","block")
			$.ajax({
			    type: type,
			    url: url,
			    data: data,
			    success: function(data){
			    	if(typeof(data) != "object")
			    		data=$.parseJSON(data)
			    	$("#loadingPanel").css("display","none")
			    	if(data.status!=1){
			    		Constants.tipStatus(data.status);
			    		return;
			    	}
			    	successCallBack(data);
			    },
			    error:function(data){
			    	$("#loadingPanel").css("display","none")
			    	Constants.tipStatus(data.status)
			    	if(errCallBack!=null)
			    		errCallBack($.parseJSON(data));
			    }
			})
		}
}

/**
 * 快速登录
 */
var fastLogin={
		init:function(){
			$("img",$("#loginPanel")).on("click",function(){
				$("#loginPanelPwd").val("");
				$("#loginPanel").css("display","none")
			})
			$(".right",$("#loginPanel")).on("click",function(){window.location.href=ctxWeb+"/smsValidate"})
			$(".left",$("#loginPanel")).on("click",function(){
				var name=$("#loginPanelName").val();
				var val=$("#loginPanelPwd").val();
				if(name==null||name.length<=0){
					tip.autoShow("请填写您的帐号!");
					return;
				}
				if(val==null||val.length<=0){
					tip.autoShow("请填写您的密码!");
					return;
				}
				var data={"userCode":name,"pwd":val}
				var url=ctxWeb+"/fastLogin";
				ajax.submit("post",url,data,function(data){
					console.log(data)
					if(data.status=="1"){
						console.log("登录成功")
						history.go(0);
					}
				});
			})
		}
}

/**
 * 左右切换工具
 */
var leftTouch={
		mainPanel:null,//板块区父容器
		_items:new Array,//板块集合
		_maxLength:0,//最大长度
		width:0,//屏幕宽度
		index:0,//当前移动下标
		isActive:false,//是否启用导航激活切换模式
		activePanel:null,//激活区容器
		activeClass:null,//激活样式
		scroll:null,
		moveCallBack:null, 
		initCallBack:null,
		scrollArray:[],
		init:function(parameter){
			this.width=$(window).width();
			this.mainPanel=parameter.mainPanel
			this.isActive=parameter.isActive
			this.activePanel=parameter.activePanel
			this.activeClass=parameter.activeClass
			this.scroll=parameter.scroll
			this.initCallBack=parameter.initCallBack
			this.moveCallBack=parameter.moveCallBack
			$("div[data-type=item]",this.mainPanel).each(function(index){
				if(leftTouch.index==index){
					$(this).offset({left:0});
				}else{
					$(this).offset({left:-leftTouch.width});
				}
				leftTouch._items.push($(this));
				leftTouch._maxLength=index;
			})
			if(this.isActive){
				$("li[data-type=nav]",this.activePanel).on("click",function(){
					$("li[data-type=nav]",leftTouch.activePanel).each(function(){
			    		$(this).removeClass("active")
			    	});
			    	$(this).addClass("active");
			    })
			}
			if(this.initCallBack!=null)
				this.initCallBack();
		},
		move:function(moveIndex){
			if(leftTouch.index<moveIndex){
				//右移
				leftTouch._items[moveIndex].offset({left:-leftTouch.width});
				leftTouch._items[leftTouch.index].offset({left:-leftTouch.width});
				leftTouch._items[moveIndex].animate({left:0},150,function(){
					if(leftTouch.moveCallBack!=null)
						leftTouch.moveCallBack(moveIndex);
				})
			}else if(leftTouch.index>moveIndex){
				//左移
				leftTouch._items[moveIndex].offset({left:leftTouch.width});
				leftTouch._items[leftTouch.index].offset({left:-leftTouch.width});
				leftTouch._items[moveIndex].animate({left:0},150,function(){
					if(leftTouch.moveCallBack!=null)
						leftTouch.moveCallBack(moveIndex);
				})
			}
			leftTouch.index=moveIndex;
		}
}

/**
 * 猜你喜欢
 */
var recommendGoods={
		parameter:null,
		nextPage:null,
		nextButton:null,
		loadUrl:"",
		//isImgLazy:true,
		clear:null,
		init:function(parameter){
			this.parameter=parameter.getParameter;
			this.nextPage=parameter.nextPage;
			this.nextButton=parameter.nextButton;
			this.loadUrl=parameter.loadUrl;
			this.clear=parameter.clear;
			this.nextButton.on("click",this.load)
			this.load();
		},
		load:function(){
			$.ajax({
			    type: "post",
			    url: recommendGoods.loadUrl,
			    data: recommendGoods.parameter(),
			    success: function(data){
			    	data=$.parseJSON(data)
			    	recommendGoods.clear();
			    	recommendGoods.nextPage(data.data);
			    	/*if(recommendGoods.isImgLazy)//依赖lazyload框架
			    		$("img[data-type=lazyImg]").lazyload({effect : "fadeIn"});*/
			    },
			    error:function(data){
			    	Constants.tipStatus(data.status)
			    }
			})
		}
}

/**
 * 我猜按钮控制器
 * @param scroll 滚动容器可以为null
 * @param page 页面标记可以为空
 */
function SuspendBtn(scroll,page){
	$("#suspendPanel").css("display","block");
	$("#guessButton").on("click",function(){
		if($("#suspendView").css("display")=="none")
			$("#suspendView").fadeIn(400);
		else
			$("#suspendView").fadeOut(400);
	});
	$("#backTopButton").on("click",function(){
		if(scroll==null){
			scrollTo(0,0);
		}else{
			if(page=="index"){
				$("#header").fadeIn(400);
				isShow=true;
			}
			scroll.scrollTo(0,0,0);
		}
	});
	if(scroll==null){
		$(window).on("scroll",function(){
			$("#suspendPanel").fadeOut(400);
			$("#suspendView").fadeOut(400);
		});
		$(window).on("touchend",function(){
			$("#suspendPanel").fadeIn(400);
		});
	}else{
		scroll.on("scroll",function(){
			console.log("close")
			$("#suspendPanel").css("display","none");
		});
		scroll.on("scrollEnd",function(){
			console.log("open")
			$("#suspendPanel").css("display","block");
		});
	};
}

function WindowScroll(wrapper,parameter){
	var me=this;
	me.scrollY;//scroll当前移动到的位置
	//MyScroll相关
	me.bottom=parameter.bottom;//拖动加载底部元素 ，jquery对象
	me._bottomHtml="";//bottom原始頁面
	me.bottomEndHtml=parameter.bottomEndHtml==null?"已到达底部":parameter.bottomEndHtml;//拖动到底部显示内容 ，html文本， 字符串类型
	me.isImgCache=parameter.isImgCache==null?false:true;//是否启用延迟加载图片，默认不启用  ，布尔型
	me.isPage=parameter.isPage==null?true:parameter.isPage;//是否分页
	me._isLoading=false;//当前是否正在加载
	me.loadType=parameter.loadType;//加载数据类型:0 不加载 1底部加载 2顶部刷新 3底部加载且顶部刷新 ，整型
	me._loadType=-1;//触发加载的类型：-1 无触发 0底部触发 1顶部触发
	me.getParameter=parameter.getParameter;//加载数据获取对应请求参数方法 ，function类型
	me.goPage=parameter.goPage==null?1:parameter.goPage;//加载页码 默认1开始 ， 整型
	me._maxPage=0;//最大页数
	me.loadUrl=parameter.loadUrl;//请求数据路径 ，字符串类型
	me.loadSuccess=parameter.loadSuccess;//数据请求成功后回调 ，function类型
	me.clear=parameter.clear==null?function(){}:parameter.clear;//清除scroll内显示元素 ，function类型
	me.noDataView=parameter.noDataView;//如果没有数据显示内容对象 ，jquery对象
	//me.isShowLoading=parameter.isShowLoading==null?false:true;//是否显示loading ，默认不显示 布尔型
	me.event=[];
	me.y;//当前位置
	me.maxY;//最大位置
	me.on=function(name,callBack){
		var e={};
		if(me._isEvent(name)){
			e.name=name;
			e.callBack=callBack;
			me.event.push(e);
		};
	};
	me.off=function(name){
		for(var i=0;i<me.event.length;i++){
			if(me.event[i].name==name){
				me.event.splice(i,1);
			}
		}
	}
	me._isEvent=function(name){
		switch(name){
			case "upScroll":
				return true;
			case "downScroll":
				return true;
			case "scroll":
				return true;
			case "scrollBottom":
				return true;
			case "scrollTop":
				return true;
			default:
				return false;
		}
	};
	me._getUrl=function(){
		if(me.isPage)
			return me.loadUrl+"/"+me.goPage;
		else
			return me.loadUrl;
	};
	//加载数据
	me.load=function(loadType){
		if(!me.isPage&&loadType==0){
			return;
		}
		if(me._isLoading)
			return;
		me._isLoading=true;//正在加载
		var url=me._getUrl();
		console.log("请求地址:"+url)
		var data=me.getParameter();
		$.ajax({
		    type: "post",
		    url: url,
		    data: data,
		    success: function(data){
		    	var dataObj=$.parseJSON(data);
		    	var page=dataObj.page;
		    	console.log("返回数据:")
		    	console.log(dataObj)
		    	//无内容检测
	    		if(page==null&&dataObj.data==null){
	    			console.log("无内容")
		    		me.noDataView.css("display","block");//显示没有内容提示
	    			if(me.bottom!=null)//清空底部loading
	    				me.bottom.html("");
	    			return;
	    		}else if(page!=null&&dataObj.data==null){
	    			if((page.list==null||page.list.length<=0)&&(page.last==null||page.last<=1)){
		    			console.log("无内容")
			    		me.noDataView.css("display","block");//显示没有内容提示
		    			if(me.bottom!=null)//清空底部loading
		    				me.bottom.html("");
		    			return;
			    	}
	    		}
		    	
		    	//数据重置，限刷新
		    	if(loadType==1)
		    		me.clear();
		    	
		    	//数据展示
		    	if(dataObj.page==null&&dataObj.data!=null)
		    		me.loadSuccess(dataObj.data);
		    	else if(dataObj.page!=null&&dataObj.data==null){
		    		if(dataObj.page.list!=null&&dataObj.page.list.length>0)
			    		me.loadSuccess(dataObj.page.list);
		    	}
		    	
		    	//效果处理
		    	//刷新--
	    		if(loadType==1){
	    			//变更头部高度
		    		var wrapper=$(scrollId);
		    		var top=wrapper.offset().top;
		    		var newTop=top-me.headerHeight;
		    		wrapper.css("top",newTop+"px");
	    		}
	    		
	    		//底部加载,底部加载必须为分页模式--
		    	if(loadType==0){
		    		me._maxPage=page.last;//保存最大页数
		    		//检测是否已到达最后一页
		    		if(me.goPage >= page.last&&me.bottom!=null){
		    			console.log("已经到达最后一页")
		    			me.isPage=false;
		    			me._bottomHtml=me.bottom.html();
	    				me.bottom.html(me.bottomEndHtml);
		    		}
		    		me.goPage++;//下次请求下一页
	    			console.log("下一页："+me.goPage+"  最大页数："+me._maxPage)
	    			console.log("----------------------------------------")
		    	}
		    	
		    	//图片延迟加载
		    	if(me.isImgCache){
		    		console.log($("img[data-type=lazyImg]"))
		    		$("img[data-type=lazyImg]").lazyload({effect : "fadeIn"});
		    	}
		    	me._isLoading=false;//加载结束
		    },
		    error:function(){
		    	
		    }
		})
	};
	wrapper.scroll(function(){
		//console.log("---滑动中----");
		me._callEvent("scroll",this);
		var nowY=$(window).scrollTop();
		me.maxY=$(document).height();
		if(nowY>me.y){
			me._callEvent("downScroll",me);
		}
		if(nowY<me.y){
			me._callEvent("upScroll",me);
		}
		me.y=nowY;
		if((me.y+this.innerHeight)>=me.maxY){
			me._callEvent("scrollBottom",me);
			if(me.loadType==1||me.loadType==3){
				me.load(0);
			}
		}
		if(me.y<=0){
			me._callEvent("scrollTop",me);
			if(me.loadType==2||me.loadType==3){
				me.load(1);
			}
		}
		
	});
	me._callEvent=function(name,obj){
		for(var i=0;i<me.event.length;i++){
			if(me.event[i].name==name){
				me.event[i].callBack(obj);
			}
		}
	}
}
