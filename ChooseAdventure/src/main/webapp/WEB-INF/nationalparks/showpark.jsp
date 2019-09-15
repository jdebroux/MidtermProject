<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Show Park</title>
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
	<jsp:include page="navbar.jsp" />

	<div>
		<c:choose>
			<c:when test="${! empty national_park.id }">

				<ul style="list-style: none;">
					<li>${national_park.name}</li>
					<li>${national_park.description}</li>
					<li>${location.state}</li>
					<li>${national_park.link_nps}</li>
				</ul>
			</c:when>
			<c:otherwise>
				<h4>No Park found</h4>
			</c:otherwise>
		</c:choose>
	</div>

	<input type="submit" value="Plan a Trip" />
	<input type="submit" value="Save Trip" />

</body>
</html>