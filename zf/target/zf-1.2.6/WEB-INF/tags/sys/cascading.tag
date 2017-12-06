<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="选中区的名称" %>
<%@ attribute name="value" type="java.lang.String" required="true" description="选中区的ID标识" %>
<%@ attribute name="parentIds" type="java.lang.String" required="true" description="选中区的父级ID集合,以0,1,开头,中间用英文逗号分隔,以英文逗号结尾，如：0,1,1111,"%>
<%@ attribute name="provinceList" type="java.util.List" required="true" description="省份集合"%>
<%@ attribute name="cityList" type="java.util.List" required="false" description="市集合"%>
<%@ attribute name="districtList" type="java.util.List" required="false" description="区集合"%>
<!-- 

不管新建还是修改状态，省份都是可以固定下来的，所以一定要有，修改的时候，市集合和区集合，也是一定要有的，这是为了能显示上一步选中的值，而具体集合可以通过之前选中的区域拿到 
这个tag的诞生是不希望每个涉及省市区级联的地方都要写一遍这段代码，故提取出来的。

-->
<div class="col-sm-4" style="padding-left: 0px;">
     <select id="province">
        <option value="-1">请选择</option>
        <c:forEach items="${provinceList }" var="area">
            <option value="${area.id }">${area.name }</option>
        </c:forEach>
     </select>
</div>
<div class="col-sm-4" style="padding-left: 0px;">
     <select id="city">
          <option value="-1">请选择</option>
          <c:forEach items="${cityList }" var="area">
              <option value="${area.id }">${area.name }</option>
          </c:forEach>
     </select>
</div>
<div class="col-sm-4" style="padding-left: 0px;padding-right: 0px;">
    <select id="district" name="${name }">
          <option value="-1">请选择</option>
          <c:forEach items="${districtList }" var="area">
              <option value="${area.id }">${area.name }</option>
          </c:forEach>
    </select>
</div>

<script type="text/javascript">
var parentIds = "${parentIds}";
if(parentIds != null && parentIds != '' && parentIds != undefined) {
    var idsArr = parentIds.substring(4, parentIds.length-1).split(',');
    var len = idsArr.length;
    if(len == 1) {
    	$("#province").val(idsArr[0] == null || idsArr[0] == '' || idsArr[0] == 1 ? "-1" : idsArr[0]);
    } else if(len == 2) {
    	$("#province").val(idsArr[0] == null || idsArr[0] == '' || idsArr[0] == 1 ? "-1" : idsArr[0]);
    	$("#city").val(idsArr[1] == null || idsArr[1] == '' || idsArr[1] == 1 ? "-1" : idsArr[1]);
    } 
    var areaId = "${value}";//如果是中国，则只显示请选择
    $("#district").val(areaId == null || areaId == '' || areaId == 1 ? "-1" : areaId);
}

$("#province").on("change", function() {
    ZF.ajaxQuery(false,"${ctx}/sys/area/listAreaByParentId",$.parseJSON('{"parent.id":"'+$(this).val()+'"}'),function(data){
        console.log(data);
        var opStr = "<option value='-1'>请选择</option>";
        for(var i = 0; i < data.length; i++) {
              opStr += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
        }
        $("#city").html(opStr);
        $("#city").select2('val', '-1');
    },function(){
        //TODO
    });
});

$("#city").on("change", function() {
    ZF.ajaxQuery(false,"${ctx}/sys/area/listAreaByParentId",$.parseJSON('{"parent.id":"'+$(this).val()+'"}'),function(data){
        console.log(data);
        var opStr = "<option value='-1'>请选择</option>";
        for(var i = 0; i < data.length; i++) {
              opStr += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
        }
        $("#district").html(opStr);
        $("#district").select2('val', '-1');
    },function(){
        //TODO
    });
});
</script> 
