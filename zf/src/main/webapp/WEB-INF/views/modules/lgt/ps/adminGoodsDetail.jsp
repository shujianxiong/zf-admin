<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>
<!DOCTYPE html>
<html style="width:480px;margin: 0 auto;">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<meta charset="utf-8" /><!-- UTF-8编码 -->
	<meta name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<meta name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<meta name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<meta name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 -->
    <title>商品详情</title>
    <script type="text/javascript">
 
        
    </script>
<style type="text/css">
    	html,body {font-size: 63%;}
    	html,
body {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
  color: #fff;
  font-family: "sans-serif", "STXihei";
  background: #190d33;
}
div,
dl,
dt,
dd,
ul,
ol,
li,
h1,
h2,
h3,
h4,
h5,
h6,
pre,
form,
fieldset,
input,
textarea,
blockquote,
p {
  padding: 0;
  margin: 0;
}
table,
td,
tr,
th {
  font-size: 1.2rem;
}
img {
  vertical-align: top;
  border: 0;
}
ol,
ul {
  list-style: none;
}
b,
i {
  font-style: normal;
}
h1,
h2,
h3,
h4,
h5,
h6,
p,
span,
b {
  font-size: 1.2rem;
  font-weight: normal;
}
address,
cite,
code,
em,
th {
  font-weight: normal;
  font-style: normal;
}
.fB {
  font-weight: bold;
}
a {
  text-decoration: none;
  color: #000;
}
a:visited {
  text-decoration: none;
  color: #000;
}
a:hover {
  color: #000;
}
a:active {
  color: #000;
}
@font-face {
  font-family: 'iconfont';
  src: url('//at.alicdn.com/t/font_1448876247_9556031.eot');
  src: url('//at.alicdn.com/t/font_1448876247_9556031.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */ url('//at.alicdn.com/t/font_1448876247_9556031.woff') format('woff'), /* chrome、firefox */ url('//at.alicdn.com/t/font_1448876247_9556031.ttf') format('truetype'), /* chrome、firefox、opera、Safari, Android, iOS 4.2+*/ url('//at.alicdn.com/t/font_1448876247_9556031.svg#iconfont') format('svg');
  
  /* IE9*/
  /* iOS 4.1- */
}
.iconfont {
  font-family: "iconfont" !important;
  font-size: 1.6rem;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -webkit-text-stroke-width: 0.2px;
  -moz-osx-font-smoothing: grayscale;
}
/**-----------------------商品图片----------------------------*/
body {
  color: #000;
}
.goodsDetail_warp {
  overflow: auto;
  height: auto;
  width: 100%;
}
.goodsDetail_topPic {
  position: relative;
  width: 100%;
  height: auto;
}
.goodsDetail_topPic img {
  width: 100%;
  height: auto;
}
.goodsDetail_parameter,
.goodsDetail_tagWarp,
.goodsDetail_designer,
.goodsDetail_property,
.goodsDetail_imageDetail {
  margin: 10px;
  padding: 10px;
  border-radius: 10px;
  -webkit-border-radius: 10px;
  background: #fff;
  overflow: hidden;
}
.goodsDetail_parameter_icon {
  height: 35px;
  line-height: 35px;
  margin-top: -5px;
}
.goodsDetail_parameter_icon i {
  font-size: 2.4rem;
  float: right;
  padding: 0 10px;
}
.goodsDetail_parameter_title {
  margin-bottom: 10px;
}
.goodsDetail_parameter_title h2 {
  font-size: 1.6rem;
  line-height: 26px;
  font-weight: 600;
}
.goodsDetail_parameter_title h2 b {
  margin-left: 10px;
  color: #D62621;
}
.goodsDetail_parameter_title p {
  font-size: 1.4rem;
  line-height: 24px;
}
.goodsDetail_parameter_title p b {
  font-size: 1.4rem;
  margin-left: 10px;
  color: #D62621;
}
.goodsDetail_parameter_title p span {
  font-size: 1rem;
  padding-left: 10px ;
  text-decoration: line-through;
  color: #636363;
}
.goodsDetail_text_line {
  position: relative;
  width: 100%;
  height: 20px;
  color: #f4c158;
  font-size: 1rem;
  text-align: center;
}
.goodsDetail_text_line span {
  position: absolute;
  left: -10px;
  top: 9px;
  width: 120%;
  height: 1px;
  background: #f4c158;
}
.goodsDetail_text_line p {
  position: relative;
  padding: 0 5px;
  display: inline-block;
  background: url(images/whiteBlock.jpg) center;
  background-size: 100% 100%;
  z-index: 9;
}
.parameter_activity_content {
  line-height: 30px;
  font-size: 1.4rem;
}
.goodsDetail_tagWarp {
  font-size: 1.2rem;
}
.goodsDetail_tagWarp div {
  margin: 10px 0 5px 0;
}
.goodsDetail_tagWarp div label {
  display: inline-block;
  position: relative;
  line-height: 25px;
  height: 25px;
  padding: 0 15px;
  border-radius: 15px;
  background-color: #f4c158;
  color: #fff;
  border: none;
  margin: 0 10px 10px 0;
}
.goodsDetail_tagWarp div label i {
  padding-right: 10px;
}
.goodsDetail_tagWarp .parameter_activity_line {
  margin-top: 0;
}
.goodsDetail_tagWarp .goodsDetail_tag_pic {
  height: auto;
  width: 100%;
  overflow: auto;
}
.goodsDetail_tagWarp .goodsDetail_tag_pic div {
  float: left;
  margin: 0;
  width: 14.285%;
  padding-right: 5px;
  box-sizing: border-box;
}
.goodsDetail_tagWarp .goodsDetail_tag_pic div span {
  display: block;
  border-radius: 100%;
  -webkit-border-radius: 100%;
  background: #2dd6b7;
}
.goodsDetail_tagWarp .goodsDetail_tag_pic div span img {
  width: 90%;
  margin: 5%;
  border-radius: 100%;
  -webkit-border-radius: 100%;
}
.designer_pic {
  float: left;
  display: block;
  height: 60px;
  width: 60px;
}
.designer_pic img {
  width: 100%;
  height: 100%;
}
.designer_name {
  float: left;
  height: 40px;
  margin: 10px;
  line-height: 20px;
}
.designer_name p {
  font-size: 1.4rem;
}
.designer_name p b {
  font-size: 1.4rem;
  font-weight: 600 ;
}
.designer_attention {
  float: right;
  height: 26px;
  width: 20%;
  margin: 20px 0;
  background-color: #f4c158;
  text-align: center;
  line-height: 26px;
  color: #fff;
  font-size: 1.4rem;
  border-radius: 5px;
  -webkit-border-radius: 5px;
}
.designer_attention i {
  font-size: 1.2rem;
}
.goodsDetail_property_style {
  width: 100%;
  height: auto;
  overflow: auto;
  margin: 5px 0;
  padding: 5px 0;
  border-top: 1px solid #ddd;
}
.goodsDetail_property_style li {
  width: 33.333%;
  float: left;
}
.goodsDetail_property_style li span {
  position: relative;
  display: block;
  margin: 5px;
  box-sizing: border-box;
}
.goodsDetail_property_style li span img {
  width: 100%;
}
.goodsDetail_property_style li span i {
  display: none;
}
.goodsDetail_property_style li span.active {
  border: 1px solid #f4c158;
}
.goodsDetail_property_style li span.active i {
  position: absolute;
  bottom: 0;
  right: 0;
  display: block;
  color: #f4c158;
  font-size: 1.2rem;
}
.goodsDetail_property_karat {
  width: 100%;
  height: auto;
  overflow: auto;
  margin: 5px 0;
  padding: 5px 0;
  border-top: 1px solid #ddd;
}
.goodsDetail_property_karat li {
  width: 33.333%;
  float: left;
}
.goodsDetail_property_karat li span {
  display: block;
  width: 80%;
  margin: 10px auto;
  background-color: #f4c158;
  text-align: center;
  line-height: 26px;
  color: #fff;
  font-size: 1.4rem;
  border-radius: 5px;
  -webkit-border-radius: 5px;
}
.goodsDetail_imageDetail_top {
  border-bottom: 1px solid #ddd;
  height: 40px;
}
.goodsDetail_imageDetail_top ul {
  width: 100%;
  height: 100%;
}
.goodsDetail_imageDetail_top ul li {
  width: 50%;
  height: 100%;
  float: left;
  text-align: center;
  line-height: 30px;
}
.goodsDetail_imageDetail_top ul li span {
  font-size: 1.4rem;
  line-height: 1.6rem;
  padding-bottom: 5px;
}
.goodsDetail_imageDetail_top ul li span.active {
  color: #f4c158;
  border-bottom: 1px solid #f4c158;
}
.goodsDetail_imageDetail_main {
  width: 100%;
  overflow: auto;
}
.goodsDetail_imageDetail_main span {
  display: block;
  width: 100%;
}
.goodsDetail_imageDetail_main span img {
  width: 100%;
}
.goodsDetail_guessLike {
  display: block;
  width: 100%;
  height: auto;
  padding-top: 10px;
  margin-bottom: 35px;
}
.goodsDetail_guessLike header {
  position: relative;
  height: 50px;
  width: 100%;
  color: #f4c158;
}
.goodsDetail_guessLike header h2 {
  width: 100%;
  line-height: 50px;
  text-align: center;
  font-size: 1.4rem;
}
.goodsDetail_guessLike header span {
  position: absolute;
  right: 10px;
  top: 0;
  display: inline-block;
  height: 100%;
  width: auto;
  line-height: 50px;
}
.goodsDetail_guessLike .goodsDetail_guessLike_goodsBlock {
  width: 100%;
  height: auto;
  box-sizing: border-box;
  padding: 5px 0 0 5px;
  font-size: 1.2rem;
  overflow: auto;
}
.goodsDetail_guessLike .goodsDetail_guessLike_goodsBlock ul {
  width: 100%;
  height: auto;
  margin-bottom: 20px;
  overflow: auto;
}
.goodsDetail_guessLike .goodsDetail_guessLike_goodsBlock ul li {
  width: 33.333%;
  float: left;
  padding: 5px 5px 0 0;
  box-sizing: border-box;
  color: #dddddd;
}
.goodsDetail_guessLike .goodsDetail_guessLike_goodsBlock ul li img {
  width: 100%;
}
.goodsDetail_guessLike .goodsDetail_guessLike_goodsBlock ul li div {
  line-height: 30px;
  padding: 0;
  background-color: #2c233e;
  display: -webkit-box;
  overflow: hidden;
  text-overflow: ellipsis;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
  -webkit-box-flex: 1;
  height: inherit;
}
.goodsDetail_guessLike .goodsDetail_guessLike_goodsBlock ul li p {
  line-height: 30px;
  font-weight: 600;
  padding-bottom: 5px;
  background-color: #2c233e;
}
.goodsDetail_guessLike .goodsDetail_guessLike_goodsBlock ul li p b {
  font-style: normal;
  color: #FF6A56;
}
.goodsDetail_funcBar {
  position: fixed;
  bottom: 0;
  width: 25%;
  height: 45px;
  background-color: #2c233e;
  z-index: 99;
}
.goodsDetail_funcBar .goodsDetail_funcBar_icon {
  width: 13.3333%;
  height: 100%;
  float: left;
  text-align: center;
  line-height: 45px;
}
.goodsDetail_funcBar .goodsDetail_funcBar_icon i {
  font-size: 2.4rem;
  color: #f4c158;
}
.goodsDetail_funcBar .goodsDetail_funcBar_detail {
  width: 30%;
  height: 100%;
  background-color: #f4c158;
  color: #ffffff;
  line-height: 45px;
  text-align: center;
  float: right;
  font-size: 1.6rem;
}
.goodsDetail_funcBar .goodsDetail_funcBar_detail.shopCart {
  background: #fff;
  color: #f4c158;
}

    	
</style>
</head>
<body style="width:480px;margin: 0 auto;">
<div class="goodsDetail_warp">
	<div class="goodsDetail_topPic">
		<img onerror="imgOnerror(this);"  src="${goods.displayPhoto}"/>
	</div>
	<div class="goodsDetail_parameter">
		<div id="" class="goodsDetail_parameter_icon">
			<i class="iconfont">&#xe609;</i>
			<i class="iconfont">&#xe609;</i>
			<i class="iconfont">&#xe609;</i>
		</div>
		<div class="goodsDetail_parameter_title">
			<h2>${goods.displayTitle}<b>库存24件</b></h2>
			<p>会员价：<b style="margin: 0;">￥${goods.produces[0].buyPrice }</b><span>￥${goods.produces[0].buyPrice }<</span></p>
			<p>租金：<b>￥${goods.produces[0].hirePrice }/月</b> </p>
			<p>押金：<b>￥${goods.produces[0].hireDeposit}</b> </p>
		</div>
		<div id="" class="goodsDetail_parameter_activity">
			<div class="goodsDetail_text_line">
				<span ></span>
				<p>商品活动将于72时52分36秒后结束</p>
			</div>
			<p class="parameter_activity_content">圣诞节大酬宾</p>
		</div>
	</div>
	<div id="" class="goodsDetail_tagWarp">
		<div class="goodsDetail_tag">
		    <label ><i class="iconfont">&#xe609;</i>免运费</label>
		    <label ><i class="iconfont">&#xe609;</i>15天包退换</label>
		    <label ><i class="iconfont">&#xe609;</i>了解租赁规则</label>
		    <label ><i class="iconfont">&#xe609;</i>货品保险规则</label>
		    <label ><i class="iconfont">&#xe609;</i>银行贷款</label>
		</div>
		<div class="goodsDetail_text_line">
				<span ></span>
				<p>看看他们的试穿效果</p>
		</div>
		<div id="" class="goodsDetail_tag_pic">
			<div><span id=""><img src="${ctxMobile}/img/home/images/fashion3.png"/></span></div>
			<div><span id=""><img src="${ctxMobile}/img/home/images/fashion3.png"/></span></div>
			<div><span id=""><img src="${ctxMobile}/img/home/images/fashion3.png"/></span></div>
			<div><span id=""><img src="${ctxMobile}/img/home/images/fashion3.png"/></span></div>
			<div><span id=""><img src="${ctxMobile}/img/home/images/fashion3.png"/></span></div>
			<div><span id=""><img src="${ctxMobile}/img/home/images/fashion3.png"/></span></div>
			<div><span id=""><img src="${ctxMobile}/img/goodsDetail/images/showEnd.png"/></span></div>
		</div>
	</div>
	<div id="" class="goodsDetail_designer">
		<span class="designer_pic"><img src="${ctxMobile}/img/goodsDetail/images/designer.png"/></span>
		<div class="designer_name">
			<p>设计师：<b>飞利浦杜和雷</b></p>
			<p>粉丝&#12288;100000+</p>
		</div>
		<span id="" class="designer_attention">
			关注&nbsp;<i class="iconfont">&#xe609;</i>
		</span>
	</div>
	<div id="" class="goodsDetail_property">
		
		
		
	</div>
	<div class="goodsDetail_imageDetail">
		<div class="goodsDetail_imageDetail_top">
			<ul>
				<li>
					<span id="" class="active">图文详情</span>
				</li>
				<li>
					<span id="">评价<b>（${goods.judgesCount }）</b></span>
				</li>
			</ul>
		</div>
		<div class="goodsDetail_imageDetail_main" id="desc1">
			${fns:unescapeHtml(goods.displayIntroduction)}
		</div>
	</div>
	<div id="" class="goodsDetail_funcBar">
		<div id="" class="goodsDetail_funcBar_icon">
			<i class="iconfont">&#xe607;</i>
		</div>
		<div id="" class="goodsDetail_funcBar_icon">
			<i class="iconfont">&#xe608;</i>
		</div>
		<div id="" class="goodsDetail_funcBar_icon">
			<i class="iconfont">&#xe609;</i>
		</div>
		<div id="" class="goodsDetail_funcBar_detail">
			立即租赁
		</div>
		<div id="" class="goodsDetail_funcBar_detail shopCart">
			加入购物车
		</div>
	</div>
</div>
</body>
    
</html>