//地址列表滚动区
var addressScroll=null;
var addressData=null;

/**
 * 初始化函数
 */
$(function(){
	$("#noContent").html("暂无内容")
	
    //跳转到添加收货地址页面
    $(".address_button").click(function(){
        window.location.href = ctxWeb+"/member/addressWeb/toAddressSave";
    });
    //点击修改收货地址跳出编辑和删除按钮
    $("#editAddress").click(function(){
        $(".show_hide").toggle();
    });
    $("#selectAddress").click(function(){
        $(".show_hide").toggle();
    });

	//初始化地址列表滚动区Scroll
	addressScroll=new MyScroll("#addressWrapper",{
				loadType:2,
				headerHeight:40,
				isPage:false,
				getParameter:getParameter,
				loadUrl:ctxWeb+"/member/address",
				clear:function(){
						$(".address_list").html("")
				},
				loadSuccess:loadData,
				noDataView:$("#noContent")
		});

});

/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	return null;
}

/**
 * 根据返回的地址List拼接html
 * @param list
 */
function loadData(list){
	addressData=list;
	var html = "<div id='loading' class='loading'><img style='height: 26px;width: 26px;margin: 2px 10px;float: none;' src='"+ctxMobile+"/pages/address/images/loading.gif'/>正在载入...</div>";
    for(var i = 0; i < list.length; i++) {
        var result = list[i];
        if(result.defaultFlag == 1){//等1表示默认地址
            html = html + "<div id='"+result.id+"' class='list_item'>"+
                "<i class='iconfont more'>&#xe622;</i>"+
                "<div class='name'>"+
                "<span>"+result.receiveName+"</span>"+
                "<span>"+result.receiveTel+"</span>"+
                "</div>"+
                "<div class='address'>"+
                "<span>默认</span>"+
                "<p>"+result.addressArea+result.addressDetail+"</p>"+
                "</div>"+
                "<div class='list_botton show_hide'>"+
                "<span id='' class='edit' onclick=\"edit('"+result.id+"');\">编辑</span>"+
                "<span id='' class='delete' onclick=\"remover('"+result.id+"')\">删除</span>"+
                "</div>"+
                "</div>";
        }else{
            html = html + "<div id='"+result.id+"' class='list_item'>"+
                "<div class='name'>"+
                "<span>"+result.receiveName+"</span>"+
                "<span>"+result.receiveTel+"</span>"+
                "</div>"+
                "<div class='address'>"+
                "<p>"+result.addressArea+result.addressDetail+"</p>"+
                "</div>"+
                "<div class='list_botton show_hide'>"+
                "<span id='' class='edit' onclick=\"edit('"+result.id+"');\">编辑</span>"+
                "<span id='' class='delete' onclick=\"remover('"+result.id+"')\">删除</span>"+
                "<span id='"+result.id+"Btn' class='setDefault' onclick=\"defaultFlag('"+result.id+"')\">设为默认</span>"+
                "</div>"+
                "</div>";
        }

    }
    $(".address_list").html(html);
}

/**
 * ajax设置默认地址
 * 返回成功后调用loadData()重绘页面
 * @param id
 */
function defaultFlag(id){
    ajax.submit(
    	'POST',
        ctxWeb+'/member/address/'+id+'',
        {},
        function(data){
            if(data.status == Constants.SUCCESS){
            	if(addressData==null)
            		return;
	        	 for(var i = 0; i < addressData.length; i++) {
	        		 if(addressData[i].id==id){
	        			 addressData[i].defaultFlag=1
	        		 }else if(addressData[i].defaultFlag == 1){
	        			 addressData[i].defaultFlag=0;
	        		 }
	        	 }
	        	 loadData(addressData);
            }
        }
    );
}

/**
 * 跳转到编辑页面
 * @param id
 */
function edit(id){
    window.location.href = ctxWeb+"/member/addressWeb/toAddressSave?addressId="+id;
}

/**
 * ajax删除对应地址
 * 返回成功后调用loadData()重绘页面
 * @param id
 */
function remover(id){
    ajax.submit(
    	'delete',
        ctxWeb+'/member/address/'+id+'',
        {},
        function(data){
            if(data.status == Constants.SUCCESS){
            	if(addressData==null)
            		return;
	        	 for(var i = 0; i < addressData.length; i++) {
	        		 if(addressData[i].id==id){
	        			 addressData.splice(i,1);
	        			 break;
	        		 }
	        	 }
	        	 loadData(addressData);
            }
        }
    );
}

