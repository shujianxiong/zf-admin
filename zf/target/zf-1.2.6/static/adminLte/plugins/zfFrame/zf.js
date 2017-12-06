/** --------------------
 * - zhoufan js框架-
 * 说明：ZF对象为全局对象，支持window直接调用。
 *     jq开头的方法名为jquery方法扩展，只支持jquery对象调用
 *     
 * api:setCookie    , 说明：保存键值对到cookie            , 参数：key 键|val 值
 *     getCookie    , 说明：获取cookie值                , 参数：key 键
 *     removeCookie , 说明：删除cookie                 , 参数：key 键
 *     resetForm    , 说明：重置查询表单参数               , 参数：form表单,jquery对象
 *     formSubmit   , 说明：表单填写验证                  , 参数：form表单,jquery对象
 *     formVerify   , 说明：格式填写验证                  , 参数：type验证类型,非空优先|val 验证值
 *     xconfirm     , 说明：表单提交                     , 参数：obj事件触发对象
 *     ajaxQuery    , 说明：ajax请求                   , 参数：showLoading 是否显示loading|url 请求地址|postData 请求参数|callBack 成功回调|errCallBack 失败回调
 *     delRow       , 说明：是否选择请求提示               , 参数：message 提示内容|href 请求地址, 主要适用于表格内删除行记录   
 *     showTip      , 说明：显示提示                     , 参数：message 提示内容|type 提示样式：success,info,danger,warning
 *     sub          , 说明：字符串截取扩展(扩展String)      , 参数：index 截取开始位置|length 截取长度
 *     createScroll , 说明：创建滚动区                   , 参数：className 创建滚动区的样式名称|height 滚动区限定高度
 *     curentTime   , 说明：获取当前时间
 *     getMyMessage , 说明：获取个人未读消息且自动重置首页消息栏
 *     parseTable   , 说明：表格解析，基于dataTables.js库
 *     multilineTable, 说明：多行表格解析,适用于addRow或delRow后重新渲染表格
 *     bigImg, 说明：解析当前页所有标记下的IMG，大图展示，参数：tag 标记名,允许为空
 *     checkboxTable,
 * --------------------
 */
