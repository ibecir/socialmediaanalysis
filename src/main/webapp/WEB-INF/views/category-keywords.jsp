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
									<!-- Table -->
<div class="tocenter">
	<button style="float: right;" id="btnkeyword" class="btn btn-info btn-sm" data-toggle="modal" data-target="#addKeywordsModal">
		<span class="glyphicon glyphicon-plus-sign"></span> 
		Add Keyword
		</button>
	<div class="btn-group">
    	<button onclick="populateTableActiveKeywords()" type="button" class="btn btn-success btn-sm">Active Keywords</button>
    	<button onclick="populateTableDeletedKeywords()" type="button" class="btn btn-danger btn-sm">Deleted Keywords</button>
 	</div>
		<table class="table table-bordered table-hover" id="keywordTable">
			<thead>
				<tr>
					<th style="margin: 0 auto;"><b>${categoryName}</b> category</th>
				</tr>
			</thead>
		</table>
</div>

								<!-- Add Keyword Modal -->
								
	<div class="modal fade" id="addKeywordsModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Add Keywords</h4>
					</div>
					<div class="modal-body">
							<div class="form-group">
								<label for="addKeywordsTxtArea">Title</label> 
								<textarea rows="4" cols="70" placeholder="To add more than one keyword separate each one by comma. Ex: First,Second"
										  class="form-control" id="addKeywordsTxtArea" required="required"></textarea>
							</div>
							<div style="color: red">${error}</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<button type="button" class="btn btn-info" id="btnAddKeyword" onclick="addkeywords();">Save</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div></div>
		</div>
	</div>
	
									<!-- Delete Keyword Modal -->
	
	<div class="modal fade" id="deleteKeywordModal" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Delete keyword</h4>
					</div>
					<div class="modal-body">
						Are you sure you want to delete this keyword?
					</div>
					
					<div class="modal-footer">
						<div class="btn-group">
							<button type="button" class="btn btn-default" id="btnDeleteKategory" onclick="delKeyword();">Yes</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
								<!-- Restore Keyword Modal -->
								
	<div class="modal fade" id="restoreKeywordModal" role="dialog">
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
							<button type="button" class="btn btn-default" id="btnRestoreKeyword" onclick="restKeyword();">Yes</button>
							<button type="button" class="btn btn-danger"data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
	</div>
	
							<!-- Change Keyword Name Modal -->
							
