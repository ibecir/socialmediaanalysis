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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">


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
        		<ul class="dropdown-menu active" id="manageCategoriesDropdown">
        			<li id="deletedCategories"><a href="${baseURL}deleted-categories?baseURL=${baseURL}&username=${username}&userId=${userId}">Deleted Categories</a></li>
        			<li class="active" id="activeCategories"><a>Manage Categories</a></li>
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
	<button id="category" class="btn btn-info btn-sm" data-toggle="modal" data-target="#categories">
		<span class="glyphicon glyphicon-plus-sign"></span> 
		Add Category
		</button>
		<table class="table table-bordered table-hover" id="categoryTable">
			<thead>
				<tr>
					<th><center>Name</center></th>
				</tr>
			</thead>
		</table>
</div>

	<div class="modal fade normal" id="categories" name="categories" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<form:form method="post" name="addCategory" id="addCategory">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Add Categories</h4>
					</div>
					<div class="modal-body">
						<div class="category-block">
							<div class="form-group">
								<label for="category">Title</label> <textarea rows="4" cols="70" placeholder="To add more than one category separate each one by comma. Ex: First,Second"
									class="form-control" id="categoryName" name="categoryName"
									required="required"></textarea>
							</div>
							<div style="color: red">${error}</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-info" id="btnAddCategory"
								name="btnAddCategory">Save</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>

				</div>
			</form:form>
		</div>

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
						Are you sure you want to delete this category?
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
		
	<div class="modal fade" id="changeCategoryNameModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<form:form method="post" name="changeCategoryNameForm" id="changeCategoryNameForm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<div class="category-block">
							<div class="form-group">
								<input type="text" class="form-control" id="newCategoryName"
								placeholder="Please enter new name for category" required="required">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-info" id="btnSaveCategory"
								name="btnSaveCategory">Save</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</form:form>
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
				url : "${home}activecategories?userId=" + $("#userID").text(),
				timeout : 100000,
				success : function(data) {
					var trHTML = '';
					$.each(data, function(i, value) {
						for (var j = 0; j < value.length; j++) {
							for(var i = 0; i < value[j].categories.length; i++){
								trHTML += '<tr><td><a href="${baseURL}category-keywords?userId=${userId}&username=${username}&categoryId='+value[j].categories[i].categoryId+'&categoryName='+value[j].categories[i].categoryName+'" class="title">' + value[j].categories[i].categoryName + '</a>'
								+ '</td><td><center><a data-toggle="modal" data-target="#deleteCategoryModal" href="" onclick="deleteCategory(\''+value[j].categories[i].categoryId+'\')" id ="dcat" class="glyphicon glyphicon-trash"></a></center>'
								+ '</td><td class="cat">' + value[j].categories[i].categoryId
								+ '</td><td><center><a data-toggle="modal" data-target="#changeCategoryNameModal" class="glyphicon glyphicon-edit" href="" onClick="changeCategoryName(this,\''+value[j].categories[i].categoryId+'\')"></a></center>'
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
		
		jQuery(document).ready(function($) {
			$("#manageCategoriesDropdown li").click(function(){
			    if(this.id == "deletedCategories"){
			    	populateTableDeletedCategories();
			    }
			    else{
			    	populateTable();
			    }
			});
		});

		jQuery(document).ready(function($) {
			$("#addCategory").submit(function(categoryEvent) {
				categoryEvent.preventDefault();
				addcategories();
			});
			
			$("#btnSaveCategory").submit(function(categoryEvent) {
				categoryEvent.preventDefault();
				changeCategoryName(elem, id)();
			});
		});
		
		function changeCategoryName(elem,id){
			var categoryHeadertitle= $(elem).closest("tr").find("a.title").html();
			var categoryId= $(elem).closest("tr").find("td.cat").html();
			alert(categoryId);
			$( "#changeCategoryNameModal" ).find('.modal-title').html('Please enter new name for <b>' + categoryHeadertitle + '</b> category');
			$("#btnSaveCategory").click(function(categoryEvent) {
				var categoryName = document.getElementById("newCategoryName").value;
				categoryEvent.preventDefault();
				$.ajax({
					type : "POST",
					url : "${home}categoryName?categoryId=" + categoryId + "&categoryName=" + categoryName,
					timeout : 100000,
					success : function(data) {
						console.log("SUCCESS: ", data);
						$('#changeCategoryNameModal').modal('hide');
						location.reload();
						$("#changeCategoryNameModal").trigger('reset');
					},
					error : function(e) {
						console.log("ERROR: ", e);
						alert("ERROR");
					},
					done : function(e) {
						alert("DONE");
						console.log("DONE");
					}
				});
			});
		}
		
		function deleteCategory(id){
			$("#delCategory").click(function(){
				if (this.id == 'delCategory') {
				$.ajax({
					type : "POST",
					url : "${home}deleteCategory?categoryId=" + id,
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
	}

		function addcategories() {
			var userId = $("#userID").text();
			var categoryName = $("#categoryName").val();
			$.ajax({
				type : "POST",
				url : "${home}addcategory?userId=" + userId + "&categoryName=" + categoryName,
				timeout : 100000,
				success : function(data) {
					console.log("SUCCESS: ", data);
					$('#categories').modal('hide');
					populateTable();
					$("#addCategory").trigger('reset');
				},
				error : function(e) {
					console.log("ERROR: ", e);
					alert("ERROR");
				},
				done : function(e) {
					alert("DONE");
					console.log("DONE");
				}
			});
		}

	</script>


</body>
</html>