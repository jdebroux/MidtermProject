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
	<div class="row">
		<div class="col-sm-2"></div>
		<div class="col-sm-8, index">
			<div>
				<c:if test="${empty account.username }">
					Create Account
				</c:if>
				<c:if test="${not empty account.username }">
					Update Account
				</c:if>
			</div>
					<form action="userprofile.do" method="POST">
				<table>
					<tr>
						<td>User Name</td>
						<td><input type="text" required="required" name="username"
							value="${account.username }"></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" required="required"
							name="password" value="${account.password }"></td>
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
					<br>
					<button type="submit" name="account" value="${account}"
						class="btn btn-default">Create New Profile</button>
				</c:if>
				<c:if test="${!empty account.username }">
					<br>
					<button type="submit" name="account" value="${account}"
						class="btn btn-link">Update Profile</button>
				</c:if>
				<input type="hidden" name="id" value="${account.id}" />
			</form>
			<c:if test="${account.privilege == false}">
			<c:if test="${!empty account.username }">
				<form action="delete.do" method="POST">
					<button type="submit" class="btn btn-link">Delete
						Profile</button>
				</form>
				</c:if>
			</c:if>
			<c:if test="${account.privilege == true}">
				<form action="admin.do" method="POST">
					<button type="submit" class="btn btn-link">Manage
						Users</button>
				</form>
			</c:if>
		</div>

		<div class="col-sm-2"></div>
	</div>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>
