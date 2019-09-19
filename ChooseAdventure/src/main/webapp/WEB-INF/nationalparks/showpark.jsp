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

<style>
body, html {
	background: url("${park.picture}") no-repeat center center scroll;
	height: 100%;
	background-size: cover;
	background-attachment: fixed;
}
</style>
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<br>
	<br>
	<br>
	<br>
	<div>
		<c:choose>
			<c:when test="${! empty park }">

				<ul style="list-style: none;">
					<li><strong><a href ="${park.link}">${park.name}</a> - ${park.location.state}</strong></li>
					<li><em>${park.description}</em></li>
					<c:forEach items="${park.activities}" var="activity">
						<input type="checkbox" name="activityIds" value="${activity.id }"> ${activity.name} 
										
					</c:forEach>
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