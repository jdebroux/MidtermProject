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

<style>

.container {
	position: relative;
	width: 50%;
}

img {
  border-radius: 5%;
}

.image {
	opacity: 1;
	display: block;
	width: 100%;
	height: auto;
	transition: .5s ease;
	backface-visibility: hidden;
}

.middle {
	transition: .5s ease;
	opacity: 0;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	text-align: center;
}

.container:hover .image {
	opacity: 0.3;
}

.container:hover .middle {
	opacity: 1;
}

.text {
	background-color: #B0E0E6;
	color: white;
	font-size: 16px;
	padding: 16px 32px;
}

</style>

</head>
<body>
	<jsp:include page="navbar.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<h3>Parks Found</h3>

	<c:choose>
		<c:when test="${not empty parks}">

			<ul style="list-style: none;">
				<c:forEach items="${parks}" var="park">
					<li id="parkname"><b>${park.name}</b></li>
					<li><small>${park.location.state}</small></li>
					<li><em>${park.description}</em></li>

					<li>
						<div class="container">
						<form action="showpark.do" method="POST">
						<input type="hidden" name="pid" value="${park.id}">
							<img src="${park.picture}" alt="Avatar" class="image"
								style="width: 100%" style="border: 5px solid white">
							<div class="middle">
								<div class="text"><a href="showpark.do">Park Details</a></div>
							</div>
						</form>
						</div>

					</li>
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