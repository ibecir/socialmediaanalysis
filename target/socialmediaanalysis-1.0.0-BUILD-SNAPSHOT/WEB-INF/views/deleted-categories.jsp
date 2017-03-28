<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Social Media Analysis</title>
	
<script src="<c:url value="/resources/js/jquery.min.js" />"></script>
<link href="<c:url value="/resources/css/navigation-bar.css" />" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/manage-categories.css" />" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/fonts/montserrat.css" />" rel="stylesheet" type="text/css">
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-default">
  	<div class="container-fluid">
    	<div class="navbar-header">
      		<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-user"></span> Welcome <b>${username}</b></a>
    		<p id="userID" hidden>${userId}</p>
    	</div>
    	<div>
      		<ul class="nav navbar-nav">
        		<li ><a href="${baseURL}home"><span class="glyphicon glyphicon-home"></span> Home</a></li>
        		<li class="dropdown">
        		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span> Manage Categories <span class="caret"></span></a>
        		<ul class="dropdown-menu">
        			<li class="active"><a href="${baseURL}deleted-categories">Deleted Categories</a></li>
        			<li ><a href="${baseURL}active-categories?baseURL=${baseURL}&username=${username}&userId=${userId}">Manage Categories</a></li>
        		</ul>
        		</li>
        		<li><a href="${baseURL}my-categories"><span class="glyphicon glyphicon-signal"></span> My Categories</a></li>
      			<li><a href="${baseURL}datasources?baseURL=${baseURL}&username=${username}&userId=${userId}"><span class="glyphicon glyphicon-cloud"></span> My Pages</a></li>
      		</ul>
      		<ul class="nav navbar-nav navbar-right">
      			<li><a href="#"><span class="glyphicon glyphicon-off"></span> Sign Out</a></li>
      		</ul>
    	</div>
  	</div>
</nav>
	
	<div class="tocenter">
		<table class="table table-bordered table-hover" id="categoryTable">
			<thead>
				<tr>
					<th><center>Name</center></th>
					<th><center>Restore</center></th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div class="modal fade" id="deleteCategoryModal" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Delete</h4>
					</div>
					<div class="modal-body">
						Are you sure you want to restore this category?
					</div>
					
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-default" id="delCategory"
								name="delCategory">Yes</button>
							<button type="button" class="btn btn-danger"
								data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>

	<script type="text/javascript">
		$(document).ready(function(){
			populateTable();
			});
		
		function populateTable() {
			$("#categoryTable > tbody").html("");
			$.ajax({
				type : "GET",
				url : "${home}deletedcategories?userId=" + $("#userID").text(),
				timeout : 100000,
				success : function(data) {
					var trHTML = '';
					$.each(data, function(i, value) {
						for (var j = 0; j < value.length; j++) {
							for(var i = 0; i < value[j].categories.length; i++){
								trHTML += '<tr><td>' + value[j].categories[i].categoryName
								+ '</td><td><center><a title="Restore" data-toggle="modal" data-target="#deleteCategoryModal" onclick="restoreCategory(\''+value[j].categories[i].categoryId+'\')" id ="dcat" class="glyphicon glyphicon-ok"></a></center>'
								+ '</td></tr>';
							}
						}
					});
					$('#categoryTable').append(trHTML);
				},
				error : function(e) {
					console.log("ERROR: ", e);
					display(e);
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}
		
		function restoreCategory(id){
			$("#delCategory").click(function(){
				if (this.id == 'delCategory') {
				$.ajax({
					type : "POST",
					url : "${home}restoreCategory?categoryId=" + id,
					timeout : 100000,
					success : function(data) {
					$('#deleteCategoryModal').modal('hide');
					location.reload();
					},
					error : function(e) {
						console.log("ERROR: ", e);
					},
					done : function(e) {
						alert("DONE");
					}
				});
			}
		});
	};

	</script>


</body>
</html>