(function($,window){
	console.log("zf.js-----加载")
	"周范自定义对象 ZF，对window，jQuery扩展";
	const localStorage = window.LocalStorage;
//	ZF.localStorage = localStorage;
	
	var ZF={};
	//tip配置
	toastr.options = {
	  "closeButton": false,
	  "debug": false,
	  "newestOnTop": false,
	  "progressBar": false,
	  "positionClass": "toast-top-center",
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "300",
	  "hideDuration": "1000",
	  "timeOut": "3500",
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	}
	
	/** cookie读写操作 **/
	function setCookie(key,val){
		var Days = 30; 
	    var exp = new Date(); 
	    exp.setTime(exp.getTime() + Days*24*60*60*1000); 
	    document.cookie = key + "="+ escape (val) + ";expires=" + exp.toGMTString();
	}
	ZF.setCookie=setCookie;
	
	function getCookie(key){
		var arr,reg=new RegExp("(^| )"+key+"=([^;]*)(;|$)"); 
	    if(arr=document.cookie.match(reg))
	        return unescape(arr[2]); 
	    else 
	        return null; 
	}
	ZF.getCookie=getCookie;
	
	function removeCookie(key){
		var exp = new Date(); 
	    exp.setTime(exp.getTime() - 1); 
	    var cval=getCookie(key); 
	    if(cval!=null) 
	        document.cookie= key + "="+cval+";expires="+exp.toGMTString(); 
	}
	ZF.removeCookie=removeCookie;
	
	/** -cookie读写操作 end- **/

	
	/** -query form扩展- **/
	function resetForm(form){
		if(event==null){
			console.log("method resetForm event is null 未捕获到事件参数");
			return;
		}
		form=form==null?$(event.target).parents("form"):$(form);
		if(form==null||form.length<=0){
			console.log("method resetForm parame form is null 请传入表单对象");
			return;
		}
		$("input[type=text]",form).val("");
		$("input[type=hidden]",form).val("");
//		$("input",form).val("");
		$('input',form).each(function(){
			if($(this).attr("data-verify")=="true"){
				$(this).trigger('change');
			}
		});
		$("textarea").val('');
//		$('input').iCheck('uncheck');
		$("select",form).val("");
		$("select",form).each(function(){
			$(this).select2("val","");
		});
	}
	
	ZF.resetForm=resetForm;
	
	//表单验证
	function formSubmit(form){
		var verify=true;
		var inputs=$("input[data-verify=false]",form);
		for(var i=0;i<inputs.length;i++){
			if($(inputs[i]).attr('data-type') == "date"){
				$(inputs[i]).parent().trigger('dp.change');
			}else{
				$(inputs[i]).trigger('change');
			}
			verify=false;
		}
		var selects=$("select[data-verify=false]",form);
		for(var i=0;i<selects.length;i++){
			$(selects[i]).trigger('change');
			verify=false;
		}
		var textareas=$("textarea[data-verify=false]",form);
		for(var i=0;i<textareas.length;i++){
			$(textareas[i]).trigger('change');
			verify=false;
		}
		if(verify){
			$("button[type=submit]").attr('disabled',true);
		}
		
		return verify;
	}
	ZF.formSubmit=formSubmit;
	
	//值验证，非空必验证
	/**
	 * isMandatory：是否必填
	 * type：验证类型
	 * 		0 文本验证(由原来的不验证，现在更改为过滤特殊字符)
	 * 		1 手机号验证
	 * 		2 身份证验证
	 * 		3 邮箱验证
	 * 		4 整数验证
	 * 		5 浮点数验证
	 * 		6 传真
	 * 		7 电话
	 *		8 IP地址
	 *		9 两位小数
	 *		10 四位小数
	 *      11 邮政编码
	 *      12 国际通用手机号码
	 *      99 不验证
	 */
	function formVerify(isMandatory, type, val){
		if(val==null||val.length<=0||val==""){
			if(isMandatory)
				return false;
			return true;
		}else {
			if(type==0) {
				if(!/^(([^\^\.<>%&',;=?$"':#@!~\]\[{}\\/`\|])*)$/.test(val)) 
					return false;
				return true;
			}else if(type==1){
				if(!/^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(val))
					return false;
				return true;
			}else if(type==2){
				if(!/^\d{15}|\d{}18$/.test(val))
					return false;
				return true;
			}else if(type==3){
				if(!/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/.test(val))
					return false;
				return true;
			}else if(type==4){
				if(!/^\d+$/.test(val))
					return false;
				return true;
			}else if(type==5){
				if(!/^(-?\d+)(\.\d+)?$/.test(val))
					return false;
				return true;
			}else if(type==6){
				if(!/^(\d{3,4}-)?\d{7,8}$/.test(val))
					return false;
				return true;
			}else if(type==7){
				if(!/^0\d{2,3}-?\d{7,8}$/.test(val))
					return false;
				return true;
			}else if(type==8){
				if(!/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/ .test(val))
					return false;
				return true;
			}else if(type==9){
				if(!/^-?\d+\.?\d{0,2}$/.test(val))
					return false;
				return true;
			}else if(type==10){
				if(!/^-?\d+\.?\d{0,4}$/.test(val))
					return false;
				return true;
			}else if(type==11) {
				if(!/^[1-9][0-9]{5}$/.test(val))
					return false;
				return true;
			} else if(type == 12) {
				if(!/^\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$/.test(val))
					return false;
				return true;
			}
			return true;
		}
	}
	ZF.formVerify=formVerify;
	
	//主动表单提交，带提示，需自行配置onsubmit 进行表单验证(如果需要)
	function xconfirm(obj){
		obj=$(obj);
		var message=obj.attr("data-message");
		var href=obj.attr("data-href");
		var data=obj.attr("data-json")
		var forms=$("form",document.body);
		if(forms.length<=0)
			return;
		var form=forms[0];//默认取第一个表单
		if(message==null||message.length<=0){
			if(typeof(data)=="string" )
				data=eval('('+data+')')
			for(var key in data){  
				$("[name='"+key+"']").each(function(){
					$(this).val(data[key]);
				})
		    }  
			form.action=href;
			form.submit();
		}else{
			confirm(message,"info",function(){
				if(typeof(data)=="string" )
					data=eval('('+data+')')
				for(var key in data){  
					$("[name='"+key+"']").each(function(){
						$(this).val(data[key]);
					})
			    }  
				form.action=href;
				form.submit();
			})
		}
	}
	ZF.xconfirm=xconfirm;
	
	//自动检测表单提交配置
	function formSub(){
		
	}
	
	/** -query form扩展 end- **/
	
	/** -img 扩展- **/
	function bigImg(tag){
		tag=tag==null?"data-big":tag;
		var bigImgTemp="<div data-name=\"bigImg\" style=\"position: fixed;top:${top};left:${left};z-index:999999\"><img src=\"${imgsrc}\" width=\"200\" height=\"200\" /></div>"
		$("img["+tag+"]").each(function(){
			$(this).unbind("mouseenter")
			$(this).on("mouseenter",function(){
				var img=$(this);
				var src=img.attr("data-src");
				var left=img.offset().left+img.width();
				var top =img.offset().top - $(document).scrollTop();
				var html=bigImgTemp.replace("${imgsrc}",src).replace("${top}",top+"px").replace("${left}",left+"px");
				var div=$(html);
				img.after(div);
			});
			$(this).unbind("mouseleave");
			$(this).on("mouseleave",function(){
				$("div[data-name=bigImg]").remove()
			})
		})
	}
	ZF.bigImg=bigImg;
	
	
	/** -img 扩展 end- **/
	
	/** -table扩展- **/
	function delRow(message,href){
		confirm(message,"warning",function(){
			window.location.href=href;
		});
		return false;
	}
	ZF.delRow=delRow;
	
	//dataTable 增强    暂未实现设置项默认值
	function parseTable(tableId,settings){
		var t = $(tableId).DataTable({
			"paging" : settings.paging,
			"lengthChange" : settings.lengthChange,
			"searching" : settings.searching,
			"order":settings.order,
			"ordering" : settings.ordering,
			"columnDefs":settings.columnDefs,
			"info" : settings.info,
			"autoWidth" : settings.autoWidth
		});
		//增加内置方法addRow
		t.$.addRow=function(data,html,callBack){
			var trArray=$(tableId+" tr");
			var _len = trArray.length;
			var endLen=_len-1;
			var trClass=$(trArray[_len-1]).attr("class")=="even"?"odd":"even";
			var tr=$("<tr data-index="+_len+" role=\"row\" class="+trClass+"></tr>");
			for(var i=0;i<data.length;i++){
				tr.append(data[i]);
			}
			$(tableId).append(tr);
			var tr = $(tableId).closest('tr');
			if(settings.multiline){
				if(html!=null)
					multilineTable(tableId,t,html)
				else
					multilineTable(tableId,t)
			}
			if(callBack!=null)
				callBack();
		};
		//开启多行表格功能
		if(settings.multiline){
			multilineTable(tableId,t)
		}
		//开启行选中
		if(settings.isRowSelect){
			//表格单选功能
			$(tableId+' tbody').on('click', 'tr', function() {
				if ($(this).hasClass('selected')) {
					$(this).removeClass('selected');
					settings.rowSelectCancel($(this));
				} else {
					t.$("tr.selected").removeClass('selected');
					$(this).addClass('selected');
					//productId = $(this).attr("data-value");
					settings.rowSelect($(this));
				}
			});
		}
		//addRow功能检测
		if(settings.addRow!=null){
			$(settings.addRow.eventId).on("click",function(){
				var data=settings.addRow.getData();
				var trArray=$(tableId+" tr");
				var _len = trArray.length;
				var endLen=_len-1;
				var trClass=$(trArray[_len-1]).attr("class")=="even"?"odd":"even";
				var tr=$("<tr data-index="+_len+" role=\"row\" class="+trClass+"></tr>");
				for(var i=0;i<data.length;i++){
					tr.append(data[i]);
				}
				$(tableId).append(tr);
				var tr = $(tableId).closest('tr');
				if(settings.multiline){
					if(settings.addRow.getChildHtml!=null)
						multilineTable(tableId,t,settings.addRow.getChildHtml())
					else
						multilineTable(tableId,t)
				}
				if(settings.addRow.callBack!=null)
					settings.addRow.callBack();
			})
		}   
		//delRow功能检测
		if(settings.delRow!=null){
			$(settings.delRow.eventId).on("click",function(){
				var delTr;
				if(settings.delRow.dataIndex==null||settings.delRow.dataIndex.length<=0){
					delTr=$(tableId+" tr.selected");
					delTr.remove();
				}else{
					$(tableId+" tr").each(function(){
						if($(this).attr("data-index")==settings.delRow.dataIndex){
							delTr=$(this)
							delTr.remove();
						}
					})
					
				}
				if(settings.delRow.callBack!=null)
					settings.delRow.callBack(delTr);
			});
		}
		return t;
	}
	
	function multilineTable(tableId,t,html){
		$(tableId+' tbody').unbind("click");
		//解析表格，构造数据源
		var hideArray=[];//隐藏的数据源
		var headerArray=[];
		$(tableId+" th").each(function(){
			headerArray.push($(this).text())
		})
		$(tableId+" tr").each(function(trIndex,tr){
			var trObj={"name":$(this).attr("data-index"),"val":[]};
            $(tr).find("td").each(function(tdIndex,td){
            	var tdObj={};
            	if($(td).attr("data-hide")){
            		$(td).css("display","none");
            		tdObj.name=headerArray[tdIndex];
            		tdObj.val=$(td).text().trim().sub(0,50);
            	}
            	if(typeof(tdObj.name)=="string"){
            		trObj.val.push(tdObj)
                }
            });
            if(trObj.val.length>0){
            	hideArray.push(trObj)
            }
        });
		
		$(tableId+' tbody').on('click', 'td.details-control',function() {
			var tr = $(this).closest('tr');
			var td=$(this);
			var tdNum=tr[0].cells.length;
			var dataIndex=tr.attr("data-index")
			var multiTable=$("#multiTr"+dataIndex);
			if(td.attr("data-open")=="0"){
				//关闭
				td.attr("data-open","1")
				td.html("<i class='fa fa-plus-square-o text-success'></i>")
				//隐藏折叠表格
				if(multiTable.length>0)
					multiTable.remove();
			}else{
				//展开
				td.attr("data-open","0")
				td.html("<i class='fa fa-minus-square-o text-success'></i>")
				//创建折叠表格
				var newTr=$("<tr id=\"multiTr"+dataIndex+"\"></tr>")
				var newTd=$("<td colspan='"+tdNum+"'></td>");
				if(html!=null)
					newTd.html(html);
				else
					newTd.html(_createChildTable(dataIndex,hideArray));
				newTr.append(newTd);
				tr.after(newTr);
			}
		});
	}
	
	function _createChildTable(dataIndex,hideArray){
		var html="<table date-type=\"subTable\" class=\"zf-sub-table table-bordered\">";
		for(var i=0;i<hideArray.length;i++){
			if(dataIndex!=hideArray[i].name)
				continue;
			for(var j=0;j<hideArray[i].val.length;j++){
				html+="<tr>"
				html+="<td class='text-right'>"+hideArray[i].val[j].name;
				html+="：</td>";
				html+="<td class='text-left'>"+hideArray[i].val[j].val;
				html+="</td>";
				html+="</tr>";
			}	
		}
		html+="</table>";
		return html;
	}
	
	ZF.parseTable=parseTable;
	
	/** -table扩展 end- **/
	
	/** -ajax扩展- **/
	function ajaxQuery(showLoading,url,postData,callBack,errCallBack){
		ZF.ajax(showLoading,"post",url,postData,callBack,errCallBack)
	}
	ZF.ajaxQuery=ajaxQuery;
	$.fn.ajaxQuery=ajaxQuery;
	
	function ajax(showLoading,postType,url,postData,callBack,errCallBack){
		if(showLoading){
			if($("#loading").length<=0)
				  $(".content-wrapper").append("<div id=\"loading\" class=\"overlay\" style=\"position: fixed;height: 100%;width: 100%;top: 0;text-align: center;line-height: 800px;background-color: rgba(0,0,0,0.5);z-index: 1000;\"><i class=\"fa fa-refresh fa-spin\" style=\"font-size:30px;\"></i></div>");
			$("#loading").show();
		};
		$.ajax({
			url:url,
			type:postType, 
			data:postData,
			dataType:"json",
			success:function(data){
				if(showLoading){     
					$("#loading").hide();
				}
				if(callBack!=null)
					callBack(data);
			},
			error:function(data){
				if(showLoading){     
					$("#loading").hide();
				}
				console.log(data)
				alert("请求错误："+data.status,"warning")
				if(errCallBack!=null)
					errCallBack(data);
				console.log("错误") 
			}
		});
	}
	ZF.ajax=ajax;
	$.fn.ajax=ajax;
	
	/** -ajax扩展 end- **/
	
	/** -String扩展- **/
	
	String.prototype.sub=function(index,length){
		var str=this, newArr=[];
		if(str.length<length)
			length=str.length;
		for(var i=index;i<length;i++){
			newArr.push(str.charAt(i));
		}
		if(str.length>length)
			newArr.push("...");
		return newArr.join("");
	}
	
	
	/** -String扩展 end- **/
	
	/** -tip扩展- **/
	
	function showTip(message,type){
		if(type=="danger")
			type="error"
		toastr[type](message);
	}
	ZF.showTip=showTip;
	
	/** -tip扩展 end- **/
	
	/** -日期扩展 end- **/
	//获取当前时间 YYYY-MM-DD HH:MM
	function curentTime(){ 
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分
        var clock = year + "-";
        if(month < 10)
            clock += "0";
        clock += month + "-";
        if(day < 10)
            clock += "0";
        clock += day + " ";
        if(hh < 10)
            clock += "0";
        clock += hh + ":";
        if (mm < 10) 
        	clock += '0'; 
    	clock += mm; 
        return clock; 
    }
	
	ZF.curentTime=curentTime;
	
	/** -data扩展 end- **/
	
	/** -scroll扩展- **/
	function createScroll(id,height){
		//创建滚动域
		return $("#"+id).slimScroll({
			height: height,
			alwaysVisible: true,
		});
	}
	ZF.createScroll=createScroll;
	
	/** -scroll扩展 end- **/
	
	/** -service扩展- **/
	function getMyMessage(){
		ZF.ajaxQuery(false,ctx+"/msg/um/myUmMessage/listData",null,function(data){
			if(data.count==0)
				return;
			$("#messageLabel").text(data.count)
			$("#messageListTitle").html("您当前有[ "+data.count+" ]条未读消息!")
			var html="";
			for(var i=0;i<data.list.length;i++){
				if(data.list[i].category==3)
					html+="<li><a href=\"#\"> <i class=\"fa fa-commenting-o text-aqua\"></i>"+data.list[i].title.sub(0,15)+"</a></li>";
				if(data.list[i].category==2)
					html+="<li><a href=\"#\"> <i class=\"fa fa-exclamation text-yellow\"></i>"+data.list[i].title.sub(0,15)+"</a></li>";
				if(data.list[i].category==1)
					html+="<li><a href=\"#\"> <i class=\"fa fa-flag-o text-red\"></i>"+data.list[i].title.sub(0,15)+"</a></li>";
			}
			$("#messageList").html(html);
		},function(){
			console.log("获取个人消息失败");
		})
	}
	ZF.getMyMessage=getMyMessage;
	/** -service扩展 end- **/
	
	/** -多选表格状态维持扩展- **/
	
	
	/** -多选表格状态维持扩展 end- **/
	
	window.ZF=ZF;
	
})(window.jQuery,window);


$(function(){
  //重写alert,
  //type参数:info,warning,success,danger
  //callBack参数：回调
  window.alert=function(message,type,callBack){
	  var tipType=type;
	  var title="提示";
	  if(typeof(type) == "undefined")
		  tipType="modal fade";
	  if(type=="info"){
		  title="信息提示";
		  tipType="modal fade modal-info";
	  }
	  if(type=="warning"){
		  title="警告提示";
		  tipType="modal fade modal-warning";
	  }
	  if(type=="success"){
		  title="成功提示";
		  tipType="modal fade modal-success";
	  }
	  if(type=="danger"){
		  title="危险提示";
		  tipType="modal fade modal-danger";
	  }
	  var modalHtml="<div id=\"alertModal\" class=\""+tipType+"\" data-backdrop=\"false\" data-keyboard=\"false\" tabindex=\"-1\" role=\"dialog\">" +
	  		"<div class=\"modal-dialog modal-sm\">" +
	  		"<div class=\"modal-content\">" +
	  		"<div class=\"modal-header\">" +
	  		"<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" +
	  		"<h8 class=\"modal-title\">"+title+"</h8>" +
	  		"</div>" +
	  		"<div class=\"modal-body\">" +
	  		"<p id=\"alertMessage\"></p></div>" +
	  		"<div class=\"modal-footer\">" +
	  		"<button id=\"alertCloseBtn\" type=\"button\" class=\"btn btn-default pull-center\" data-dismiss=\"modal\">确定</button>" +
	  		"</div>" +
	  		"</div>" +
	  		"</div>" +
	  		"</div>"; 
	  if($("#alertModal").length<=0)
		  $(".content-wrapper").append(modalHtml);
	  $('#alertModal').modal('show')
	  $("#alertMessage").html(message);
	  if(typeof(callBack) != "undefined")
		  $("#alertCloseBtn").on("click",callBack)
	  if(typeof(callBack) != "undefined"&&$("#alertCloseBtn").length>0){
  		 $("#alertCloseBtn").unbind("click")
  		 $("#alertCloseBtn").on("click",callBack)
  	  }
  };
  //重写confirm,
  //type参数:info,warning,success,danger, 
  //successCallBack参数：点击确定回调
  //cancelCallBack参数：点击取消回调
  window.confirm=function(message,type,successCallBack,cancelCallBack){
	  var tipType=type;
	  var title="提示";
	  if(typeof(type) == "undefined")
		  tipType="modal fade";
	  if(type=="info"){
		  title="信息提示";
		  tipType="modal fade modal-info";
	  }
	  if(type=="warning"){
		  title="警告提示";
		  tipType="modal fade modal-warning";
	  }
	  if(type=="success"){
		  title="成功提示";
		  tipType="modal fade modal-success";
	  }
	  if(type=="danger"){
		  title="危险提示";
		  tipType="modal fade modal-danger";
	  }
	  var modalHtml="<div id=\"confirmModal\" class=\""+tipType+"\" data-backdrop=\"false\" data-keyboard=\"false\" tabindex=\"-1\" role=\"dialog\">" +
		"<div class=\"modal-dialog modal-sm\">" +
		"<div class=\"modal-content\">" +
		"<div class=\"modal-header\">" +
		"<button id=\"closeBtn\" type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" +
		"<h8 class=\"modal-title\">"+title+"</h8>" +
		"</div>" +
		"<div class=\"modal-body\">" +
		"<p>"+message+"</p></div>" +
		"<div class=\"modal-footer\">" +
		"<button id=\"confirmNoBtn\" type=\"button\" class=\"btn btn-default pull-left\" data-dismiss=\"modal\">取消</button>" +
		"<button id=\"confirmYesBtn\" type=\"button\" class=\"btn btn-default pull-right\">确认</button>"+
		"</div>" +
		"</div>" +
		"</div>" +
		"</div>"; 
	  // 如果页面上已有提示框，则清除该已有的提示框
	  if($("#confirmModal").length>0){
		  $("#confirmModal").remove();
	  }
	  // 追加当前需要暂时的提示框并显示
	  $(".content-wrapper").append(modalHtml);
	  $("#confirmModal").modal('toggle');
	  if(typeof(successCallBack) != "undefined"&&$("#confirmYesBtn").length>0){
		  $("#confirmYesBtn").unbind("click")
		  $("#confirmYesBtn").click(function(){
			  $('#confirmModal').modal('hide');
			  successCallBack();
		  })
	  }
  	  if(typeof(cancelCallBack) != "undefined"&&$("#confirmNoBtn").length>0){
  		 $("#confirmNoBtn").unbind("click")
  		 $("#confirmNoBtn").click(function(){
  			cancelCallBack(); 
  		 })
  		 $("#closeBtn").unbind("click")
  		 $("#closeBtn").click(function(){
  			cancelCallBack(); 
  		 })
  	  }
   }
})

//多选表格，维持checkBox选中状态组件
//key 业务唯一标记
function CheckTable(key){
	//从cookie中获取已保存的勾选项
	var cache=window.localStorage.getItem(key);
	if(cache==null)
		cache=new Array();
	else{
		cache=JSON.parse(cache);
		cache.forEach(function(value){
			if($("input[value="+value.id+"]").length<=0){
				//设置已经勾选过的隐藏tr
				var tr=$(value.tr)
				tr.hide();
				$(":checkbox",tr).attr("checked", true);
				$("#tBodyId").append(tr);
			}else{
				//已存在于当前页则不append tr
				$("input[value="+value.id+"]").iCheck('check');
			}
			
		})
	}
	//勾选写入cookie
	$(":checkbox").on("ifChecked",function(){
		cache.push({
			id:$(this).val(),
			tr:$("#"+$(this).val())[0].outerHTML
		});
		console.log(cache);
		window.localStorage.setItem(key,JSON.stringify(cache));
	})
	//取消勾选从cookie移除
	$(":checkbox").on("ifUnchecked",function(){
		var val=$(this).val();
		cache.forEach(function(value,i){
			if(value.id == val){
				cache.splice(i, 1);
		      	return;
		    }
		})
		window.localStorage.setItem(key,JSON.stringify(cache));
	})
}

ZF.CheckTable=CheckTable;

