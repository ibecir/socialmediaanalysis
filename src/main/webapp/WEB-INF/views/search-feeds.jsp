<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

	<div class="panel panel-default" style="width: 500px; margin: 0 auto;">
		<div class="panel-heading" style="font-family: Consolas, monaco, monospace; font-weight: bold;">
			Search <span class="glyphicon glyphicon-globe"></span>
		</div>
		<div class="panel-body">
			<div style="width: 470px; margin: 0 auto; padding-top: 15px; padding-bottom: 50px;">
				<input class="form-control" id="keyword" type="text" placeholder="Enter keyword to search" style="width: auto; float: left; margin-right: 5px;" /> <select id="category" class="form-control" style="width: auto; float: left;">
					<option></option>
				</select>
				<button class="btn btn-default btn-lg" onclick="validate()" style="width: 70px; float: right;">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</div>
		</div>
	</div>

	<div class="panel panel-default" id="mainContainer" style="width: 1100px; margin: 0 auto; margin-top: 20px;">
		<div class="panel-heading" id="mainHeading" style="font-weight: bold;">
			<span class="glyphicon glyphicon-th-list" style="margin-right: 10px;"></span> feeds <span class="label label-info" id="feedOccurences" style="float: right"></span>
		</div>
		<div class="panel-body" id="panelBody">
			<table class="table" id="mainTable"></table>
		</div>
		<div class="panel-footer" id="panelFooter" style="height: 48px;">
			<p id="moreFeeds" style="text-align: center;"></p>
		</div>
	</div>

	<script>
		$(function() {
			$.ajax({
				type : "GET",
				url : "${home}get-categories?userId=${userId}",
				success : function(data) {
					populateDropdown(data);
					loadInitialData();
				},
				error : function(e) {
					alert("ERROR");
				},
				done : function(e) {
					alert("DONE");
				}
			});
		});

		function loadInitialData() {
			$
					.ajax({
						type : "GET",
						url : "${home}search-feedk?userId=${userId}&keyword=dodik&skip=0",
						success : function(data) {
							showSearchedFeeds(data);
						},
						error : function(e) {
							alert("ERROR");
						},
						done : function(e) {
							alert("DONE");
						}
					});
		}

		function populateDropdown(data) {
			var select = document.getElementById("category");

			for (var i = 0; i < data.length; i++) {
				var opt = data[i];
				select.innerHTML += "<option id=" + data[i].id +" value=" + data[i].id + ">"
						+ data[i].name + "</option>";
			}
		}

		function validate() {
			var keyword = document.getElementById("keyword");
			var category = document.getElementById("category");
			if (keyword.value == "" && category.value == "") {
				keyword.style.borderColor = 'red';
				category.style.borderColor = 'red';
			} else if (category.value == "") {
				$.ajax({
					type : "GET",
					url : "${home}search-feedk?userId=${userId}&keyword="
							+ keyword.value + "&skip=0",
					success : function(data) {
						document.getElementById("mainTable").innerHTML = '';
						showSearchedFeeds(data);
					},
					error : function(e) {
						alert("ERROR");
					},
					done : function(e) {
						alert("DONE");
					}
				});
				keyword.style.borderColor = 'default';
				category.style.borderColor = 'default';
			} else if (keyword.value == "") {
				$.ajax({
					type : "GET",
					url : "${home}search-feedc?userId=${userId}&categoryId="
							+ category.value + "&skip=0",
					success : function(data) {
						document.getElementById("mainTable").innerHTML = '';
						showSearchedFeeds(data);
					},
					error : function(e) {
						alert("ERROR");
					},
					done : function(e) {
						alert("DONE");
					}
				});
				keyword.style.borderColor = 'default';
				category.style.borderColor = 'default';
			} else {
				$.ajax({
					type : "GET",
					url : "${home}search-feedck?userId=${userId}&categoryId="
							+ category.value + "&keyword=" + keyword.value
							+ "&skip=0",
					success : function(data) {
						document.getElementById("mainTable").innerHTML = '';
						showSearchedFeeds(data);
					},
					error : function(e) {
						alert("ERROR");
					},
					done : function(e) {
						alert("DONE");
					}
				});
				keyword.style.borderColor = 'default';
				category.style.borderColor = 'default';
			}
		}

		var tblRows = 0;

		var occurencesSpanLabel = document.createElement("span");
		occurencesSpanLabel.className = "label label-info";
		occurencesSpanLabel.style.cssFloat = 'right';

		function showSearchedFeeds(feeds) {

			var dateOfFeedCreation = new Date();

			occurencesSpanLabel.innerHTML = "";

			var countRows = document.getElementById("mainTable").rows.length;
			tblRows = countRows + feeds.length;

			var mainPanelHeading = document.getElementById("mainHeading");
			occurencesSpanLabel.appendChild(document.createTextNode(tblRows
					+ " feeds"));
			mainPanelHeading.appendChild(occurencesSpanLabel);

			if (feeds.length > 0) {

				for (var i = 0; i <= feeds.length; i++) {

					var panelBody = document.getElementById("mainTable");
					var tr = document.createElement("tr");
					var td = document.createElement("td");

					var innerPanel = document.createElement("div");
					innerPanel.className = "panel panel-default";

					//Panel heading related things
					var headingOfInnerPanel = document.createElement("div");
					headingOfInnerPanel.className = "panel-heading";

					var innerDivOfHeadingPanel = document.createElement("div");

					var userNameASpanHref = document.createElement("a");
					userNameASpanHref.setAttribute("target", "_blank");
					userNameASpanHref.setAttribute("href",
							"https://www.facebook.com/" + feeds[i].fb_userid);

					var iconSpan = document.createElement("span");
					iconSpan.className = "glyphicon glyphicon-user";
					iconSpan.style.color = '#295C6B';
					iconSpan.style.cssFloat = 'left';
					iconSpan.style.padding = '2px';
					iconSpan.style.marginRight = "5px";

					var usernameSpanLabel = document.createElement("span");
					usernameSpanLabel.className = "label label-primary";
					usernameSpanLabel.style.cssFloat = 'left';
					usernameSpanLabel.style.padding = '5px';
					usernameSpanLabel.style.marginRight = "20px";
					usernameSpanLabel.appendChild(document
							.createTextNode(feeds[i].userName));

					userNameASpanHref.appendChild(iconSpan);
					userNameASpanHref.appendChild(usernameSpanLabel);

					innerDivOfHeadingPanel.appendChild(document
							.createTextNode("|"));

					var urlASpanHref = document.createElement("a");
					urlASpanHref.setAttribute("target", "_blank");
					urlASpanHref.setAttribute("href", "https://www."
							+ feeds[i].url);

					var urlSpan = document.createElement("span");
					urlSpan.className = "glyphicon glyphicon-send";
					urlSpan.style.color = '#800000';
					urlSpan.style.cssFloat = 'left';
					urlSpan.style.padding = '1px';
					urlSpan.style.marginLeft = "7px";
					urlSpan.style.marginRight = "7px";

					var sourcNameSpan = document.createElement("span");
					sourcNameSpan.className = "label";
					sourcNameSpan.style.color = '#800000';
					sourcNameSpan.appendChild(document
							.createTextNode(feeds[i].source));

					dateOfFeedCreation = new Date(feeds[i].dateOfCreation);

					var dateSpan = document.createElement("span");
					dateSpan.className = "label";
					dateSpan.style.color = 'black';
					dateSpan.style.cssFloat = 'right';
					dateSpan.style.padding = '5px';
					dateSpan.appendChild(document
							.createTextNode(dateOfFeedCreation.toString()
									.slice(0, -16)));

					urlASpanHref.appendChild(urlSpan);
					urlASpanHref.appendChild(sourcNameSpan);

					innerDivOfHeadingPanel.appendChild(userNameASpanHref);
					innerDivOfHeadingPanel.appendChild(urlASpanHref);
					innerDivOfHeadingPanel.appendChild(dateSpan);

					headingOfInnerPanel.appendChild(innerDivOfHeadingPanel);

					//Panel body related things
					var bodyOfInnerPanel = document.createElement("div");
					bodyOfInnerPanel.className = "panel-body";

					var paragraphForMessage = document.createElement("p");
					paragraphForMessage.appendChild(document
							.createTextNode(feeds[i].message));

					bodyOfInnerPanel.appendChild(paragraphForMessage);

					//Appending all reated things
					innerPanel.appendChild(headingOfInnerPanel);
					innerPanel.appendChild(bodyOfInnerPanel);

					td.appendChild(innerPanel);
					tr.appendChild(td);
					panelBody.appendChild(tr);
				}

			} else {
				occurencesSpanLabel.innerHTML = "";
				var mainPanelHeading = document.getElementById("mainHeading");
				occurencesSpanLabel.appendChild(document
						.createTextNode(feeds.length + " feeds"));
				mainPanelHeading.appendChild(occurencesSpanLabel);

				var panelBody = document.getElementById("mainTable");
				var tr = document.createElement("tr");
				var td = document.createElement("td");

				var paragraphForMessage = document.createElement("p");
				paragraphForMessage
						.appendChild(document
								.createTextNode("There is no feeds for given parameters."));

				td.appendChild(paragraphForMessage);
				tr.appendChild(td);
				panelBody.appendChild(tr);
			}
		}

		var pMoreFeeds = document.getElementById("moreFeeds");

		var aMoreFeeds = document.createElement("button");
		aMoreFeeds.className = "btn btn-default";
		aMoreFeeds.onclick = loadMoreFeeds;

		var spanMoreFeedsIcon = document.createElement("span");
		spanMoreFeedsIcon.className = "glyphicon glyphicon-cloud-download";

		aMoreFeeds.appendChild(spanMoreFeedsIcon);
		pMoreFeeds.appendChild(aMoreFeeds);

		function loadMoreFeeds() {
			var keyword = document.getElementById("keyword");
			var category = document.getElementById("category");
			var skip = document.getElementById("mainTable").rows.length;

			if (skip % 200 == 0) {

				if (keyword.value == "" && category.value == "") {
					keyword.style.borderColor = 'red';
					category.style.borderColor = 'red';
				} else if (category.value == "") {
					$.ajax({
						type : "GET",
						url : "${home}search-feedk?userId=${userId}&keyword="
								+ keyword.value + "&skip=" + skip,
						success : function(data) {
							showSearchedFeeds(data);
						},
						error : function(e) {
							alert("ERROR");
						},
						done : function(e) {
							alert("DONE");
						}
					});
					keyword.style.borderColor = 'default';
					category.style.borderColor = 'default';
				} else if (keyword.value == "") {
					$
							.ajax({
								type : "GET",
								url : "${home}search-feedc?userId=${userId}&categoryId="
										+ category.value + "&skip=" + skip,
								success : function(data) {
									showSearchedFeeds(data);
								},
								error : function(e) {
									alert("ERROR");
								},
								done : function(e) {
									alert("DONE");
								}
							});
					keyword.style.borderColor = 'default';
					category.style.borderColor = 'default';
				} else {
					$
							.ajax({
								type : "GET",
								url : "${home}search-feedck?userId=${userId}&categoryId="
										+ category.value
										+ "&keyword="
										+ keyword.value + "&skip=" + skip,
								success : function(data) {
									showSearchedFeeds(data);
								},
								error : function(e) {
									alert("ERROR");
								},
								done : function(e) {
									alert("DONE");
								}
							});
					keyword.style.borderColor = 'default';
					category.style.borderColor = 'default';
				}
			}
		}
	</script>
</body>
</html>