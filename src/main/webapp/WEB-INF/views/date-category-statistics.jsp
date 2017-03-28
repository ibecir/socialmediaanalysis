<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<div class="form-inline" style="float: left; margin-left: 200px;">
	<select id="category" class="form-control" style="width: auto;">
		<option id="empty" value=""></option>
	</select>
	<button class="btn btn-default" onclick="validate()">Submit</button>
</div>

<div id="container" style="min-width: 400px; max-width: 900px; height: 400px; margin: 0 auto"></div>

<script>

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

function populateDropdown(data){
	var select = document.getElementById("category"); 

	for(var i = 0; i < data.length; i++) {
	    var opt = data[i];
	    select.innerHTML += "<option id=" + data[i].id +" value=" + data[i].id + ">" + data[i].name + "</option>";
	}
}

function validate(){
	var category = document.getElementById("category");

	if(category.value == ""){
		category.style.borderColor = 'red';
	}
	else{
		category.style.borderColor = 'default';
		$.ajax({
			type : "GET",
			url : "${home}date-stats?userId=${userId}&categoryId=" + category.value,
			success : function(data) {
				console.log(JSON.stringify(data));
				drawChart(data);
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

function drawChart(data){
	$(function () {
	    // Create the chart
	    $('#container').highcharts({
	        chart: {
	            type: 'column'
	        },
	        title: {
	            text: 'Statistics by date'
	        },
	        xAxis: {
	            type: 'category'
	        },
	        yAxis: {
	            title: {
	                text: 'Occurences per day'
	            }

	        },
	        legend: {
	            enabled: false
	        },
	        plotOptions: {
	            series: {
	                borderWidth: 0,
	                dataLabels: {
	                    enabled: true,
	                    format: '<b>{point.y}</b>'
	                }
	            }
	        },

	        tooltip: {
	        	pointFormat: '{point.name}: <b>{point.y} occurences</b>'
	        },

	        series: [{
	            name: 'Category',
	            colorByPoint: true,
	            data: data
	        }],
	    });
	});
}

</script>

</body>
</html>