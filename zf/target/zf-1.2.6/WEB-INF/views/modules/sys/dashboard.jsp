<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>仪表盘</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	    <!-- Content Header (Page header) -->
	    <section class="content-header">
	      <h1>
	        	仪表盘
	        <small>欢迎使用周范后台管理系统</small>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
        
	    <section class="content">
			<div class="row">
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-aqua">
						<div class="inner">
							<h3>${waitSendOrderCount }</h3>

							<p>今日待发货订单量</p>
						</div>
						<div class="icon">
							<i class="ion ion-bag"></i>
						</div>
					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-green">
						<div class="inner">
							<h3>
								<fmt:formatNumber value="${payRate}" type="percent" pattern="#0.00%"/>
							</h3>

							<p>今日订单支付比（已支付订单/日订单总量）</p>
						</div>
						<div class="icon">
							<i class="ion ion-stats-bars"></i>
						</div>
					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-yellow">
						<div class="inner">
							<h3>${registerMemberCount }</h3>

							<p>今日注册会员量</p>
						</div>
						<div class="icon">
							<i class="ion ion-person-add"></i>
						</div>
					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-red">
						<div class="inner">
							<h3>${sendingOrderCount }</h3>

							<p>今日已发货订单量</p>
						</div>
						<div class="icon">
							<i class="ion ion-pie-graph"></i>
						</div>
					</div>
				</div>
				<!-- ./col -->
			</div>
			<div class="row">
				<div class="col-md-6">
					<!-- AREA CHART -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">销售订单成单量半年期统计</h3>

							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<div class="chart">
								<canvas id="areaChart" style="height: 250px"></canvas>
							</div>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
				<!-- /.col (LEFT) -->
				<div class="col-md-6">
					<!-- LINE CHART -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">体验订单成单量半年期统计</h3>

							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<div class="chart">
								<canvas id="lineChart" style="height: 250px"></canvas>
							</div>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="box box-primary">
						<div class="box-header with-border">
							<i class="fa fa-bar-chart-o"></i>
							<h3 class="box-title">会员注册量半年期统计</h3>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<div id="bar-chart" style="height: 318px;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="box box-primary">
						<div class="box-header with-border">
							<i class="fa fa-bar-chart-o"></i>
							<h3 class="box-title">货品分类库存占比</h3>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<div id="donut-chart" style="height: 300px;"></div>
							<div id="hover"></div>  
						</div>
					</div>
				</div>
			</div>
		</section>
	 </div>
	 <script src="${ctxStatic }/adminLte/plugins/chartjs/Chart.min.js"></script>
	 <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.min.js"></script>
	 <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.resize.min.js"></script>
	 <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.pie.min.js"></script>
	 <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.categories.min.js"></script>
	 <script type="text/javascript">
	 	$(function(){
			var areaChartCanvas = $("#areaChart").get(0).getContext("2d");
			var areaChart = new Chart(areaChartCanvas);
			var areaChartData = {
			//  labels : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月" ],
			    labels : ${fns:toJson(bLabelArr)},
				datasets : [ {
					label : "Electronics",
					fillColor : "rgba(210, 214, 222, 1)",
					strokeColor : "rgba(210, 214, 222, 1)",
					pointColor : "rgba(210, 214, 222, 1)",
					pointStrokeColor : "#c1c7d1",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(220,220,220,1)",
					data : ${fns:toJson(bDataArr)}
				}
				/* , 
				{
					label : "Digital Goods",
					fillColor : "rgba(60,141,188,0.9)",
					strokeColor : "rgba(60,141,188,0.8)",
					pointColor : "#3b8bba",
					pointStrokeColor : "rgba(60,141,188,1)",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(60,141,188,1)",
					data : [ 28, 48, 40, 19, 86, 27, 90 ]
				}  */
				]
			};

			var areaChartOptions = {
				showScale : true,
				scaleShowGridLines : false,
				scaleGridLineColor : "rgba(0,0,0,.05)",
				scaleGridLineWidth : 1,
				scaleShowHorizontalLines : true,
				scaleShowVerticalLines : true,
				bezierCurve : true,
				bezierCurveTension : 0.3,
				pointDot : false,
				pointDotRadius : 4,
				pointDotStrokeWidth : 1,
				pointHitDetectionRadius : 20,
				datasetStroke : true,
				datasetStrokeWidth : 2,
				datasetFill : true,
// 				legendTemplate : "<ul class=\""+name.toLowerCase()+"-legend\">" for (var i=0; i<datasets.length; i++){+"<li><span style=\"background-color:"+datasets[i].lineColor+"\"></span>"+if(datasets[i].label){"+datasets[i].label}</li>}</ul>",
	 	        maintainAspectRatio: true,
	 	        responsive: true
 	    	};

	 	    areaChart.Line(areaChartData, areaChartOptions);
	 	    
	 	   var lineChartData = {
	 	                labels : ${fns:toJson(eLabelArr)},
	 	                datasets : [ {
	 	                    label : "Electronics",
	 	                    fillColor : "rgba(210, 214, 222, 1)",
	 	                    strokeColor : "rgba(210, 214, 222, 1)",
	 	                    pointColor : "rgba(210, 214, 222, 1)",
	 	                    pointStrokeColor : "#c1c7d1",
	 	                    pointHighlightFill : "#fff",
	 	                    pointHighlightStroke : "rgba(220,220,220,1)",
	 	                    data : ${fns:toJson(eDataArr)}
	 	                } ]
	 	            };
	 	    
	 	    var lineChartCanvas = $("#lineChart").get(0).getContext("2d");
	 	    var lineChart = new Chart(lineChartCanvas);
	 	    var lineChartOptions = areaChartOptions;
	 	    lineChartOptions.datasetFill = false;
	 	    lineChart.Line(lineChartData, lineChartOptions);
	 	    
	 	    /*
	 	     * BAR CHART
	 	     * ---------
	 	     */
	 	    var rgData = ${fns:toJson(memberRegisterData)};
	 	    var str = "[";
	 	    for(var i = 0; i < rgData.length; i++) {
	 	    	str += "[\""+rgData[i].label+"\", "+rgData[i].num+"]";
	 	    	if(i != rgData.length - 1) {
	 	    		str += ",";
	 	    	}
	 	    }
	 	    str += "]";
	 	    var bar_data = {
	 	   // data: [["一月", 10], ["二月", 8], ["三月", 4], ["四月", 13], ["五月", 17], ["六月", 9]],
	 	      data : $.parseJSON(str),
	 	      color: "#3c8dbc",
	 	    };
	 	    $.plot("#bar-chart", [bar_data], {
	 	        grid: {
	 	        borderWidth: 1,
	 	        borderColor: "#f3f3f3",
	 	        tickColor: "#f3f3f3",
	 	        hoverable: true   // 开启 hoverable 事件  
	 	      },
	 	      series: {
	 	        bars: {
	 	          show: true,
	 	          barWidth: 0.5,
	 	          align: "center"
	 	        },
		 	    showMarker: true,
	            pointLabels: { 
	               show: true, 
	            }
	 	      },
	 	      xaxis: {
	 	    	show:true,
	 	    	label:'月份',
	 	        mode: "categories",
	 	        tickLength: 1
	 	      },
	 	      yaxis : {
	 	    	show:true,
	 	        decimal:0,
	 	        label: '人数',
	 	      }  
	 	    });
	 	    /* END BAR CHART */
	 	    
	 	    
	 	     // 节点提示  
	        function showTooltip(x, y, contents) {  
	            $('<div id="tooltip">' + contents + '</div>').css( {  
	                position: 'absolute',  
	                display: 'none',  
	                top: y - 30,  
	                left: x - 40,  
	                padding: '2px',  
	                'background-color': 'white',  
	                opacity: 0.80  
	            }).appendTo("body").fadeIn(200);  
	        }  
	  
	        var previousPoint = null;  
	        // 绑定提示事件  
	        $("#bar-chart").bind("plothover", function (event, pos, item) {  
	            if (item) {  
	                if (previousPoint != item.dataIndex) {  
	                    previousPoint = item.dataIndex;  
	                    $("#tooltip").remove();  
	                    var x = item.datapoint[0].toFixed(0); 
	                    var y = item.datapoint[1].toFixed(0);  
	                    var tip = "总人数：";  
	                    showTooltip(item.pageX, item.pageY,tip+y);  
	                }  
	            }  
	            else {  
	                $("#tooltip").remove();  
	                previousPoint = null;  
	            }  
	        });  
	 	    
	 	   /*
	 	     * DONUT CHART
	 	     * -----------
	 	     */
	 	    /* var donutData = [
	 	      {label: "戒指", data: 10, color: "#3c8dbc"},
	 	      {label: "项链", data: 20, color: "#0073b7"},
	 	      {label: "耳环", data: 30, color: "#00c0ef"}
	 	    ];  */
	 	    var donutData = ${fns:toJson(categoryStockData)}; 
	 	    
	 	    $.plot("#donut-chart", donutData, {
	 	      series: {
	 	        pie: {
	 	          show: true,
	 	        }
	 	      },
	 	      grid: {  
	                hoverable: true,  
	                clickable: true  
	          }
	 	    });
	 	    
	 	    $("#donut-chart").bind("plothover", pieHover);  
	        $("#donut-chart").bind("plotclick", pieClick);  
	 	    
	 	    /*
	 	     * END DONUT CHART
	 	     */
	 	});
	 	
	 	 function pieHover(event, pos, obj)   
	     {  
	         if (!obj)  return;  
	         percent = parseFloat(obj.series.percent).toFixed(2);  
	         $("#hover").html('<span style="font-weight: bold; color: '+obj.series.color+'">'+obj.series.label+' ('+percent+'%)</span>');  
	     }  
	       
	     function pieClick(event, pos, obj)   
	     {  
	         if (!obj)  return;  
	         percent = parseFloat(obj.series.percent).toFixed(2);  
	         ZF.showTip(''+obj.series.label+': '+percent+'%', "info");  
	     }  
	 	  /*
	 	   * Custom Label formatter
	 	   * ----------------------
	 	   */
	 	  function labelFormatter(label, series) {
	 	    return '<div style="font-size:13px; text-align:center; padding:2px; color: #fff; font-weight: 600;">'
	 	        + label
	 	        + "<br>"
	 	        + Math.round(series.percent) + "%</div>";
	 	  }
	 </script>
</body>
</html>