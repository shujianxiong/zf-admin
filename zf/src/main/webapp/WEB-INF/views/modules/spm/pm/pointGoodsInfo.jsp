<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>积分商品管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">

        <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">基本信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">编号</th>
                        <td colspan="3">${pointGoods.code}</td>
                    </tr>
                    <tr>
                        <th width="10%">名称</th>
                        <td>${pointGoods.name}</td>
                        <th width="10%">获取限制类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(pointGoods.gainType, 'spm_pm_point_goods_gainType', '') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">上架标记</th>
                        <td><span class="label label-primary">${fns:getDictLabel(pointGoods.upFlag, 'yes_no', '') }</span></td>
                        <th width="10%">来源类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(pointGoods.srcType, 'spm_pm_point_goods_srcType', '') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">展示金额</th>
                        <td>${pointGoods.displayPrice}</td>
                        <th width="10%">所需积分</th>
                        <td>${pointGoods.point}</td>
                    </tr>
                    <tr>
                        <th width="10%">总库存数量</th>
                        <td>${pointGoods.totalNum}</td>
                        <th width="10%">可用库存数量</th>
                        <td>${pointGoods.usableNum}</td>
                    </tr>
                    <tr>
                        <th width="10%">列表图片</th>
                        <td colspan="3"><img src="${imgHost }${pointGoods.listPhoto}" class="img-responsive" /></td>
                    </tr>
                    <tr>
                        <th width="10%">主图片</th>
                        <td colspan="3"><img src="${imgHost }${pointGoods.mainPhoto}" class="img-responsive" /></td>
                    </tr>
                    <tr>
                        <th width="10%">奖品介绍</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${pointGoods.introduce }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">创建人</th>
                        <td>${fns:getUserById(pointGoods.createBy.id).name }</td>
                        <th width="10%">创建时间</th>
                        <td><fmt:formatDate value="${pointGoods.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    
                    <tr>
                        <th width="10%">更新人</th>
                        <td>${fns:getUserById(pointGoods.updateBy.id).name }</td>
                        <th width="10%">更新时间</th>
                        <td><fmt:formatDate value="${pointGoods.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${property.remarks }</p></td>
                    </tr>
                </table>
            </div>
            <div class="box-footer">
                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                    <i class="fa fa-mail-reply"></i>返回
                </button>
            </div>
        </section>
         
</div>
</body>
</html>