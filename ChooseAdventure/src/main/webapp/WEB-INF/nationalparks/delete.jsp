<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Delete User</title>
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
		<c:choose>
			<c:when test="${user.active == true}">

				<h4>Are you sure you'd like to delete your account, ${user.firstName}?</h4>
				<form action="delete.do" method="POST">
					<input type="hidden" name="aid" value="${loggedIn.id}" /> <input
						id="button" type="submit" value="Delete" />
				</form>
			</c:when>
			<c:otherwise>
				<h4>Account Deleted</h4>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="col-sm-2"></div>
	</div>

	<jsp:include page="bootstrapLower.jsp" />

</body>
</html>

