<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Login</title>
<meta charset="UTF-8">
<jsp:include page="bootstrapUpper.jsp" />
<link rel="stylesheet" href="IndexStyle.css" />
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div>
		<h2>Login</h2>

		<form action="login.do" method="POST">
			<input type="text" name="username" placeholder="username" /> <br>
			<input type="password" name="password" placeholder="password" /> <br>
			<input type="submit" value="Submit" />
		</form>
	</div>
	<div>
		<hr>
		<form action="userprofile.do" method="GET">
			<button type="submit" class="btn btn-primary"
				value="Create New Profile">Create New Profile</button>
		</form>
	</div>

	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>
