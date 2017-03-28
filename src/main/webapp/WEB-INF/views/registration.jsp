<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600' rel='stylesheet' type='text/css'>
<link href="//netdna.bootstrapcdn.com/font-awesome/3.1.1/css/font-awesome.css" rel="stylesheet">
<link href="resources/css/registration.css" rel="stylesheet" type="text/css" />
<script src='https://www.google.com/recaptcha/api.js'></script>
<title>Register</title>
</head>
<body>
	<div class="testbox">
		<h1>Registration</h1>
		<form action="person/save" onsubmit="return validation();" method="post">
			<hr>
			<label id="icon" for="firstName"><i class="icon-pencil "></i></label> 
			<input type="text" name="firstName" id="firstName" placeholder="Firstname" required />
			
			<label id="icon" for="lastName"><i class="icon-pencil "></i></label> 
			<input type="text" name="lastName" id="lastName" placeholder="Lastname" required />
			
			<label id="icon" for="email"><i class="icon-envelope "></i></label> 
			<input type="text" name="email" id="email" placeholder="Email" required />
			
			<label id="icon" for="name"><i class="icon-user"></i></label> 
			<input type="text" name="name" id="name" placeholder="Username" required />
			 
			<label id="icon" for="password"><i class="icon-shield"></i></label> 
			<input type="password" name="password" id="password" placeholder="Password" required />
			
			<label id="icon" for="rpassword"><i class="icon-shield"></i></label> 
			<input type="password" name="rpassword" id="rpassword" placeholder="Repete password" required />
			
			<button type="submit">Register</button>
		</form>
	</div>
	
	<script type="text/javascript">
	
		function validation(){
			var pattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
			var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/;
			var firstname = document.getElementById("firstName");
			var lastname = document.getElementById("lastName");
			var email = document.getElementById("email");
			var username = document.getElementById("name");
			var password = document.getElementById("password");
			var rpassword = document.getElementById("rpassword");
			
			if(firstname.value.length <= 4 || firstname.value.length >= 25){
				alert("Firstname field must be al least 5 character long and at most 25 characters long.");
				firstname.style.borderColor = 'red';
				lastname.style.borderColor = '#cbc9c9';
				email.style.borderColor = '#cbc9c9';
				username.style.borderColor = '#cbc9c9';
				password.style.borderColor = '#cbc9c9';
				rpassword.style.borderColor = '#cbc9c9';
				return false;
			}
			else if(lastname.value.length <= 4 || lastname.value.length >= 25){
				alert("Lastname field must be al least 5 character long and at most 25 characters long.");
				lastname.style.borderColor = 'red';
				firstname.style.borderColor = '#cbc9c9';
				email.style.borderColor = '#cbc9c9';
				username.style.borderColor = '#cbc9c9';
				password.style.borderColor = '#cbc9c9';
				rpassword.style.borderColor = '#cbc9c9';
				return false;
			}
			else if(email.value.length <= 10 || !pattern.test(email.value)){
				alert("Please enter valid email address.");
				email.style.borderColor = 'red';
				firstname.style.borderColor = '#cbc9c9';
				lastname.style.borderColor = '#cbc9c9';
				username.style.borderColor = '#cbc9c9';
				password.style.borderColor = '#cbc9c9';
				rpassword.style.borderColor = '#cbc9c9';
				return false;
			}
			else if(username.value.length <= 6 || username.value.length >= 40){
				alert("Username field must be al least 7 character long and at most 25 characters long.");
				username.style.borderColor = 'red';
				firstname.style.borderColor = '#cbc9c9';
				lastname.style.borderColor = '#cbc9c9';
				email.style.borderColor = '#cbc9c9';
				password.style.borderColor = '#cbc9c9';
				rpassword.style.borderColor = '#cbc9c9';
				return false;
			}
			else if(!passwordRegex.test(password.value)){
				alert("Password should be al least 8 character long and contail one uppercase and one lowercase letter with one digit.");
				password.style.borderColor = 'red';
				firstname.style.borderColor = '#cbc9c9';
				lastname.style.borderColor = '#cbc9c9';
				email.style.borderColor = '#cbc9c9';
				username.style.borderColor = '#cbc9c9';
				rpassword.style.borderColor = '#cbc9c9';
				return false;
			}
			else if(password.value != rpassword.value){
				alert("Password fields needs to match");
				rpassword.style.borderColor = 'red';
				firstname.style.borderColor = '#cbc9c9';
				lastname.style.borderColor = '#cbc9c9';
				email.style.borderColor = '#cbc9c9';
				username.style.borderColor = '#cbc9c9';
				password.style.borderColor = '#cbc9c9';
				return false;
			}
		}
	
	</script>
	
</body>
</html>