<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="bootstrapUpper.jsp" />
<link rel="stylesheet" href="IndexStyle.css" />
<title>Delete Account</title>

</head>
<body>
	<jsp:include page="navbar.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<c:choose>
		<c:when test="">

			<h3>Hello ${account.firstName}, your trips:</h3>


			<ul>

				<c:forEach items="${trip }" var="trip">

					<!-- not yet right - just a shell of info to be filled in w/ right one -->

					<li><a href="getTrip.do?tid=${trip.id}"> Trip
							${trip.nationalPark} ${trip.activities} </a></li>
				</c:forEach>

				<li>${trip.name}</li>

				<li>${trip. }
			</ul>


		</c:when>

		<c:otherwise>


			<h3>Hello ${account.firstName}, you should plan an exciting
				trip!! Click on home above to begin planning.</h3>



		</c:otherwise>
	</c:choose>

	<jsp:include page="bootstrapLower.jsp" />

</body>
</html>