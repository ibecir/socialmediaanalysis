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

								<!-- Navigation Bar -->
							
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
        			<ul class="dropdown-menu" id="manageCategoriesDropdown">
        				<li id="deletedCategories"><a href="${baseURL}deleted-categories?baseURL=${baseURL}&username=${username}&userId=${userId}">Deleted Categories</a></li>
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

								<!-- Main Table -->

<div class="tocenter">
	<button style="float: right;" id="btnPage" class="btn btn-info btn-sm" data-toggle="modal" data-target="#dataSourcesModal">
		<span class="glyphicon glyphicon-plus-sign"></span> 
		Add Page
		</button>
	<div class="btn-group">
		<button id="dropDownButton" class="btn btn-info btn-sm dropdown-toggle" type="button" data-toggle="dropdown">Facebook <span class="caret"></span></button>
  			<ul class="dropdown-menu" id="dataSourceDropdown">
    			<li id="fb"><a href="#">Facebook</a></li>
    			<li id="tw"><a href="#">Twitter</a></li>
  			</ul>
    	<button onclick="populateTableWithActiveFacebookPages()" type="button" class="btn btn-success btn-sm">Active Pages</button>
    	<button onclick="populateTableWithDeletedFacebookPages()" type="button" class="btn btn-danger btn-sm">Deleted Pages</button>
 	</div>
		<table class="table table-bordered table-hover" id="dataSourceTable">
			<thead>
				<tr>
					<th><center>Page Name</center></th>
				</tr>
			</thead>
		</table>
</div>

							<!-- Add New Page Modal -->
							
	<div class="modal fade normal" id="dataSourcesModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<form:form method="post" name="addPageForm" id="addPageForm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Add New Page</h4>
					</div>
					<div class="modal-body">
						<div class="category-block">
							<div class="form-group">
								<label for="page">Title</label> <textarea rows="4" cols="70" placeholder="Enter URL of home page
								https://www.facebook.com/interestingengineering/" class="form-control" id="page" required="required"></textarea>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-info" id="btnAddPage" >Save</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>

				</div>
			</form:form>
		</div>
	</div>
	
								<!-- Delete Page Modal -->
	
	<div class="modal fade" id="deletePageModal" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Delete</h4>
					</div>
					<div class="modal-body">
						Are you sure you want to delete this page?
					</div>
					
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-default" id="btnDeletePage">Yes</button>
							<button type="button" class="btn btn-danger"data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
						<!-- Restore Page Modal -->
	
	<div class="modal fade" id="restorePageModal" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Delete</h4>
					</div>
					<div class="modal-body">
						Are you sure you want to restore this page?
					</div>
					
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-default" id="btnRestorePage">Yes</button>
							<button type="button" class="btn btn-danger"data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>

<script type="text/javascript">

	$( document ).ready(function() {
		populateTableWithActiveFacebookPages();
	});

	jQuery(document).ready(function($) {
		$("#addPageForm").submit(function(pageEvent) {
			pageEvent.preventDefault();
			addPage();
		});
	});
	
	function populateTableWithActiveFacebookPages(){
		$.ajax({
			type : "GET",
			url : "${home}facebookpages?userId=${userId}",
			timeout : 100000,
			success : function(data) {
				var trHTML = '';
					for (var j = 0; j < data.length; j++) {
						for(var i = 0; i < data[j].facebookPages.length; i++){
							trHTML += '<tr><td>' + data[j].facebookPages[i].name 
							+ '</td><td><center><a data-toggle="modal" data-target="#deletePageModal" href="" onclick="deletePage(\''+data[j].facebookPages[i].pageId +'\')" id ="deletePageTable" class="glyphicon glyphicon-trash"></a></center>'
							+ '</td></tr>';
						}
				}
				$("#dataSourceTable > tbody").html("");
				$('#dataSourceTable').append(trHTML);
			},
			error : function(e) {
				console.log("ERROR: ", e);
			},
			done : function(e) {
				console.log("DONE");
			}
		});
	}
	
	function populateTableWithDeletedFacebookPages(){
		
		$.ajax({
			type : "GET",
			url : "${home}deletedfacebookpages?userId=${userId}",
			timeout : 100000,
			success : function(data) {
				var trHTML = '';
					for (var j = 0; j < data.length; j++) {
						for(var i = 0; i < data[j].facebookPages.length; i++){
							trHTML += '<tr><td>' + data[j].facebookPages[i].name 
							+ '</td><td><center><a href="#" title="Restore" data-toggle="modal" data-target="#restorePageModal" onclick="restorePage(\''+data[j].facebookPages[i].pageId+'\')" class="glyphicon glyphicon-ok"></a></center>'
							+ '</td></tr>';
						}
				}
				$("#dataSourceTable > tbody").html("");
				$('#dataSourceTable').append(trHTML);
			},
			error : function(e) {
				console.log("ERROR: ", e);
			},
			done : function(e) {
				console.log("DONE");
			}
		});
	}
	
	function addPage(){
		var pageUrl = $("#page").val();
		$.ajax({
			type : "POST",
			url : "${home}addfacebookpage?userId=${userId}&pageUrl=" + pageUrl,
			timeout : 100000,
			success : function(data) {
				console.log("SUCCESS: ", data);
				$('#dataSourcesModal').modal('hide');
				$("#dataSourcesModal").trigger('reset');
				populateTableWithActiveFacebookPages();
				alert(data);
			},
			error : function(e) {
				console.log("ERROR: ", e.responseText);
				alert(e.responseText);
			},
			done : function(e) {
				alert("DONE");
				console.log("DONE");
			}
		});
	}
	
	function deletePage(id){
		$("#btnDeletePage").click(function(){
			if (this.id == 'btnDeletePage') {
			$.ajax({
				type : "POST",
				url : "${home}deletefbpage?userId=${userId}&pageId=" + id,
				timeout : 100000,
				success : function(data) {
				$('#deletePageModal').modal('hide');
				populateTableWithActiveFacebookPages();
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
	
	function restorePage(id){
		$("#btnRestorePage").click(function(){
			if (this.id == 'btnRestorePage') {
			$.ajax({
				type : "POST",
				url : "${home}restorefbpage?userId=${userId}&pageId=" + id,
				timeout : 100000,
				success : function(data) {
				$('#restorePageModal').modal('hide');
				populateTableWithDeletedFacebookPages();
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
	
	$(function() {
	    $("#dataSourceDropdown").on("click", function() {
	        var id = this.id;
	    });
	    $("#dataSourceDropdown").on("click", "li a", function() {
	        var pageName = this.innerHTML;
	        $("#dropDownButton").text(pageName);
	    });
	});

</script>

</body>
</html>