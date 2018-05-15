<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
								<!-- Main Table -->

<div class="tocenter">
	<button style="float: right;" id="btnPage" class="btn btn-info btn-sm" data-toggle="modal" data-target="#dataSourcesModal">
		<span class="glyphicon glyphicon-plus-sign"></span> 
		Add Page
		</button>
	<div class="btn-group">
  		<button class="btn btn-primary btn-sm">Facebook</button>
    	<button onclick="populateTableWithActiveFacebookPages()" type="button" class="btn btn-success btn-sm">Active Pages</button>
    	<button onclick="populateTableWithDeletedFacebookPages()" type="button" class="btn btn-danger btn-sm">Deleted Pages</button>
 	</div>
		<table class="table table-bordered table-hover" id="dataSourceTable">
			<thead>
				<tr>
					<th style="margin: 0 auto;">Page Name</th>
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
				alert("You have succesefully added new page.");
			},
			error : function(e) {
				console.log("ERROR: ", e.responseText);
				alert("URL that you have entered does not represent a real page. Please go to home page of portal you want to follow and enter URL in form\nwww.facebook.com/pageyouwanttoadd");
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
</script>

</body>
</html>