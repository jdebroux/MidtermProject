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
	<div >
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8, index">
				<h2>Login</h2>

				<form action="login.do" method="POST">
					<input type="text" name="username" placeholder="username" /> <br>
					<input type="password" name="password" placeholder="password" /> <br>
					<input id="button" type="submit" value="Submit" />
				</form>
				<br>
				<form action="userprofile.do" method="POST">
					<button type="submit" class="btn btn-dark btn-sm"
						value="Create New Profile">Create New Profile</button>
				</form>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>
