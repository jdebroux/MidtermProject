<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>User Account</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div>
		<c:choose>
			<c:when test="${empty account }">
				<h2>Create Account</h2>
			</c:when>
			<c:otherwise>
				<h2>Update Account</h2>
			</c:otherwise>
		</c:choose>
	</div>
	<div>
		<form action="userprofile.do" method="POST">
			<table>
				<tr>
					<td>User Name</td>
					<td><input type="text" required="required" name="username"
						value="${account.username }"></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" required="required" name="password"
						value="${account.password }"></td>
				</tr>
				<tr>
					<td>First Name</td>
					<td><input type="text" required="required" name="firstName"
						value="${account.firstName }"></td>
				</tr>
				<tr>
					<td>Last Name</td>
					<td><input type="text" required="required" name="lastName"
						value="${account.lastName }"></td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input type="text" name="email" value="${account.email }"></td>
				</tr>
			</table>
		</form>
		<c:if test="${empty account }">
			<form action="userprofile.do" method="POST" modelAttribute="account">
				<button type="submit" class="btn btn-primary">Create New
					Profile</button>
			</form>
		</c:if>
		<c:if test="${!empty account }">
			<form action="userprofile.do" method="POST">
				<button type="submit" class="btn btn-primary">Update
					Profile</button>
			</form>
			<form action="delete.do" method="POST">
				<button type="submit" class="btn btn-primary">Delete
					Profile</button>
			</form>
			<hr>
			<form action="bucketlist.do" method="GET">
				<button type="submit" class="btn btn-primary">See Trips</button>
			</form>
		</c:if>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
</body>
</html>
