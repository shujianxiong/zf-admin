<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员列表管理</title>
	<meta name="decorator" content="adminLte"/>
    <style>
        a:hover {
            cursor: pointer;
        }
    </style>
    <script>
        var  a = ${fns:toJson(member)}
    </script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	
	    <section class="content-header content-header-menu">
            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>会员信息</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <%--<tr>--%>
                                <%--<th width="10%">头像</th>--%>
                                <%--<td colspan="3"><img alt="" class="img-responsive"  src="${imgHost}${member.gravatar }" width="100px;" height="100px;"></td>--%>
                            <%--</tr>--%>
                            <tr>
                                <th width="10%">会员账号</th>
                                <td>${member.usercode }</td>
                                <th width="10%">会员微信账号</th>
                                <td>${member.wechatCode }</td>
                            </tr>
                            <tr>
                                <th width="10%">会员编号</th>
                                <td>${member.memberCode }</td>
                                <th width="10%">会员类型</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.type,'crm_mi_member_type','')}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">昵称</th>
                                <td>${member.nickname }</td>
                                <th width="10%">性别</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.sex,'sex','')}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">生日</th>
                                <td>${member.birthday }</td>
                                <th width="10%">年龄</th>
                                <td>${member.age }</td>
                            </tr>
                            <tr>
                                <th width="10%">联系电话</th>
                                <td>${member.mobile }</td>
                                <th width="10%">电子邮箱</th>
                                <td>${member.email }</td>
                            </tr>
                            <%--<tr>--%>
                                <%--<th width="10%">个性签名</th>--%>
                                <%--<td colspan="3">${member.sign }</td>--%>
                            <%--</tr>--%>
                            <%--<tr>--%>
                                <%--<th width="10%">工作单位</th>--%>
                                <%--<td>${member.company }</td>--%>
                                <%--<th width="10%">推荐会员</th>--%>
                                <%--<td>${member.recommendMember.id }</td>--%>
                            <%--</tr>--%>
                            <tr>
                                <th width="10%">注册来源</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.registerPlatform,'crm_mi_member_registerPlatform','')}</span></td>
                                <th width="10%">注册时间</th>
                                <td><fmt:formatDate value="${member.registerTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            </tr>
                            <tr>
                                <th width="10%">会员状态</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.memberStatus,'crm_mi_member_memberStatus','')}</span></td>
                                <th width="10%">账号状态</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.usercodeStatus,'crm_mi_member_usercodeStatus','')}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">黑名单状态</th>
                                <td colspan="3"><span class="label label-primary">${fns:getDictLabel(member.blackwhiteStatus,'crm_mi_member_blackwhiteStatus','')}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">积分</th>
                                <td><span class="label label-primary">${member.point}</span></td>
                                <th width="10%">信誉</th>
                                <td><span class="label label-primary">${member.credit}</span></td>
                            </tr>
                            <tr>
                                <th width="10%">黑名单备注</th>
                                <td colspan="3"><input id="blackwhiteRemark" value="${member.blackwhiteRemark }" class="form-control"></td>
                            </tr>
                            <tr>
                                <th width="10%">备注</th>
                                <td colspan="3">
                                    <input id="remarks" value="${member.remarks }" class="form-control">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>用户个人信息</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">姓名</th>
                                <td>${member.name }</td>
                                <th width="10%">身份证</th>
                                <td>${member.idCard }</td>
                            </tr>
                            <tr>
                                <th width="10%">年龄</th>
                                <td>${member.age }</td>
                                <th width="10%">性别</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.sex,'sex','')}</span></td>
                            </tr>

                            <tr>
                                <th width="10%">职务</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.job,'crm_mi_member_job','')}</span></td>
                                <th width="10%">收入</th>
                                <td><span class="label label-primary">${fns:getDictLabel(member.income,'crm_mi_member_income','')}</span></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-sm-1">
                        <mark style="font-weight: bold; font-size: 14px; background-color: #fff">默认地址</mark>
                    </div>
                    <c:if test="${address != null}">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                                <thead>
                                <tr>
                                    <th>姓名</th>
                                    <th>联系电话</th>
                                    <th>收货地址</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                       ${address.receiveName}
                                    </td>
                                    <td>
                                       ${address.receiveTel}
                                    </td>
                                    <td>
                                       ${fns:getAreaFullNameById(address.sysArea.id)}&nbsp;&nbsp;${address.addressDetail }
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>用户交易信息</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">首次下单日期</th>
                                <td><fmt:formatDate value="${exTradeInfo.firstOrderTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate> </td>
                                <th width="10%">体验总次数</th>
                                <td>${exTradeInfo.experienceTimes }</td>
                            </tr>
                            <tr>
                                <th width="10%">体验商品总额</th>
                                <td>${exTradeInfo.experienceTotalMoney }</td>
                                <th width="10%">购买总次数</th>
                                <td>${buyTradeInfo.buyTimes}</td>
                            </tr>

                            <tr>
                                <th width="10%">购买商品数量</th>
                                <td>${buyProduceNum}</td>
                                <th width="10%">购买总金额</th>
                                <td>${buyTradeInfo.buyMoney}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>体验包明细列表</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">当前体验包</th>
                                <td>${currentExPack.name}</td>
                            </tr>
                        </table>
                    </div>
                    <a id="historicalExperiencePackItem" title="点击查看">历史体验包明细</a>
                </div>
            </div>

            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>用户积分信息</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">当前积分</th>
                                <td>${beans.currentBeans}</td>
                            </tr>
                        </table>
                    </div>
                    <a id="addBeansDetail" title="点击查看">积分来源明细</a>
                    <a id="descBeansDetail" title="点击查看">积分抵扣明细</a>
                </div>
            </div>

            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>用户售后信息</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">超期归还订单次数</th>
                                <td>${returnOverdueNum}</td>
                                <th width="10%">取消订单次数</th>
                                <td>${saCancel }</td>
                            </tr>
                            <tr>
                                <th width="10%">免责退货次数</th>
                                <td>${saRelife}</td>
                                <th width="10%">合理拒收次数</th>
                                <td></td>
                            </tr>

                            <tr>
                                <th width="10%">无理由拒收次数</th>
                                <td></td>
                                <th width="10%">商品轻微损坏件数</th>
                                <td>${slightDamageNum}</td>
                            </tr>
                            <tr>
                                <th width="10%">商品轻度以上损坏次数</th>
                                <td>${upSlightDamageNum}</td>
                                <th width="10%">商品丢失件数</th>
                                <td>${lostNum}</td>
                            </tr>
                            <tr>
                                <th width="10%">投诉次数</th>
                                <td>${saAll}</td>
                                <th width="10%">咨询次数</th>
                                <td></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>用户邀请信息</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">邀请注册数</th>
                                <td>${inviteNum}</td>
                                <th width="10%">体验包奖励数</th>
                                <td>${exGift}</td>
                            </tr>
                            <tr>
                                <th width="10%">邀请会员下单数</th>
                                <td>${inviteExOrderNum}</td>
                                <th width="10%">邀请会员购买数</th>
                                <td>${inviteBuyTradeInfo.buyTimes}</td>
                            </tr>

                            <tr>
                                <th width="10%">邀请会员购买金额</th>
                                <td>${inviteBuyTradeInfo.buyMoney}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header with-border zf-query">
                    <h5>风险信息</h5>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th width="10%">超期归还次数</th>
                                <td>${returnOverdueNum}</td>
                                <th width="10%"><a id="arrearageInfo" title="点击查看">欠费信息</a></th>
                            </tr>
                            <tr>
                                <th width="10%">备注信息</th>
                                <td><input id="arrearageRemark" value="${member.arrearageRemark }" class="form-control"></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-left box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                    </div>
                    <div class="pull-right box-tools">
                        <button id="btn" type="button" onclick="saveInfo();"  class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
                    </div>
                </div>
            </div>

        </section>



        <div id="infoModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" style="width: 1500px; height: 700px;">
                <div class="modal-content" style="width: 100%; height: 100%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"
                                aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body" style="width: 100%; height: 80%;">
                        <input type="hidden" id="memberSelectModalUrl" />
                        <iframe id="infoIframe" src="" width="100%" height="100%" frameborder="0"></iframe>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>




	</div>

    <script>
        $(function(){
            $("#addBeansDetail").on('click',function() {
                $('.modal-title').text("查看积分信息");
                $("#infoIframe").attr("src","${ctx}/crm/mb/beansDetail/userInfolist?changeType='A'&beans.id="+"${beans.id}");
                $("#infoModal").modal('toggle');//显示模态框
            });

            $("#descBeansDetail").on('click',function() {
                $('.modal-title').text("查看积分信息");
                $("#infoIframe").attr("src","${ctx}/crm/mb/beansDetail/userInfolist?changeType='D'&beans.id="+"${beans.id}");
                $("#infoModal").modal('toggle');//显示模态框
            });
            
            $("#historicalExperiencePackItem").on('click',function() {
                $('.modal-title').text("历史体验包明细");
                $("#infoIframe").attr("src","${ctx}/spm/ep/experiencePackItem/historicalExperiencePackItem?member.id="+"${member.id}");
                $("#infoModal").modal('toggle');//显示模态框
            });

            $("#arrearageInfo").on('click',function() {
                $('.modal-title').text("欠费信息");
                $("#infoIframe").attr("src","${ctx}/bus/oe/experienceOrder/arrearageInfo?member.id="+"${member.id}");
                $("#infoModal").modal('toggle');//显示模态框
            });
        });

        function saveInfo() {
            var count = 5;
            var countdown = setInterval(CountDown, 1000);
            function CountDown() {
                $("#btn").attr("disabled", true);
                $("#btn").html(" <i class=\"fa fa-save\"></i>"+count + "s");
                if (count == 0) {
                    $("#btn").removeAttr("disabled");
                    clearInterval(countdown);
                    $("#btn").html(" <i class=\"fa fa-save\"></i>保存")
                }
                count--;
            }
            let memberId = "${member.id}";
            const param = {
                memberId: memberId,
                'arrearageRemark': $("#arrearageRemark").val(),
                'blackwhiteRemark': $("#blackwhiteRemark").val(),
                remarks: $("#remarks").val(),

            }
            ZF.ajaxQuery(true,"${ctx}/crm/mi/member/saveRemarks", param, function (data) {
                if(data.status == '1'){
                    ZF.showTip('操作成功', 'success');
                    return false;
                }else {
                    ZF.showTip('系统错误，请稍后再试', 'error');
                    return false;
                }
            })
        }
    </script>
</body>
</html>