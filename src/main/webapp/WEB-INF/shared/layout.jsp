<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Social Media Analysis</title>
    
<script src="<c:url value="/resources/js/jquery.min.js" />"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="http://code.highcharts.com/modules/heatmap.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<link href="<c:url value="/resources/css/bootstrap-datetimepicker.min.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/navigation-bar.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/manage-categories.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/fonts/montserrat.css" />" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet" />
 <script src="<c:url value="/resources/js/bootstrap-datetimepicker.js" />"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
	
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
        		<li ><a href="${home}home"><span class="glyphicon glyphicon-home"></span> Home</a></li>
        		<li class="dropdown">
        			<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-cog"></span> Manage Categories <span class="caret"></span></a>
        			<ul class="dropdown-menu" id="manageCategoriesDropdown">
        				<li id="deletedCategories"><a href="${home}deleted-categories">Restore Category</a></li>
        				<li ><a href="${home}active-categories">Manage Categories</a></li>
        			</ul>
        		</li>
				<li><a href="${home}datasources"><span class="glyphicon glyphicon-cloud"></span> My Pages</a></li>
				<li><a href="${home}feeds"><span class="glyphicon glyphicon-comment"></span> Feeds</a></li>
			</ul>
      		<ul class="nav navbar-nav navbar-right">
      			<li><a href="http://localhost:8080/socialmediaanalysis/logout"><span class="glyphicon glyphicon-off"></span> Sign Out</a></li>
      		</ul>
    	</div>
  	</div>
	</nav>
    <decorator:body />
</body>
</html>