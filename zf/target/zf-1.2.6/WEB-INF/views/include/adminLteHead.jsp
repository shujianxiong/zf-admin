<%@ page contentType="text/html;charset=UTF-8" %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="author" content="http://www.baidu.com/"/>
<meta name="renderer" content="webkit">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- jquery 4.6 -->
<link rel="stylesheet" href="${ctxStatic }/jqGrid/4.6/css/metor/jquery-ui.css">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/dist/font-awesome-4.4.0/css/font-awesome.css">
<!-- Ionicons -->
<!-- <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/dist/ionicons-2.0.1/css/ionicons.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
     folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/dist/css/skins/_all-skins.min.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
<!-- datatables -->
<%-- <link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/datatables/jquery.dataTables.min.css"> --%>
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/datatables/dataTables.bootstrap.css">
<!-- select2 -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/select2/select2.min.css">
<!-- datepicker -->
<%-- <link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/datepicker/datepicker3.css"> --%>
<!-- datetimepicker -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/datetimepicker/bootstrap-datetimepicker.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/dist/css/AdminLTE.min.css">
<!-- PACE 页面加载进度条-->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/pace/pace.min.css">
<!-- toastr 页面提示消息-->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/toastr/css/toastr.min.css">
<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/iCheck/all.css">
<!-- bootstrap-treeview -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/bootstrap-treeview/dist/bootstrap-treeview.min.css">
<!-- zf.css -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/zfFrame/zf.css">


<!-- jQuery 2.1.4 -->
<script src="${ctxStatic }/adminLte/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="${ctxStatic }/adminLte/plugins/jQueryUI/jquery-ui.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="${ctxStatic }/adminLte/bootstrap/js/bootstrap.min.js"></script>
<!-- PACE 页面加载进度条-->
<script src="${ctxStatic }/adminLte/plugins/pace/pace.min.js"></script>
<!-- Sparkline -->
<script src="${ctxStatic }/adminLte/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- datepicker -->
<script src="${ctxStatic }/adminLte/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="${ctxStatic }/adminLte/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js"></script>
<!-- datetimepicker -->
<script src="${ctxStatic }/adminLte/plugins/datetimepicker/moment-with-locales.js"></script>
<script src="${ctxStatic }/adminLte/plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="${ctxStatic }/adminLte/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- datatables -->
<script src="${ctxStatic }/adminLte/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${ctxStatic }/adminLte/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- select2 -->
<script src="${ctxStatic }/adminLte/plugins/select2/select2.min.js"></script>
<!-- AdminLTE App -->
<script src="${ctxStatic }/adminLte/dist/js/app.js"></script>
<!-- Jeesite tools -->
<script src="${ctxStatic}/common/jeesite.min.js" type="text/javascript"></script>
<!-- iCheck 1.0.1 -->
<script src="${ctxStatic }/adminLte/plugins/iCheck/icheck.min.js"></script>
<!-- toastr 2.1.2 -->
<script src="${ctxStatic }/adminLte/plugins/toastr/js/toastr.min.js"></script>
<!-- bootstrap-treeview -->
<script src="${ctxStatic }/adminLte/plugins/bootstrap-treeview/dist/bootstrap-treeview.min.js"></script>
<!-- mustache -->
<script src="${ctxStatic}/common/mustache.min.js" type="text/javascript"></script>
<!-- Slimscroll -->
<script src="${ctxStatic }/adminLte/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- zf utils -->
<script src="${ctxStatic }/adminLte/plugins/zfFrame/zf.js"></script>
<script type="text/javascript">
var ctx="${ctx}";
var ctxStatic="${ctxStatic}";
var imgHost="${imgHost}";

function imgOnerror(img) {
	img.src = "${ctxStatic}/images/default.png";
	$(img).attr("data-src", "${ctxStatic}/images/default.png");
	img.onerror = null;
}


</script>
