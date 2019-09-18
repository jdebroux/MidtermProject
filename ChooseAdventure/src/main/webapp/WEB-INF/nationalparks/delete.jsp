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

	<c:if test="${not empty user}">

		<h4>Are you sure you'd like to delete ${user.userName}?</h4>
		<form action="delete.do" method="POST">
			<input type="hidden" name="aid" value="${user.id}" /> <input type="submit"
				value="Delete"/>
		</form>
	</c:if>
	<c:if test="${empty user}">
		<h4>Account Deleted</h4>
	</c:if>

	<jsp:include page="bootstrapLower.jsp" />

</body>
</html>

