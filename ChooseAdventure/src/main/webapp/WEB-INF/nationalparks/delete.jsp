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

	<form action="delete.do" method="GET">
		<h4>Are you sure you'd like to delete ${user.userName}?</h4>
		<hidden type="number" name="user.id" />
		<input type="submit" value="Delete" />
	</form>
	<form action="index.do" method="GET">
		<input type="submit" value="Go Home" />
	</form>

	<jsp:include page="bootstrapLower.jsp" />

</body>
</html>

