<!-- 响应式首页 适配移动端-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
    <%@ include file="/WEB-INF/views/include/amazeui.jsp"%>
    <script type="text/javascript">
    var menuList=${fns:getMenuListToJson()}
    var fristMenuInit=false;//第一屏菜单未初始化
    
    //初始化
    function init(){
    	loadGoldPrice();//第一次进入页面加载
		//定时器
		setInterval("loadGoldPrice()",1200000);//定时器20分钟局部刷新数据
		showIndexMenu();
		setInterval(function(){ $("#goldPrice").fadeOut(1000).fadeIn(500); },4500);
    }
    
    //判断是否为PC
    function IsPC() {
	    var userAgentInfo = navigator.userAgent;
	    var Agents = ["Android", "iPhone",
	                "SymbianOS", "Windows Phone",
	                "iPad", "iPod"];
	    var flag = true;
	    for (var v = 0; v < Agents.length; v++) {
	        if (userAgentInfo.indexOf(Agents[v]) > 0) {
	            flag = false;
	            break;
	        }
	    }
	    return flag;
	}
    
    //显示顶级菜单
    function showIndexMenu(){
    	var menuUl=$("#menuUl");
    	for(var i=0;i<menuList.length;i++){
    		var html="";
    		if(menuList[i].parentId=='1'&&menuList[i].isShow=='1'){
    			var target="{target:'#"+menuList[i].id+"ul'}";
    			html+="<li class='admin-parent'>";
    			html+="<a class='am-cf am-collapsed' data-am-collapse="+target+"> "+menuList[i].name+" <span class='am-icon-angle-right am-fr am-margin-right'></span></a>";
   				html+="<ul class='am-list admin-sidebar-sub am-collapse' id='"+menuList[i].id+"ul'>";
   				html+=showMenu(menuList[i].id);
   				html+="</ul>";
    			html+="</li>";
    			menuUl.append(html);
    		}
    	}
    	menuUl.append("<li><a href='#'><span class='am-icon-sign-out'></span> 注销</a></li>");
    }
    
    //加载二级以下菜单
    function showMenu(pId){
    	var html="";
    	for(var i=0;i<menuList.length;i++){
    		if(menuList[i].parentId==pId&&menuList[i].isShow=='1'){
    			var target="{target:'#"+menuList[i].id+"ul'}";
    			if(isParent(menuList[i].id)){
    				html+="<li class='admin-parent'>";
    				html+="<a class='am-cf am-collapsed' data-am-collapse="+target+">"+menuList[i].name+" <span class='am-icon-angle-right am-fr am-margin-right'></span></a>";
    				html+="<ul class='am-list admin-sidebar-sub am-collapse' id='"+menuList[i].id+"ul'>";
    				html+=showMenu(menuList[i].id);
    				html+="</ul>";
    			}else{
    				var str=JSON.stringify(menuList[i]);
    				html+="<li><a href='#this' onclick='addTab("+str+")'>"+menuList[i].name+"<span class='am-icon-hand-o-right am-fr am-margin-right'></span></a>";
    				if(!fristMenuInit){
    					addTab(menuList[i]);
    					fristMenuInit=true;
    				}
    			}
    			html+="</li>";
    		}
    	}
    	return html;
    }
    
    //判断是否为顶级
    function isParent(pId){
    	for(var i=0;i<menuList.length;i++){
    		if(menuList[i].parentId==pId&&menuList[i].isShow=='1'){
    			return true;
    		}
    	}
    	return false;
    }
    
    //查询黄金价格
    function loadGoldPrice(){
    	ajax('${ctx}/bas/gold/basGoldPriceGather/doList','post',{},function(data){
			var obj = eval("("+data+")"); //转换为json对象 
			$("#goldPrice").text(obj[0].price);
		})
	}
    
  	
    function ajax(url,postType,postData,callBack){
		$.ajax({
			url:url,
			data:postData,//memberId 当前用户ID
			type:postType,
			dataType:'json',
			success:callBack
		});
	} 
    
    function navIframe(url){
    	$("#mainFrame").attr("src",url);
    }
    
    //添加标签选项卡
    function addTab(menu){
    	if(isShow(menu))
    		return;
    	
    	$("[name='hearTabs']").each(function(){
    		$(this).removeClass("am-active");
    	})
    	
    	$("[name='contentTabs']").each(function(){
    		$(this).removeClass("am-active");
    	})
    	var li=$("<li name='hearTabs' class='am-active' title='点击鼠标右键关闭标签'><a href='#"+menu.id+"tab'>"+menu.name+"</a></li>");
    	$("#headTab").append(li)
    	$("#contentTab").append("<div id='"+menu.id+"tab' name='contentTabs' data-tab-panel-"+menu.id+" class='am-tab-panel am-active'><iframe src='${ctx}"+menu.href+"' style='overflow:visible;' scrolling='yes' frameborder='no' width='95%' height='95%'></iframe></div>")
    }
    
    function activeTab(menuId,obj){
    	$("[name='contentTabs']").each(function(){
    		$(this).removeClass("am-active");
    	})
    	var tabId="#"+menuId+"tab";
    	$(tabId).addClass("am-active")
    	$(obj).click();
    }
    
    function isShow(menu){
    	var show=false;
    	$("[name='hearTabs']").each(function(){
    		if($(this).text()==menu.name)
    			show=true;
    	})
    	return show;
    }
    
    </script>
    
