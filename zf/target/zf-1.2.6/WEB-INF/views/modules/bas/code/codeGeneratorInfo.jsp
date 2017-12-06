<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务编码生成器管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
        
        <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">生成器说明须知</th>
                        <td colspan="3">
                            1.最终生成编码由“前缀+日期值+中缀+主值+后缀”组成，其中前缀、中缀、后缀可以为空，主值不足主值长度的部分前面用0填充。<br/>
                            2.主值为该生成器生成的最后一个编码的主值取值，为0或为空表示该生成器暂未使用过。<br/>
                            3.自增主值每次使用自增加1，随机自增主值每次使用自增加1至9中随机一个数，带日期的编码每天主值初始化为1。<br/>
                            4.随机类型主值每次产生一个随机数（不足主值长度的部分用9填充），产生的编码不排除重复的可能，需要在调用代码中处理或对应数据库字段设置唯一性限制。
                        </td>
                    </tr>
                    <tr>
                        <th width="10%">生成器代码</th>
                        <td>${codeGenerator.codeHandle }</td>
                    </tr>
                    <tr>
                        <th width="10%">编码名称</th>
                        <td>${codeGenerator.codeName }</td>
                    </tr>
                    <tr>
                        <th width="10%">前缀</th>
                        <td>${codeGenerator.prefix }</td>
                    </tr>
                    <tr>
                        <th width="10%">日期类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(codeGenerator.dateType,'bas_code_generator_dateType','') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">日期值</th>
                        <td>${codeGenerator.dateValue }</td>
                    </tr>
                    <tr>
                        <th width="10%">中缀</th>
                        <td>${codeGenerator.midfix }</td>
                    </tr>
                    <tr>
                        <th width="10%">主值随机类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(codeGenerator.mainValueType,'bas_code_generator_mainValueType','') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">主值长度</th>
                        <td>${codeGenerator.mainValueLength }</td>
                    </tr>
                    <tr>
                        <th width="10%">主值</th>
                        <td>${codeGenerator.mainValue }</td>
                    </tr>
                    <tr>
                        <th width="10%">后缀</th>
                        <td>${codeGenerator.postfix }</td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="4"><p class="text-muted well well-sm no-shadow">${codeGenerator.remarks }</p></td>
                    </tr>
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