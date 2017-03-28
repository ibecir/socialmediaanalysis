<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTDx HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login</title>

<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<script src="<c:url value="/resources/js/jquery.min.js" />"></script>
<link href="<c:url value="/resources/css/admin.css" />" rel="stylesheet">
<link href="<c:url value="/resources/fonts/montserrat.css" />" rel="stylesheet" type='text/css'>
</head>
<body>
	<form action="login" method="post">
		<div class="login-block">
			<h1>Login</h1>
			<div class="error">${error}</div>
			<input type="text" placeholder="username" id="name" name="name" /> 
			<input type="password" placeholder="password" id="password" name="password" />

			<button value="submit" type="submit">Login</button>
			<div style="padding-top: 8px; padding-bottom: 8px;">
				<a href="${home}registration" style="color: black; float: right;"><span class=" glyphicon glyphicon-user"></span> Register</a>
			</div>
		</div>
	</form>
	<script>
		$(document).ready(function() {
			$('.error:empty').hide();
		});
	</script>
</body>
</html>