</head>
<body>
	<header class="am-topbar admin-header">
	  <div class="am-topbar-brand">
	    <strong>${fns:getConfig('productName')}</strong> <small>管理后台</small>
	  </div>
	
	  <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>
	
	  <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
	
	    <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
	      <li><a href="javascript:;"> 黄金价格 <span id="goldPrice" class="am-badge am-badge-warning">...</span></a></li>
	      <li class="am-dropdown" data-am-dropdown>
	        <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
	          <span class="am-icon-bars"></span> 主题 <span class="am-icon-caret-down"></span>
	        </a>
	        <ul class="am-dropdown-content">
		        <c:forEach items="${fns:getDictList('theme')}" var="dict">
		        	<li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href")"> ${dict.label}</a></li>
		        </c:forEach>
	        </ul>
	      </li>
	      <li class="am-dropdown" data-am-dropdown>
	        <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
	          <span class="am-icon-users"></span> ${fns:getUser().name} <span class="am-icon-caret-down"></span>
	        </a>
	        <ul class="am-dropdown-content">
	          <li><a href="#this" onclick="navIframe('${ctx}/sys/user/info')"><span class="am-icon-user"></span> 资料</a></li>
	          <li><a href="#this" onclick="navIframe('${ctx}/sys/user/modifyPwd')"><span class="am-icon-cog"></span> 设置</a></li>
	          <li><a href="#this" onclick="navIframe('${ctx}/oa/oaNotify/self')"><span class="am-icon-comment"></span> 我的通知</a></li>
	          <li><a href="${ctx}/logout" ><span class="am-icon-sign-out"></span> 退出</a></li>
	        </ul>
	      </li>
	      <li class="am-hide-sm-only"><a href="javascript:;" id="admin-fullscreen"><span class="am-icon-arrows-alt"></span> <span class="admin-fullText">开启全屏</span></a></li>
	    </ul>
	  </div>
	</header>
	
	
	<div class="am-cf admin-main">
	  <!-- sidebar start -->
	  <div class="admin-sidebar am-offcanvas" id="menuListBar">
	    <div class="am-offcanvas-bar admin-offcanvas-bar">
	      <ul id="menuUl" class="am-list admin-sidebar-list">
	      	
	        
	      </ul>
	      <div class="am-panel am-panel-default admin-sidebar-panel">
	        <div class="am-panel-bd">
	          <p><span class="am-icon-bookmark"></span> 公告</p>
	          <p>时光静好，与君语；细水流年，与君同。—— 周范</p>
	        </div>
	      </div>
	
	      <div class="am-panel am-panel-default admin-sidebar-panel">
	        <div class="am-panel-bd">
	          <p><span class="am-icon-tag"></span> wiki</p>
	          <p>待添加</p>
	        </div>
	      </div>
	    </div>
	  </div>
	  <!-- sidebar end -->
	
	  <!-- content start -->
	  <div class="admin-content">
		
		<div data-am-widget="tabs" class="am-tabs am-tabs-d2">
	      <ul id="headTab" class="am-tabs-nav am-cf">
	      
	      </ul>
	      <div id="contentTab" class="am-tabs-bd">
	      
	      </div>
	  	</div>
		
	  </div>
	  <!-- content end -->
	  
	</div>
	
	
	<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu" data-am-offcanvas="{target: '#menuListBar'}"></a>
		
	<footer style="z-index:-1">
	  <hr>
	  <p class="am-padding-left">Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="http://jeesite.com" target="_blank">JeeSite</a> ${fns:getConfig('version')}</p>
	</footer>
</body>
<script type="text/javascript" >
init();
</script>
</html>