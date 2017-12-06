<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="iframe加载的地址"%>
<%@ attribute name="urlParameter" type="java.lang.String" required="false" description="请求参数,参数名形式"%>
<%@ attribute name="urlParameterJson" type="java.lang.String" required="false" description="请求参数,JSON形式支持健值对"%>
<%@ attribute name="isDisableCommitBtn" type="java.lang.String" required="true" description="是否隐藏提交按钮"%>
<%@ attribute name="width" type="java.lang.String" required="true" description="弹出框的宽度"%>
<%@ attribute name="height" type="java.lang.String" required="true" description="弹出框的高度"%>
<%@ attribute name="isRefresh" type="java.lang.String" required="false" description="弹出框的高度"%>
<c:if test="${empty isRefresh}">
	<c:set var="isRefresh" value="true"/>
</c:if>
<!-- 模态框（Modal）
申明：1.当需要URL传递参数时，需自行通过JS设定${id}ModalUrl的value值,否则只需要指定URL参数即可
 -->

<!-- 
使用模态窗口，您需要有某种触发器。您可以使用按钮或链接。这里我们使用的是按钮。
如果您仔细查看上面的代码，您会发现在 <button> 标签中，data-target="#myModal" 是您想要在页面上加载的模态框的目标。您可以在页面上创建多个模态框，然后为每个模态框创建不同的触发器。现在，很明显，您不能在同一时间加载多个模块，但您可以在页面上创建多个在不同时间进行加载。
在模态框中需要注意两点：
第一是 .modal，用来把 <div> 的内容识别为模态框。
第二是 .fade class。当模态框被切换时，它会引起内容淡入淡出。
aria-labelledby="myModalLabel"，该属性引用模态框的标题。
属性 aria-hidden="true" 用于保持模态窗口不可见，直到触发器被触发为止（比如点击在相关的按钮上）。
<div class="modal-header">，modal-header 是为模态窗口的头部定义样式的类。
class="close"，close 是一个 CSS class，用于为模态窗口的关闭按钮设置样式。
data-dismiss="modal"，是一个自定义的 HTML5 data 属性。在这里它被用于关闭模态窗口。
class="modal-body"，是 Bootstrap CSS 的一个 CSS class，用于为模态窗口的主体设置样式。
class="modal-footer"，是 Bootstrap CSS 的一个 CSS class，用于为模态窗口的底部设置样式。
data-toggle="modal"，HTML5 自定义的 data 属性 data-toggle 用于打开模态窗口。
data-backdrop="true" 指定一个静态的背景，当用户点击模态框外部时不会关闭模态框。
data-keyboard="false" 当按下 escape 键时关闭模态框，设置为 false 时则按键无效。
 -->
<div id="${id }Modal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="${title }" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">${title}</h4>
         </div>
         <div class="modal-body">
         	<input type="hidden" id="${id }ModalUrl" />
            <iframe id="${id }ModalIframe" src="" width="100%" height="100%" frameborder="0"></iframe>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <c:if test="${isDisableCommitBtn}">
            	<button type="button" class="btn btn-primary" id="commitBtn">提交更改</button>
            </c:if>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>
<script type="text/javascript">
	//开放的数据共有对象，当modal初始化显示以后填入对象
	//var iframeBodys=[];
	
	function ${id}init(){
		$('#${id}Modal .modal-dialog').css({"width":"${width}px","height":"${height}px"});
        $('#${id}Modal .modal-dialog').find('.modal-content').css({height: '100%',width: '100%'});
        $('#${id}Modal .modal-dialog').find('.modal-body').css({height:'80%'});
        //modal show时触发
		$("#${id}Modal").on("show.bs.modal",function () {
			if(!${isRefresh}&&$("#${id }ModalIframe").attr("src")!="")
				return;
			$("#${id }ModalIframe").attr("src","${url}");
			//判断请求参数
			var url=$("#${id}ModalUrl").val();
			if(url!=null&&url.length>0){
				$("#${id }ModalIframe").attr("src",$("#${id}ModalUrl").val());
			}
			
		})
		//modal 完全显示以后触发
		/*$("#${id}Modal").on("shown.bs.modal",function () {
			var content = $("#${id }ModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
			var modal={
					"key":"${id}",
					"body":content
			}
			iframeBodys.push(modal);
			console.log(iframeBodys)
		})*/
		$("#${id}Modal").on("hide.bs.modal",function(){
			if(${isRefresh})
				$("#${id}ModalIframe").attr("src","");
		});
		//modal 隐藏后触发  event:"hide.bs.modal"，未做封装，留作调用方扩展 
		//$("#${id}Modal").on("hide.bs.modal",function () {})
	}
	
	${id}init();
</script>
