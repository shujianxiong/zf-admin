
/**
 * 订单确认页JS
 */
$(function(){
//	new SuspendBtn("","orderConfirm"); 
	
	// 选择收货方式（设置选中效果、设置form表单参数值）
	$("i[data-type=receiveTypeI]").each(function(){
		$(this).on("click",function(){
			$("i[data-type=receiveTypeI]").each(function(){
				$(this).attr("data-check","0");
				$(this).html("&#xe627;");
			});
			$(this).attr("data-check","1");
			$(this).html("&#xe622;");
			$("#receiveType").val($(this).attr("data-value"));
		});
	});

	/**
	 * 为每个修改按钮绑定点击事件：
	 * 设置留言参数<跳转到会员编辑数据的controller时将数据保存到session以便编辑完回到订单确认页时显示收货方式及留言数据>
	 * 设置点击操作要访问的URL
	 * 提交表单
	 */
	// 收货地址
	$("#selectAddress").on("click",function(){
		submitOrderConfirmForm("selectAddress");
	});
	
	// 租赁方案
	$("div[data-type=selectHirePlan]").each(function(){
		$(this).on("click",function(){
			// 设置表单参数<要选择租赁方案的购物车ID>
			$("#shoppingcartId").val($(this).attr("data-value"));
			submitOrderConfirmForm("selectHirePlan");			
		});
	});
	// 保险方案
	$("div[data-type=selectHireInsurance]").each(function(){
		$(this).on("click",function(){
			// 设置表单参数<要选择保险方案的购物车ID>
			$("#shoppingcartId").val($(this).attr("data-value"));
			submitOrderConfirmForm("selectHireInsurance");			
		});
	});
	
	// 保险
	$("#selectHireInsurance").on("click",function(){
		submitOrderConfirmForm("selectHireInsurance");
	});
	
	// 提货地址
	$("#selectShop").on("click",function(){
		submitOrderConfirmForm("selectShop");
	});
	
	// 提货地址
	$("#selectCoupons").on("click",function(){
		submitOrderConfirmForm("selectCoupons");
	});
	
	// 银行贷款
	$("#editHireLoan").on("click",function(){
		submitOrderConfirmForm("editHireLoan");
	});
	
	// 确认付款
	$("#confirmPay").on("click",function(){
		if(validateForm()){
			submitOrderConfirmForm("createOrder");			
		}
	});
	
});

function submitOrderConfirmForm(editType){
	$("#message").val($("#messageTextarea").val());
	$("#orderConfirmForm")[0].action = "orderConfirm/"+editType;
	$("#orderConfirmForm").submit();
}

/**
 * 验证页面数据完整性、准确性
 * @returns
 */
function validateForm(){
	// 验证选择租赁方案
	$("font[data-type=hirePlan]").each(function(){
		if($(this).attr("data-value") == 0){
			tip.autoShow("请为所有租赁、预租产品选择租赁方案！");
			return false;
		}
	});
	
	// 验证选择送货方式
	var receiveTypeSelected = false;
	var receiveType;
	$("i[data-type=receiveTypeI]").each(function(){
		if($(this).attr("data-check") == "1"){
			receiveTypeSelected = true;
			receiveType = $(this).attr("data-value");
		}
	});
	if(!receiveTypeSelected){
		tip.autoShow("请选择送货方式！");
		return false;
	}
	// 验证送货上门录入收货地址
	if(receiveType == 1){
		if($("#address").attr("data-value")==0){
			tip.autoShow("送货上门方式请填写收货地址！");
			return false;
		}
	// 验证到店取货选择提货地址
	}else if(receiveType == 2){
		if($("#picUpAddress").attr("data-value")==0){
			tip.autoShow("到店取货方式请选择提货地址！");
			return false;
		}
	}
	tip.autoShow("创建订单！！！");
//	return false;
	return true;
}

function setShowBottomSize(){
	var ShowBottom =$(".minicast_content_pic_bottom")
	console.log(ShowBottom)
	var ShowBottomspan =ShowBottom.children("span")
	for(var i = 0; i<ShowBottomspan.length; i++){
		ShowBottomspan[i].style.height = ShowBottomspan[0].offsetWidth +'px';
		ShowBottomspan[i].style.lineHeight = ShowBottomspan[0].offsetWidth +'px';
	}
}

setShowBottomSize();

