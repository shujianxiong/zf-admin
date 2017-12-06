<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品变更记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produceItem/">产品变更记录列表</a></small>
            <shiro:hasPermission name="lgt:ps:produceItem:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/produceItem/form">产品变更记录添加</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>查询条件</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            
            <form:form id="searchForm" modelAttribute="produceItem" action="${ctx}/lgt/ps/produceItem/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">产品编码</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="code" id="code" verifyType="99" tip="请输入要查询的产品编码" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                        <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                    </div>
                </div>
            </form:form>
        </div>
    
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th class="zf-dataTables-multiline"></th>
                                <th>样图</th>
			                    <th>产品编码</th>
			                    <th>名称</th>
			                    <th>标准克重</th>
			                    <th>采购价</th>
			                    <th>运算成本价</th>
			                    <th>运算加价系数</th>
			                    <th>销售价</th>
			                    <th>体验费比例</th>
			                    <th>体验押金比例</th>
			                    <th>积分可抵金额</th>
			                    <th>促销特价</th>
			                    <th>促销折扣</th>
			                    <th>促销筛选折扣</th>
			                    <th>促销生效时间</th>
			                    <th>促销失效时间</th>
			                    <th style="display:none;">创建者</th>
                                <th style="display:none;">创建时间</th>
                                <th style="display:none;">更新者</th>
                                <th style="display:none;">更新时间</th>
                                <th style="display:none;">备注信息</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="pi" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td><img onerror="imgOnerror(this);" src="${imgHost }${pi.produce.goods.samplePhoto}" data-big data-src="${imgHost }${pi.produce.goods.samplePhoto}" width="60px;" height="60px;"/></td>
			                        <td>${pi.produce.code }</td>
			                        <c:set var="fullName" value="${pi.produce.goods.name } ${pi.produce.name }"></c:set>
                                    <td title="${fullName }">${fns:abbr(fullName, 15)}</td>
			                        <td>${pi.preItem.standardWeight } <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i> ${pi.standardWeight }</td>
			                        <td>
			                            <c:if test="${pi.preItem.pricePurchase ne pi.pricePurchase }"><span class='text-red'></c:if>
			                            ${pi.preItem.pricePurchase }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.pricePurchase }
			                            <c:if test="${pi.preItem.pricePurchase ne pi.pricePurchase }"></span></c:if>
			                            
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.priceOperation ne pi.priceOperation }"><span class='text-red'></c:if>
			                            ${pi.preItem.priceOperation }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.priceOperation }
			                            <c:if test="${pi.preItem.priceOperation ne pi.priceOperation }"></span></c:if>
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.ratioOperation ne pi.ratioOperation }"><span class='text-red'></c:if>
			                            ${pi.preItem.ratioOperation }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.ratioOperation }
			                            <c:if test="${pi.preItem.ratioOperation ne pi.ratioOperation }"></span></c:if>
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.priceSrc ne pi.priceSrc }"><span class='text-red'></c:if>
			                            ${pi.preItem.priceSrc }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.priceSrc }
			                            <c:if test="${pi.preItem.priceSrc ne pi.priceSrc }"></span></c:if>
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.scaleExperienceFee ne pi.scaleExperienceFee }"><span class='text-red'></c:if>
			                            ${pi.preItem.scaleExperienceFee }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.scaleExperienceFee }
			                            <c:if test="${pi.preItem.scaleExperienceFee ne pi.scaleExperienceFee }"></span></c:if>
			                        </td>
			                        <td>
                                        <c:if test="${pi.preItem.scaleExperienceDeposit ne pi.scaleExperienceDeposit }"><span class='text-red'></c:if>
                                        ${pi.preItem.scaleExperienceDeposit }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.scaleExperienceDeposit }
                                        <c:if test="${pi.preItem.scaleExperienceDeposit ne pi.scaleExperienceDeposit }"></span></c:if>
                                    </td>
                                    <td>
                                        <c:if test="${pi.preItem.priceDecPoint ne pi.priceDecPoint }"><span class='text-red'></c:if>
                                        ${pi.preItem.priceDecPoint }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.priceDecPoint }
                                        <c:if test="${pi.preItem.priceDecPoint ne pi.priceDecPoint }"></span></c:if>
                                    </td>
			                        <td>
			                            <c:if test="${pi.preItem.discountPrice ne pi.discountPrice }"><span class='text-red'></c:if>
			                            ${pi.preItem.discountPrice }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.discountPrice }
			                            <c:if test="${pi.preItem.discountPrice ne pi.discountPrice }"></span></c:if>
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.discountScale ne pi.discountScale }"><span class='text-red'></c:if>
			                            ${pi.preItem.discountScale }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.discountScale }
			                            <c:if test="${pi.preItem.discountScale ne pi.discountScale }"></span></c:if>
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.discountFilterScale ne pi.discountFilterScale }"><span class='text-red'></c:if>
			                            ${pi.preItem.discountFilterScale }  <i class="fa fa-arrow-right" style="color: #CDC9C9;"></i>  ${pi.discountFilterScale }
			                            <c:if test="${pi.preItem.discountFilterScale ne pi.discountFilterScale }"></span></c:if>
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.discountFilterStart ne pi.discountFilterStart }"><span class='text-red'></c:if>
			                            <fmt:formatDate value="${pi.preItem.discountFilterStart}" pattern="yyyy-MM-dd HH:mm:ss"/></span> <br/> <i class="fa fa-arrow-down" style="color: #CDC9C9;"></i> <br/><span class='text-red'><fmt:formatDate value="${pi.discountFilterStart}" pattern="yyyy-MM-dd HH:mm:ss"/>
			                            <c:if test="${pi.preItem.discountFilterStart ne pi.discountFilterStart }"></span></c:if>
			                        </td>
			                        <td>
			                            <c:if test="${pi.preItem.discountFilterEnd ne pi.discountFilterEnd }"><span class='text-red'></c:if>
			                            <fmt:formatDate value="${pi.preItem.discountFilterEnd}" pattern="yyyy-MM-dd HH:mm:ss"/></span><br/>  <i class="fa fa-arrow-down" style="color: #CDC9C9;"></i> <br/><span class='text-red'><fmt:formatDate value="${pi.discountFilterEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>
			                            <c:if test="${pi.preItem.discountFilterEnd ne pi.discountFilterEnd }"></span></c:if>
			                        </td>
			                        
			                        <td data-hide="true">
                                        ${fns:getUserById(pi.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${pi.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(pi.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${pi.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(pi.remarks, 15)}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box-footer">
                <div class="dataTables_paginate paging_simple_numbers">${page}</div>
            </div>
        </div>
     </section>
    </div>
    
    <script>
      $(function () {
        
        ZF.bigImg();
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
          
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : true,
            "order": [[ 18, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16}
                
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        })
      });
      
   </script>
</body>
</html>