<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>拣货单管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
        <section class="invoice">
            <p class="lead">托盘编号【${list.get(0).plateNo }】拣货任务明细</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <%-- <c:forEach items="${maps }" var="entry">
	                    <tr>
	                        <th>货位：${entry.key }</th>
	                    </tr>
	                    <c:if test="${not empty entry.value }">
			                <c:forEach items="${entry.value }" var="p">
		                        <tr>
	                               <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
			                           <tr>
			                               <td rowspan="5"><h2 style="color: red;">${p.pickNo }</h2></td>
			                               <td rowspan="5"><img src="${imgHost }${p.goods.icon }" data-big data-src="${imgHost }${p.goods.icon }" width="100px" height="100px;"/></td>
			                           </tr>
		                               <tr>
		                                   <th>产品编码</th>
		                                   <td>${p.code }</td>
		                               </tr>
		                               <tr>
	                                       <th>产品名称</th>
	                                       <td>${p.name }</td>
	                                   </tr>
	                                   <tr>
	                                       <th>出库数量</th>
	                                       <td>${p.num }</td>
	                                   </tr>
		                           </table>
			                    </tr>
			                </c:forEach>
	                    </c:if>
                    </c:forEach> --%>
                    
                    <thead>
                        <tr>
                            <th>商品名称</th>
                            <th>货位</th>
                            <th>产品规格</th>
                            <th>出库数量</th>
                            <th>所属托盘位置</th>                        
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach items="${list }" var="p">
	                        <tr>
	                           <td>${p.goods.name }</td>
	                           <td>${p.fullWareplace }</td>
	                           <td>${p.name }</td>
	                           <td>${p.num }</td>
	                           <td>${p.pickNo }</td>
	                        </tr>
	                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="box-footer">
                <button type="button" class="btn btn-default btn-sm"
                    onclick="javascript:history.go(-1)">
                    <i class="fa fa-mail-reply"></i>返回
                </button>
            </div>
        </section>
     </div>
</body>
</html>