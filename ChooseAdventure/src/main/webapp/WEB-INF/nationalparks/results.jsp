<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Results</title>
<meta charset="UTF-8">
<jsp:include page="bootstrapUpper.jsp" />
<link rel="stylesheet" href="IndexStyle.css" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<h3>Parks Found</h3>

	<c:choose>
		<c:when test="${not empty parks}">

			<ul style="list-style: none;">
				<c:forEach items="${parks}" var="park">
					<li><a href="${park.link}">${park.name}</a></li>
					<li>${park.location.state}</li>
					<li>${park.description}</li>

					<li><img src="${park.picture}" alt="${park.name}" height="300"
						width="400" style="border: 5px solid white"></li>
					<br>
				</c:forEach>
			</ul>

		</c:when>

		<c:otherwise>
			<h4>None</h4>
		</c:otherwise>
	</c:choose>
	
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>