<div class="modal fade topmoved" id="changeKeywordNameModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input type="text" class="form-control" id="newKeywordName" placeholder="Please enter new name for category" required="required">
                </div>
            </div>
            <div class="modal-footer">
                <div class="btn-group">
                    <button type="button" class="btn btn-info" id="btnSaveNewKeywordName" onclick="chName();">Save</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
							<!-- Manage Synonyms of Keyword | Main Synonyms Table -->
							
	<div class="modal fade" id="mainKeywordSynoymsModal" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<div>
						<div class="keyId" id="keyId" style="display: none;"></div>
						<div id="buttonsDiv" >
							
 						</div>
							<table class="table table-bordered table-hover" id="mainSynonymsTable">
								<thead>
									<tr>
										<th>Name</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
					
					<div class="modal-footer">
						<div class="btn-group">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
									<!-- Add Synonyms Modal -->
	
		<div class="modal fade" id="addSynonymsModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<form:form method="post" id="addSynonymsForm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Add Synonyms</h4>
					</div>
					<div class="modal-body">
							<div class="form-group">
								<label for="synonyms">Title</label> 
								<textarea rows="4" cols="70" placeholder="To add more than one synonyms separate each one by comma. Ex: First,Second"
										  class="form-control" id="synonyms" required="required"></textarea>
							</div>
							<div style="color: red">${error}</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-info" id="btnAddSynonymModa">Save</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div></div>
			</form:form>
		</div>
	</div>
	
								<!-- Delete Synonym Modal -->
								
		<div class="modal fade" id="deleteSynonymModal" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Delete synonyms</h4>
					</div>
					<div class="modal-body">
						Are you sure you want to delete this synonym?
					</div>
					
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-default" id="btnDeleteSynonym">Yes</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
							<!-- Restore Synonym Modal -->
								
		<div class="modal fade" id="restoreSynonymModal" role="dialog">
		<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Restore synonyms</h4>
					</div>
					<div class="modal-body">
						Are you sure you want to restore this synonyms?
					</div>
					
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-default" id="btnRestoreSynonym">Yes</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
							<!-- Change Synonym Name Modal -->
							
	<div class="modal fade" id="changeSynonymNameModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<div class="category-block">
							<div class="form-group">
								<input type="text" class="form-control" id="newSynonymName" placeholder="Please enter new name for synonym" required="required">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="btn-group">
							<button type="submit" class="btn btn-info" id="btnNewSynonymName" >Save</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
		</div>
	</div>
	
	<div style="display: none;" id="kidH"></div>
	<div style="display: none;" id="kidH"></div>
			
	<script type="text/javascript">
		$(document).ready(function(){
			populateTableActiveKeywords();
			});
		
		function populateTableActiveKeywords() {
			
			var addBtn = document.getElementById('btnkeyword');
			addBtn.style.display = 'block';
			
			$.ajax({
				type : "GET",
				url : "${home}keywords?userId=" + $("#userID").text() + "&categoryId=${categoryId}",
				timeout : 100000,
				success : function(data) {
					var trHTML = '';
					$.each(data, function(i, value) {
						for (var j = 0; j < value.length; j++) {
							for(var i = 0; i < value[j].categories.length; i++){
								for(var k = 0; k < value[j].categories[i].keywords.length; k++)
								
								trHTML += 	'<tr><td><a class="keywordTitle" data-toggle="modal" data-target="#mainKeywordSynoymsModal" onClick="populateTableActiveSynonyms(this,\''+value[j].categories[i].keywords[k].keywordId+'\')" id="kewywordSynonyms" href="#">' + value[j].categories[i].keywords[k].keywordName
								+ '</a></td><td><center><a data-toggle="modal" data-target="#deleteKeywordModal" href="" onclick="deleteKeyword(\''+value[j].categories[i].keywords[k].keywordId+'\')" id ="deletekeywordtabel" class="glyphicon glyphicon-trash"></a></center>'
								+ '</td><td><center><a data-toggle="modal" data-target="#changeKeywordNameModal" class="glyphicon glyphicon-edit" href="" onClick="changeKeywordName(this,\''+value[j].categories[i].keywords[k].keywordId+'\')"></a></center>'
								+ '</td><td class="hiddenKeywordId">' + value[j].categories[i].keywords[k].keywordId
								+ '</td></tr>';
								
							}
						}
					});
					$("#keywordTable > tbody").html("");
					$('#keywordTable').append(trHTML);
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
		
		function populateTableDeletedKeywords() {
			
			var addBtn = document.getElementById('btnkeyword');
			addBtn.style.display = 'none';
			
			$.ajax({
				type : "GET",
				url : "${home}deletedkeywords?userId=" + $("#userID").text() + "&categoryId=${categoryId}",
				timeout : 100000,
				success : function(data) {
					var trHTML = '';
					$.each(data, function(i, value) {
						for (var j = 0; j < value.length; j++) {
							for(var i = 0; i < value[j].categories.length; i++){
								for(var k = 0; k < value[j].categories[i].keywords.length; k++)
								trHTML += 	'<tr><td>' + value[j].categories[i].keywords[k].keywordName
								+ '</td><td><center><a href="#" title="Restore" data-toggle="modal" data-target="#restoreKeywordModal" onclick="restoreKeyword(\''+value[j].categories[i].keywords[k].keywordId+'\')" class="glyphicon glyphicon-ok"></a></center>'
								+ '</td></tr>';
							}
						}
					});
					$("#keywordTable > tbody").html("");
					$('#keywordTable').append(trHTML);
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
			$("#addSynonymsForm").submit(function(synonymEvent) {
				synonymEvent.preventDefault();
				addsynonyms();
			});
			
		});
		
		function addkeywords() {
			var userId = $("#userID").text();
			var keywords = $("#addKeywordsTxtArea").val();
			$.ajax({
				type : "POST",
				url : "${home}addkeywords?userId=" + userId + "&categoryId=" + "${categoryId}" +"&keywords="+keywords,
				timeout : 100000,
				success : function(data) {
					console.log("SUCCESS: ", data);
					$('#addKeywordsModal').modal('hide');
					populateTableActiveKeywords();
					document.getElementById("addKeywordsTxtArea").value = "";
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
		
		function deleteKeyword(id){
			document.getElementById("kidH").innerHtml = id;
		}
		
		function delKeyword(){
			keywordId = document.getElementById("kidH").innerHtml;
			$.ajax({
				type : "POST",
				url : "${home}deletekeyword?userId=${userId}&categoryId=${categoryId}&keywordId=" + keywordId,
				timeout : 100000,
				success : function(data) {
				$('#deleteKeywordModal').modal('hide');
				populateTableActiveKeywords();
				},
				error : function(e) {
					console.log("ERROR: ", e);
				},
				done : function(e) {
					alert("DONE");
					}
				});
		}
		
		function restoreKeyword(id){
			document.getElementById("kidH").innerHtml = id;
		};
		
		function restKeyword(){
			id = document.getElementById("kidH").innerHtml;
			
			$.ajax({
				type : "POST",
				url : "${home}restoreKeyword?userId=${userId}&categoryId=${categoryId}&keywordId=" + id,
				timeout : 100000,
				success : function(data) {
					$('#restoreKeywordModal').modal('hide');
					populateTableDeletedKeywords();
				},
				error : function(e) {
					console.log("ERROR: ", e);
				},
				done : function(e) {
					alert("DONE");
					}
				});
		}
		
		function changeKeywordName(elem,id){
			var keywordHeadertitle= $(elem).closest("tr").find("a.keywordTitle").html();
			var keywordId= $(elem).closest("tr").find("td.hiddenKeywordId").html();
			$( "#changeKeywordNameModal" ).find('.modal-title').html('Please enter new name for <b>' + keywordHeadertitle + '</b> keyword');
			document.getElementById("kidH").innerHtml = keywordId;
		}
		
		
		function chName(){
			keywordId = document.getElementById("kidH").innerHtml;
			var keywordNewName = document.getElementById("newKeywordName").value;
			$.ajax({
				type : "POST",
				url : "${home}keywordName?categoryId=${categoryId}&keywordId=" + keywordId + "&keywordName=" + keywordNewName,
				timeout : 100000,
				success : function(data) {
					console.log("SUCCESS: ", data);
					$('#changeKeywordNameModal').modal('hide');
					populateTableActiveKeywords();
					$("#changeKeywordNameModal").trigger('reset');
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
		
		/*Synonyms related functions*/

		function populateTableActiveSynonyms(element, keywordId, title){
			var keywordHeadertitle= $(element).closest("tr").find("a.keywordTitle").html();
			if(typeof title === 'undefined'){
				title = keywordHeadertitle;
				$( "#mainKeywordSynoymsModal" ).find('.modal-title').html('Active synonyms of <b>' + title + '</b> keyword');
			}
			else{
				$( "#mainKeywordSynoymsModal" ).find('.modal-title').html('Active synonyms of <b>' + title + '</b> keyword');
			}
			
		    $( "#mainKeywordSynoymsModal" ).find('.keyId').html(keywordId);
		    $.ajax({
				type : "GET",
				url : "${home}synonyms?userId=${userId}&categoryId=${categoryId}&keywordId=" + keywordId + "",
				success : function(data) {
					var trHTML = '';
					var btnHtml = '';
					btnHtml += '<button style="float: right;" data-toggle="modal" data-target="#addSynonymsModal" class="btn btn-info btn-sm" id="btnAddSynonyms">Add Synonyms</button> '
							+ '<button onclick="populateTableDeletedSynonyms(this,\''+keywordId+'\',\''+title+'\')" type="button" class="btn btn-danger btn-sm">Deleted Synonyms</button>';
					
					$.each(data, function(i, value) {
						for (var j = 0; j < value.length; j++) {
							for(var i = 0; i < value[j].categories.length; i++){
								for(var k = 0; k < value[j].categories[i].keywords.length; k++){
									if(value[j].categories[i].keywords[k].synonyms === null){
										trHTML += '<tr><td>This keyword does not have synonyms</td></tr>';
										break;
									}
									else
									{
									for(var l = 0; l < value[j].categories[i].keywords[k].synonyms.length; l++){
									
										trHTML += '<tr><td class="title">' + value[j].categories[i].keywords[k].synonyms[l].synonymName 
												+ '</td><td class="hiddenKeywordId">' + value[j].categories[i].keywords[k].synonyms[l].synonymId
												+ '</a></td><td><center><a data-toggle="modal" data-target="#deleteSynonymModal" href="" onclick="deleteSynonym(\''+value[j].categories[i].keywords[k].synonyms[l].synonymId+'\')" id ="deleteSynonymFromTableBtn" class="glyphicon glyphicon-trash"></a></center>'
												+ '</td><td><center><a data-toggle="modal" data-target="#changeSynonymNameModal" class="glyphicon glyphicon-edit" href="" onClick="changeSynonymName(\''+value[j].categories[i].keywords[k].keywordId+'\',\''+value[j].categories[i].keywords[k].synonyms[l].synonymId+'\',\''+value[j].categories[i].keywords[k].synonyms[l].synonymName+'\')"></a></center>'
												+ '</td></tr>';
										}
									}
								}
							}
						}
					});
					$("#buttonsDiv").html("");
					$('#buttonsDiv').append(btnHtml);
					$('#mainSynonymsTable').html("");
					$('#mainSynonymsTable').append(trHTML);
				},
				error : function(e) {
					console.log("ERROR: ", e);
					display(e);
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		    
		    $('#mainKeywordSynoymsModal').on('hide.bs.modal', function (e) {
		    	$('#mainSynonymsTable > tbody').html("");
		    });
		};
		
		function populateTableDeletedSynonyms(element, keywordId, keywordHeaderTitle){
		    $( "#mainKeywordSynoymsModal" ).find('.modal-title').html('Deleted synonyms of <b>' + keywordHeaderTitle + '</b> keyword');
		    $( "#mainKeywordSynoymsModal" ).find('.keyId').html(keywordId);
		    $.ajax({
				type : "GET",
				url : "${home}deletedsynonyms?userId=${userId}&categoryId=${categoryId}&keywordId=" + keywordId + "",
				success : function(data) {
					var trHTML = '';
					var btnHtml = '';
					btnHtml += '<button onclick="populateTableActiveSynonyms(this,\''+keywordId+'\',\''+keywordHeaderTitle+'\')" type="button" class="btn btn-success btn-sm">Active Synonyms</button>';
					
					$.each(data, function(i, value) {
						for (var j = 0; j < value.length; j++) {
							for(var i = 0; i < value[j].categories.length; i++){
								for(var k = 0; k < value[j].categories[i].keywords.length; k++){
									if(value[j].categories[i].keywords[k].synonyms === null){
										trHTML += '<tr><td>This keyword does not have deleted synonyms</td></tr>';
										break;
									}
									else
									{
									for(var l = 0; l < value[j].categories[i].keywords[k].synonyms.length; l++){
									
										trHTML += '<tr><td class="title">' + value[j].categories[i].keywords[k].synonyms[l].synonymName 
												+ '</td><td class="hiddenKeywordId">' + value[j].categories[i].keywords[k].synonyms[l].synonymId
												+ '</a></td><td><center><a data-toggle="modal" data-target="#restoreSynonymModal" href="" onclick="restoreSynonym(\''+keywordId+'\',\''+value[j].categories[i].keywords[k].synonyms[l].synonymId+'\')" id ="restoreSynonymFromTableBtn" class="glyphicon glyphicon-ok"></a></center>'
												+ '</td></tr>';
										}
									}
								}
							}
						}
					});
					$("#buttonsDiv").html("");
					$('#buttonsDiv').append(btnHtml);
					$('#mainSynonymsTable').html("");
					$('#mainSynonymsTable').append(trHTML);
				},
				error : function(e) {
					console.log("ERROR: ", e);
					display(e);
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		    
		    $('#mainKeywordSynoymsModal').on('hide.bs.modal', function (e) {
		    	$('#mainSynonymsTable > tbody').html("");
		    });
		};
		
		function addsynonyms(){
			var synonyms = $("#synonyms").val();
			var keywordId= document.getElementById("keyId").innerHTML;
			$.ajax({
				type : "POST",
				url : "${home}addsynonyms?userId=${userId}&categoryId=${categoryId}&keywordId=" + keywordId + "&synonyms=" + synonyms,
				timeout : 100000,
				success : function(data) {
					console.log("SUCCESS: ", data);
					$('#addSynonymsModal').modal('hide');
					$('#mainKeywordSynoymsModal').modal('hide');
					populateTableActiveSynonyms();
					$("#addSynonymsForm").trigger('reset');
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
		
		function deleteSynonym(synonymId){
			var keywordId= document.getElementById("keyId").innerHTML;
			$("#btnDeleteSynonym").click(function(){
				if (this.id == 'btnDeleteSynonym') {
				$.ajax({
					type : "POST",
					url : "${home}deletesynonym?userId=${userId}&categoryId=${categoryId}&keywordId=" + keywordId + "&synonymId=" + synonymId,
					timeout : 100000,
					success : function(data) {
					$('#deleteSynonymModal').modal('hide');
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
		
		function restoreSynonym(keywordId,synonymId){
			var keywordId= document.getElementById("keyId").innerHTML;
			$("#btnRestoreSynonym").click(function(){
				if (this.id == 'btnRestoreSynonym') {
				$.ajax({
					type : "POST",
					url : "${home}restoresynonym?userId=${userId}&categoryId=${categoryId}&keywordId=" + keywordId + "&synonymId=" + synonymId,
					timeout : 100000,
					success : function(data) {
					$('#restoreSynonymModal').modal('hide');
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
		
		function changeSynonymName(keywordId, synonymId, synonymName){
			
			$( "#changeSynonymNameModal" ).find('.modal-title').html('Please enter new name for <b>' + synonymName + '</b> synonym.');
			$("#btnNewSynonymName").click(function(categoryEvent) {
				var synonymName = document.getElementById("newSynonymName").value;
				categoryEvent.preventDefault();
				$.ajax({
					type : "POST",
					url : "${home}synonymName?userId=${userId}&categoryId=${categoryId}&keywordId=" + keywordId + "&synonymId=" + synonymId + "&synonymName=" + synonymName,
					timeout : 100000,
					success : function(data) {
						console.log("SUCCESS: ", data);
						$('#changeSynonymNameModal').modal('hide');
						location.reload();
						$("#changeSynonymNameModal").trigger('reset');
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
		
		
	</script>
</body>
</html>