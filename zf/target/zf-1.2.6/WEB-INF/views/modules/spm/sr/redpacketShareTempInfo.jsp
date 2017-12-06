<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>红包分享模板管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    
        <section class="content">
            <div class="row">
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            
                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>模板名称</b> 
                                    <a class="pull-right">${redpacketShareTemp.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>金额类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.amountType, 'spm_sr_redpacket_amountType', '')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>红包金额</b> 
                                    <a class="pull-right">${redpacketShareTemp.amount}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>最大金额</b> 
                                    <a class="pull-right">${redpacketShareTemp.maxAmount}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>最小金额</b> 
                                    <a class="pull-right">${redpacketShareTemp.minAmount}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>抢红包类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.shareType, 'spm_sr_redpacket_shareType', '')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>有效时间（天）</b> 
                                    <a class="pull-right">${redpacketShareTemp.activeDays}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>数量类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.numType, 'spm_sr_redpacket_numType', '')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>数量</b> 
                                    <a class="pull-right">${redpacketShareTemp.num}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>最大数量</b> 
                                    <a class="pull-right">${redpacketShareTemp.maxNum}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>最小数量</b> 
                                    <a class="pull-right">${redpacketShareTemp.minNum}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>使用状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.tempStatus, 'spm_sr_tempStatus', '')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>启用时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${redpacketShareTemp.redpacketStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>红包类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.redpacketType, 'spm_sr_redpacket_redpacketType', '')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>规则说明</b> 
                                    <a class="pull-right">${redpacketShareTemp.ruleExplain}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>活动说明</b> 
                                    <a class="pull-right">${redpacketShareTemp.activeExplain}</a>
                                </li>
                            </ul>
                            
                        </div>
                        
                        <div class="box-footer">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                                <i class="fa fa-mail-reply"></i>返回
                            </button>
                        </div>
                    </div>
               </div>
            </div>
         </section>
</div>
</body>
</html>