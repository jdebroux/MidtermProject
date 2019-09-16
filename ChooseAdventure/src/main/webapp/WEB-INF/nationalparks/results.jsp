<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Results</title>
<meta charset="utf-8">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
</head>
<body>
	<h3>Parks Found</h3>

	<c:choose>
		<c:when test="${not empty parks}">

			<ul style="list-style: none;">
				<c:forEach items="${parks}" var="park">
					<li><a href="showpark.do?park=${park.link}">${park.name}</a></li>
					<li>${park.description}</li>
					<li>${park.location.state}</li>
				</c:forEach>
			</ul>

		</c:when>

		<c:otherwise>
			<h4>None</h4>
		</c:otherwise>
	</c:choose>
</body>
</html>