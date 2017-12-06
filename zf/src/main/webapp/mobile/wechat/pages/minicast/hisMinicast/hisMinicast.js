$(function(){
	
		$(".headArea").height($(window).width()*0.85);
		$(".headPic").height($(".headPic").width());
		$(".minicastNew").height($(".minicastNew").width());
		
		$("#attentionIcon").on('click',function(){
			var t = $(this);
			var isAtt = $(this).attr("attention");
			var param = {"minicastMemberId":$(this).attr("m_id")};
			var url = ctxWeb+"/member/minicast/";
			url+=(isAtt=="true")?"cancelAttention":"attention";
			ajax.submit("POST", url, param, function(data){
				if(data.status == "1"){
					if(isAtt=="true"){
						tip.autoShow("取消关注");
						t.html("<i class='iconfont'>&#xe60e;</i>关注");
						t.attr("attention","false");
					}else{
						tip.autoShow("关注成功");
						t.html("<i class='iconfont'>&#xe60e;</i>已关注");
						t.attr("attention","true");
					}
				}
			}, function(data){
				console.log("error");
			});
		});
		
		var myScroll = new MyScroll("#myMinicastWarp",{
			bottom:$("#bottomLoading"),
			isImgCache:true,
			isPage:true,
			clear:clear,
			headerHeight:30,
			getParameter:getParameter,
			loadUrl:ctxWeb+"/minicast/hisMinicastList",
			loadSuccess:nextPage,
			loadType:3,
			noDataView:$("#noContent")
		});
	})

	function clear(){
		$("#content").html("");
	}

	function getParameter(){
		return {"hisMemberId":$("#hisMemberId").val()};
	}

	function nextPage(list){
		var content = $("#content");
		for(var i=0; i<list.length;i++){
			var html = builderHtml(list[i]);
			content.append(html);
		}
		
		$("img[data-height=false]").each(function(){
			$(this).height($(this).width())
			$(this).attr("data-height","true")
		})
		bindEventClick();
	}

	function bindEventClick(){
		//喜欢点击事件
		$(".like").each(function(){
			$(this).on('click', function(){
				var t = $(this);
				var isLike = $(this).attr("like");
				var param = {"minicastId":$(this).attr("m_id")};
				var url = ctxWeb+"/member/minicast/";
				url+=(isLike=="true")?"cancelLike":"like";
				ajax.submit("POST", url, param, function(data){
					if(data.status == "1"){
						if(isLike=="true"){
							tip.autoShow("取消喜欢");
							t.html("<i class='iconfont'>&#xe60e;</i>喜欢</span>");
							t.attr("like","false");
						}else{
							tip.autoShow("已喜欢");
							t.html("<i class='iconfont'>&#xe60e;</i>已喜欢</span>");
							t.attr("like","true");
						}
					}
				}, function(data){
					console.log("error");
				});
			});
		});
		
		//评论点击事件
		$("span[bind_click='click_comment']","#content").each(function(){
			$(this).on('click',function(){
				window.location.href=ctxWeb+"/member/minicastComment/"+$(this).attr("m_id");
			});
		});
		
		//点击小咖秀内容
		$(".click_minicast").each(function(){
			$(this).on('click',function(){
				window.location.href=ctxWeb+"/minicast/"+$(this).attr("m_id");
			});
		});
	}

	function builderHtml(obj){
		var html = "";
		html+="<li>";
			html+="<div id='' class='minicast_content'>";
			html+="<div id='' class='show_content_top'>";
			html+="<div class='show_content_top_pic'>";
			html+="<span id=''>";
			html+="<img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+$(".headPic").attr("headPic_val")+"'>";
			html+="</span></div>";
			html+="<span class='show_content_top_name'>";
			html+="<p>"+$(".name").attr("n_val")+"</p>";
			html+="<span id=''>";
			html+="<i class='iconfont'>&#xe60e;</i>"+obj.showTime;
			html+="</span>";
			html+="</span>";
			html+="</div>";

			//内容 star
			html+="<div class='click_minicast' m_id='"+obj.id+"'>";
			
			html+="<p>"+obj.content+"</p>";
			html+="<div id=''class='minicast_content_tab'>";
			html+="<span>"+obj.tag+"</span>";
			html+="</div>";
			html+="<div id='' class='minicast_content_pic'>";
			var photoUrls = obj.photoUrls;
			if(photoUrls != null && photoUrls !=''){
				photos = photoUrls.split(",");
				for(var j =0; j <photos.length;j++){
					if(photos[j] !=null && photos[j] != ''){
						html+="<span id=''><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+ctx+"/"+photos[j]+"'/></span>";
						
					}
				}
			}
			html+="</div>";
			html+="</div>";
			//内容end
			html+="<div class='minicast_content_new' onclick=window.location.href='"+ctxWeb+"/goodsInfo/simple/"+obj.goods1.id+"'>";
			html+= (obj.goods1.tagss !=null && obj.goods1.tagss.length>0)?"<span>"+obj.goods1.tagss[0].name+"</span>":"";
			html+="<img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' class='minicastNew' data-src='"+obj.goods1.icon+"'/>";
			html+="<div id=''>";
			html+="<h2>"+obj.goods1.name+"</h2>";
			html+="<h2>RMB "+obj.goods1.price+"</h2>";
			html+="<p>已有25人跟随购买</p>";
			html+="</div>";
			html+="</div>";
			html+="<div class='minicast_content_like'>";
			if(obj.like){//已喜欢
				html+="<span class='like' like='true' m_id='"+obj.id+"'>";
				html+="<i class='iconfont'>&#xe60e;</i>已喜欢</span>";
			}else{
				html+="<span class='like' like='false' m_id='"+obj.id+"'>";
				html+="<i class='iconfont'>&#xe60e;</i>喜欢</span>";
			}
			html+="<span bind_click='click_comment' m_id='"+obj.id+"'><i class='iconfont' class m_id='"+obj.id+"'>&#xe60e;</i>评论</span>";
			html+="<span>";
			html+="<i class='iconfont'>&#xe60e;</i>分享";
			html+="</span>";
			html+="</div>";
			html+="</div>";
			html+="</li>";
		return html;
	}