<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
	
<div class="tocenter">
    <table class="table table-bordered table-hover" id="categoryTable">
        <thead>
            <tr>
                <th style="margin: 0 auto;">Name</th>
                <th style="margin: 0 auto;">Restore</th>
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
                    <button type="submit" class="btn btn-default" id="delCategory" name="delCategory">Yes</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>
</div>

	<script type="text/javascript">
	
		$(document).ready(function() {
		    populateTable();
		});
	
		function populateTable() {
		    $.ajax({
		        type: "GET",
		        url: "${home}deletedcategories?userId=" + $("#userID").text(),
		        timeout: 100000,
		        success: function(data) {
		            var trHTML = '';
		            $.each(data, function(i, value) {
		                for (var j = 0; j < value.length; j++) {
		                    for (var i = 0; i < value[j].categories.length; i++) {
		                        trHTML += '<tr><td>' + value[j].categories[i].categoryName +
		                            '</td><td><center><a title="Restore" data-toggle="modal" data-target="#deleteCategoryModal" onclick="restoreCategory(\'' + value[j].categories[i].categoryId + '\')" id ="dcat" class="glyphicon glyphicon-ok"></a></center>' +
		                            '</td></tr>';
		                    }
		                }
		            });
		            $("#categoryTable > tbody").html("");
		            $('#categoryTable').append(trHTML);
		        },
		        error: function(e) {
		            console.log("ERROR: ", e);
		            display(e);
		        },
		        done: function(e) {
		            console.log("DONE");
		        }
		    });
		}
	
		function restoreCategory(id) {
		    $("#delCategory").click(function() {
		        if (this.id == 'delCategory') {
		            $.ajax({
		                type: "POST",
		                url: "${home}restoreCategory?categoryId=" + id,
		                timeout: 100000,
		                success: function(data) {
		                    $('#deleteCategoryModal').modal('hide');
		                    populateTable();
		                },
		                error: function(e) {
		                    console.log("ERROR: ", e);
		                },
		                done: function(e) {
		                    alert("DONE");
		                }
		            });
		        }
		    });
		};

	</script>


</body>
</html>