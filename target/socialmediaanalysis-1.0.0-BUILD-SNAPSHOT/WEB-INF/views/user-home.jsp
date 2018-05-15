<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome user</title>
</head>
<body>
	<br>

	<div class="row" style="margin-right: 15px; margin-left: 15px;">
		<div class="panel panel-default">
			<div class="panel-heading">Feed occurrences per week day by hour</div>
			<div class="panel-body">
				<div class="col-xs-12">
					<div id="heatMapContainer"></div>
				</div>
			</div>
		</div>
	</div>
	<div id="becko"></div>

	<div class="row" style="margin-right: 15px; margin-left: 15px;">
		<div class="panel panel-default">
			<div class="panel-heading">Daily and hourly feeds</div>
			<div class="panel-body">
				<div class="col-xs-4">
					<div id="dayContainer"></div>
				</div>
				<div class="col-xs-8">
					<div id="hourContainer"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="row" style="margin-right: 15px; margin-left: 15px;">
		<div class="panel panel-default">
			<div class="panel-heading">Overall feed occurrences</div>
			<div class="panel-body">
				<div class="col-xs-12">
					<div id="overalContainer"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="row" style="margin-right: 15px; margin-left: 15px;">
		<div class="panel panel-default">
			<div class="panel-heading">Feed occurrences per category by date</div>
			<div class="panel-body">
				<div class="col-xs-12">
					<div class="form-inline" style="float: left;">
						<select id="category" class="form-control">
						</select>
						<button class="btn btn-default" onclick="validate()">Submit</button>
					</div>
					<div id="byCategoryChart"></div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="loadingModal" role="dialog" style="display: none; width: auto;">
		<div class="modal-dialog modal-sm">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h5 class="modal-title">Loading, please wait</h5>
				</div>
				<div class="modal-body">
					<img style="display: block; margin: 0 auto;" alt="Loading" src="/resources/img/hourglass.gif">
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$("#loadingModal").modal('show');
			$.ajax({
				type : "GET",
				url : "${home}heat-map",
				success : function(data) {
					$("#loadingModal").modal('hide');
					drawChart(data);
					getDailyChart();
				},
				error : function(e) {
					alert("ERROR");
				},
				done : function(e) {
					alert("DONE");
				}
			});

		});

		function getDailyChart() {
			$.ajax({
				type : "GET",
				url : "${home}week-day",
				success : function(data) {
					drawDailyChart(data);
					getHourlyChart();
				},
				error : function(e) {
					alert("ERROR");
				},
				done : function(e) {
					alert("DONE");
				}
			});
		}

		function getHourlyChart() {
			$.ajax({
				type : "GET",
				url : "${home}day-hour",
				success : function(data) {
					drawHourChart(data);
					getOveralChart();
				},
				error : function(e) {
					alert("ERROR");
				},
				done : function(e) {
					alert("DONE");
				}
			});
		}

		function getOveralChart() {
			$.ajax({
				type : "GET",
				url : "${home}my-categories-stats?userId=${userId}",
				success : function(data) {
					drawOveralCategoryPieChart(data);
				},
				error : function(e) {
					alert("ERROR");
				},
				done : function(e) {
					alert("DONE");
				}
			});
		}

		function drawChart(data) {
			
			Highcharts.chart('heatMapContainer', {

			    chart: {
			        type: 'heatmap',
			        marginTop: 40,
			        marginBottom: 80,
			        plotBorderWidth: 1
			    },


			    title: {
			        text: ''
			    },

			    xAxis: {
			    	categories : [ '00:00', '01:00', '02:00','03:00', '04:00', '05:00', '06:00','07:00', '08:00', '09:00', '10:00','11:00', '12:00', '13:00', '14:00','15:00', '16:00', '17:00', '18:00','19:00', '20:00', '21:00', '22:00','23:00' ]
			    },

			    yAxis: {
			    	categories : [ 'Monday', 'Tuesday','Wednesday', 'Thursday', 'Friday','Saturday', 'Sunday' ],
					title : null
			    },

			    colorAxis: {
			    	min : 0,
					minColor : '#FFFFFF',
					maxColor : '#FF0000'
			    },

			    legend: {
			        align : 'right',
					layout : 'vertical',
					margin : 0,
					verticalAlign : 'top',
					y : 25,
					symbolHeight : 280
			    },

			    tooltip: {
			        formatter: function () {
			            return '<b>' + this.series.xAxis.categories[this.point.x] + '</b> sold <br><b>' +
			                this.point.value + '</b> items on <br><b>' + this.series.yAxis.categories[this.point.y] + '</b>';
			        }
			    },

			    series: [{
			        name: 'Day - Hour heat map',
			        borderWidth: 1,
			        data: [[0,0,362],[0,1,199],[0,2,220],[0,3,191],[0,4,291],[0,5,291],[0,6,282],[1,0,217],[1,1,137],[1,2,140],[1,3,118],[1,4,141],[1,5,153],[1,6,185],[2,0,146],[2,1,90],[2,2,119],[2,3,84],[2,4,127],[2,5,149],[2,6,112],[3,0,158],[3,1,114],[3,2,147],[3,3,119],[3,4,194],[3,5,189],[3,6,170],[4,0,230],[4,1,216],[4,2,342],[4,3,267],[4,4,382],[4,5,405],[4,6,294],[5,0,524],[5,1,435],[5,2,635],[5,3,540],[5,4,783],[5,5,764],[5,6,627],[6,0,949],[6,1,719],[6,2,838],[6,3,756],[6,4,1118],[6,5,1161],[6,6,1042],[7,0,1354],[7,1,899],[7,2,1018],[7,3,896],[7,4,1218],[7,5,1270],[7,6,1115],[8,0,1458],[8,1,999],[8,2,1274],[8,3,994],[8,4,1261],[8,5,1292],[8,6,1183],[9,0,1626],[9,1,992],[9,2,1293],[9,3,1085],[9,4,1359],[9,5,1474],[9,6,1450],[10,0,1631],[10,1,1170],[10,2,1201],[10,3,1164],[10,4,1574],[10,5,1550],[10,6,1420],[11,0,1673],[11,1,1287],[11,2,1189],[11,3,1084],[11,4,1824],[11,5,1555],[11,6,1629],[12,0,1555],[12,1,1175],[12,2,1266],[12,3,1467],[12,4,1969],[12,5,1521],[12,6,1539],[13,0,1391],[13,1,1328],[13,2,1373],[13,3,1400],[13,4,1730],[13,5,1657],[13,6,1780],[14,0,1611],[14,1,1235],[14,2,1562],[14,3,1462],[14,4,1780],[14,5,1985],[14,6,1495],[15,0,1392],[15,1,1468],[15,2,1539],[15,3,1464],[15,4,1876],[15,5,1568],[15,6,1377],[16,0,1222],[16,1,1492],[16,2,1560],[16,3,1696],[16,4,1693],[16,5,1643],[16,6,1529],[17,0,1308],[17,1,1538],[17,2,1711],[17,3,1831],[17,4,1953],[17,5,2125],[17,6,1767],[18,0,1687],[18,1,1906],[18,2,1705],[18,3,2084],[18,4,1916],[18,5,2109],[18,6,1779],[19,0,1762],[19,1,1901],[19,2,1872],[19,3,3333],[19,4,2140],[19,5,2378],[19,6,2310],[20,0,1681],[20,1,2016],[20,2,1656],[20,3,2806],[20,4,2347],[20,5,2088],[20,6,2289],[21,0,1284],[21,1,1567],[21,2,1221],[21,3,1909],[21,4,1735],[21,5,1536],[21,6,1894],[22,0,696],[22,1,897],[22,2,717],[22,3,1027],[22,4,914],[22,5,896],[22,6,1515],[23,0,355],[23,1,447],[23,2,353],[23,3,505],[23,4,460],[23,5,522],[23,6,755]],
			        dataLabels: {
			            enabled: true,
			            color: '#000000'
			        }
			    }]

			});
		}

		function drawDailyChart(data) {
			$('#dayContainer')
					.highcharts(
							{
								chart : {
									type : 'bar'
								},
								title : {
									text : ''
								},
								subtitle : {
									text : ''
								},
								xAxis : {
									categories : [ 'Monday', 'Tuesday',
											'Wendesday', 'Thursday', 'Fridey',
											'Saturday', 'Sunday' ],
									title : {
										text : 'Week day',
										align : 'middle'
									}
								},
								yAxis : {
									min : 0,
									title : {
										text : 'Number of feeds',
										align : 'middle'
									},
									labels : {
										overflow : 'justify'
									}
								},
								tooltip : {
									valueSuffix : 'occurences'
								},
								plotOptions : {
									bar : {
										dataLabels : {
											enabled : true
										}
									}
								},
								credits : {
									enabled : false
								},
								series : [ {
									name : 'Feeds',
									color : '#1C526B',
									data : data
								} ]
							});
		}

		function drawHourChart(data) {
			$(function() {
				$('#hourContainer').highcharts(
						{
							chart : {
								type : 'spline'
							},
							title : {
								text : ''
							},
							subtitle : {
								text : ''
							},
							xAxis : {
								categories : [ '00:00', '1:00', '2:00', '3:00',
										'4:00', '5:00', '6:00', '7:00', '8:00',
										'9:00', '10:00', '11:00', '12:00',
										'13:00', '14:00', '15:00', '16:00',
										'17:00', '18:00', '19:00', '20:00',
										'21:00', '22:00', '23:00' ]
							},
							yAxis : {
								title : {
									text : 'Number of feeds'
								}
							},
							plotOptions : {
								line : {
									dataLabels : {
										enabled : true
									},
									enableMouseTracking : false
								}
							},
							series : [ {
								name : 'Feeds',
								color : '#003399',
								data : data
							} ]
						});
			});
		}

		function drawOveralCategoryPieChart(data) {
			$('#overalContainer')
					.highcharts(
							{
								chart : {
									plotBackgroundColor : null,
									plotBorderWidth : null,
									plotShadow : false,
									type : 'pie'
								},
								title : {
									text : ''
								},
								tooltip : {
									pointFormat : '<b>{point.name}</b>: {point.y} occurrences'
								},
								plotOptions : {
									pie : {
										allowPointSelect : true,
										cursor : 'pointer',
										dataLabels : {
											enabled : true,
											format : '<b>{point.name}</b>: {point.percentage:.1f} %',
											style : {
												color : (Highcharts.theme && Highcharts.theme.contrastTextColor)
														|| 'black'
											}
										}
									}
								},
								series : [ {
									name : 'Categories',
									colorByPoint : true,
									data : data
								} ]
							});
		}

		$(function() {
			$.ajax({
				type : "GET",
				url : "${home}get-categories?userId=${userId}",
				success : function(data) {
					console.log(JSON.stringify(data));
					populateDropdown(data);
				},
				error : function(e) {
					alert("ERROR");
				},
				done : function(e) {
					alert("DONE");
				}
			});
		});

		function populateDropdown(data) {
			var select = document.getElementById("category");

			for (var i = 0; i < data.length; i++) {
				var opt = data[i];
				select.innerHTML += "<option id=" + data[i].id +" value=" + data[i].id + ">"
						+ data[i].name + "</option>";
			}
			validate();
		}

		function validate() {
			var category = document.getElementById("category");

			if (category.value == "") {
				category.style.borderColor = 'red';
			} else {
				category.style.borderColor = 'default';
				$.ajax({
					type : "GET",
					url : "${home}date-stats?userId=${userId}&categoryId="
							+ category.value,
					success : function(data) {
						console.log(JSON.stringify(data));
						drawByCategoryChart(data);
					},
					error : function(e) {
						alert("ERROR");
					},
					done : function(e) {
						alert("DONE");
					}
				});
			}
		}

		function drawByCategoryChart(data) {
			$(function() {
				// Create the chart
				$('#byCategoryChart')
						.highcharts(
								{
									chart : {
										type : 'column',
										zoomType : 'x'
									},
									title : {
										text : 'Statistics by date'
									},
									subtitle : {
										text : 'Click and drag in the plot area to zoom in'
									},
									xAxis : {
										type : 'category'
									},
									yAxis : {
										title : {
											text : 'Occurences per day'
										}

									},
									legend : {
										enabled : false
									},
									plotOptions : {
										series : {
											borderWidth : 0,
											dataLabels : {
												enabled : true,
												format : '<b>{point.y}</b>'
											}
										}
									},

									tooltip : {
										pointFormat : '{point.name}: <b>{point.y} occurences</b>'
									},

									series : [ {
										name : 'Category',
										colorByPoint : true,
										data : data
									} ],
								});
			});
		}
	</script>
</body>

</html>