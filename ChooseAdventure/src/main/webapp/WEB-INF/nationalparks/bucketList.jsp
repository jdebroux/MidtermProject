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
<title>BucketList</title>

</head>
<body>
	<jsp:include page="navbar.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<c:choose>
		<c:when test="${not empty trips}">

			<h3>${loggedIn.firstName}'s Trips:</h3>
			<br>


			<c:forEach items="${trips}" var="singletrip">
			<h4>Adventure Yet To Happen: </h4>
				<ul>

					<!-- not yet right - just a shell of info to be filled in w/ right one -->

					<li><a href="getTrip.do?tid=${singletrip.id}"> Trip
							${singletrip.nationalPark} ${singletrip.activities} </a></li>
					<li>${singletrip.name}</li>


				</ul>
				<c:forEach items="${singletrip.tripActivities}" var="tripActivity">
					<ul>
						<li><c:out value="${tripActivity.activity.name}"></c:out></li>
					</ul>
				</c:forEach>
				<form action="deletetrip.do" method="POST">
					<input type="hidden" name="tripId" value="${singletrip.id}" /> <input
						type="submit" class="btn btn-danger" value="Delete Trip" />
				</form>
				<form action="edittrip.do" method="POST">
					<input type="hidden" name="tripId" value="${singletrip.id}" /> <input
						type="submit" class="btn btn-primary" value="Update Trip" />
				</form>
				<br>
				<br>
				<br>
			</c:forEach>



		</c:when>

		<c:otherwise>


			<h3>Hello ${loggedIn.firstName}, you should plan an exciting
				trip!! Click on home above to begin planning.</h3>



		</c:otherwise>
	</c:choose>

	<jsp:include page="bootstrapLower.jsp" />

</body>
</html>