<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
	<h2>Add or Delete User With MongoDB</h2>
		<form action="person/save" method="post">
			<input type="hidden" name="id">
			<label for="name">Username</label>
			<input type="text" id="name" name="name"/>
			<label for="password">Password</label>
			<input type="text" id="password" name="password" />
			<label for="type">Type</label>
			<input type="text" id="type" name="type" />
			<input type="submit" value="Submit"/>
		</form>

	<table border="1">
		<c:forEach var="person" items="${personList}">
			<tr>
				<td>${person.name}</td><td><input type="button" value="delete" onclick="window.location='person/delete?id=${person.id}'"/></td>
			</tr>
		</c:forEach>
	</table>	
</body>
</html>