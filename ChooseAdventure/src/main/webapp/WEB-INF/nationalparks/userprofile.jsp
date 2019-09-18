<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>User Account</title>
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
			<c:if test="${empty account.username }">
				<h2>Create Account</h2>
			</c:if>
			<c:if test="${not empty account.username }">
				<h2>Update Account</h2>
			</c:if>
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
			<c:if test="${empty account.username }">
				<button type="submit" name="account" value="${account}"
					class="btn btn-primary">Create New Profile</button>
			</c:if>
			<c:if test="${!empty account.username }">
				<button type="submit" name="account" value="${account}"
					class="btn btn-primary">Update Profile</button>
			</c:if>
			<input type="hidden" name="id" value="${account.id}"/>
			</form>
			<c:if test="${!empty account.username }">
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

	<jsp:include page="bootstrapLower.jsp" />

</body>
</html>
