
<!-- zfutils-tip 配套页面，需要提示时启用带确认操作-->
<div class="remind" id="remind" style="display:none;">
	<div id="shade" class="shade"></div>
		<div class="aloneTip" >
		<p id="tipTest"></p>
		<div class="" id="determine">
		</div>
		<!-- <img src="${ctxMobile}/img/yes.png"/> -->
	</div>
</div>
<!-- zfutils-tip配套页面，需要提示时启用 -->
<div id="tip" class="aloneTip " style="display:none;">
	<p class="tip"></p>
	<!-- <img src="${ctxMobile}/img/no.png"/>-->
</div>

<!-- zfutils - myScroll 配套页面，当列表没有数据时启用 -->
<div id="noContent" class="noContent"></div>

<!-- zfutils - Constants 配套页面，ajax未登录状态则启用 -->
<div id="loginPanel" class="quikLogin" style="display:none;">
	<div class="shade" ></div>
	<div  class="panel black">
		<div class="login_input">
			<input id="loginPanelName" type="text" placeholder="&#x8BF7;&#x8F93;&#x5165;&#x7528;&#x6237;&#x540D;" ></input>
			<input id="loginPanelPwd" type="password" placeholder="&#x8BF7;&#x8F93;&#x5165;&#x5BC6;&#x7801;" ></input>
			<div class="left">&#x767B;&#x5F55;</div><div class="right">&#x6CE8;&#x518C;</div>
		</div>
		<img src="${ctxMobile}/img/no.png"/>
	</div>
</div>
<script type="text/javascript">
fastLogin.init();
</script>

<!-- zfutils - ajax 配套页面，ajax请求调用 -->
<div id="loadingPanel" style="position:fixed;top:0px;width: 100%;height: 100%;display:none;z-index:99999;">
	<span style="display: block;width: 150px;height: 50px;position: absolute;top: 50%;left:45%;z-index: 100;background: url(${ctxMobile}/img/loading.gif) left no-repeat;background-size: 50px;text-indent: 60px;line-height: 50px;"></span>
</div>

<!-- 我猜按钮 zfutils - 悬浮按钮控制 -->
<div id="suspendPanel" class="suspendWarp" style="display:none">
	<div id="suspendView" class="functionArea"  style="display: none;">
		<div class="suspend_sub" data-type="suspend" onclick="window.location.href='${ctxWeb }/index'">
	 		<i class="iconfont">&#xe611;</i>
	 		<span>&#x9996;&#x9875;</span>
	 	</div>
	 	<div class="suspend_sub " data-type="suspend" onclick="">
	 		<i class="iconfont">&#xe62a;</i>
	 		<span>&#x5206;&#x4EAB;</span>
	 	</div>
	 	<div class="suspend_sub " data-type="suspend" onclick="window.location.href='${ctxWeb }/member/myRecord'">
	 		<i class="iconfont">&#xe62c;</i>
	 		<span>&#x6536;&#x85CF;</span>
	 	</div>
	 	<div class="suspend_sub" data-type="suspend" onclick="window.location.href='${ctxWeb }/member/myScanRecord/1'">
	 		<i class="iconfont">&#xe60e;</i>
	 		<span>&#x6D4F;&#x89C8;&#x8BB0;&#x5F55;</span>
	 	</div>
	 	<div class="suspend_sub" data-type="suspend">
	 		<i class="iconfont">&#xe633;</i>
	 		<span>&#x79DF;&#x8D41;&#x600E;&#x4E48;&#x73A9;</span>
	 	</div>
	</div>
	<div class="suspendingArea" id="suspendingArea" style="display: block;">
		<div class="Button guess" id="guessButton" style="display: block;">
			&#x6211;&#x731C;
		</div>
		<div class="Button backTop" id="backTopButton" style="display: block;">
			<i class="iconfont">&#xe637;</i>
		</div>
	</div>
</div>