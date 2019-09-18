<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Show Park</title>
<meta charset="utf-8">
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
		<c:choose>
			<c:when test="${! empty park }">

				<ul style="list-style: none;">
					<li>${park.name}</li>
					<li>${park.description}</li>
					<li>${park.location.state}</li>
					<li>${park.link}</li>
				</ul>
			</c:when>
			<c:otherwise>
				<h4>No Park found</h4>
			</c:otherwise>
		</c:choose>
	</div>

	<input type="submit" value="Plan a Trip" />
	<input type="submit" value="Save Trip" />


	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>