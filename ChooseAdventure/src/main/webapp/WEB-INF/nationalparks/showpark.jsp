<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	<div class="col-sm-12, showparkeroo">
		<c:if test="${ empty loggedIn.username}">
			<div class="parkNameState">
				<h3><strong>${park.name} - ${park.location.state}</strong></h3>
			</div>
			<em>${park.description}</em>
			<span>
				<ul>
				Activities:
					<c:forEach items="${park.activities}" var="activity">
						<li>${activity.name}</li>
					</c:forEach>
				</ul>
			</span>
			<div class="link">
				For more information about ${park.name}: <a href="${park.link}">National
					Park Service</a>
			</div>


			*To plan a trip, please create an account or login.
		</c:if>

		<c:if test="${! empty loggedIn.username}">
			<form action="bucketlist.do" method="POST">
			<div class="parkNameState">
				<h3><strong>${park.name} - ${park.location.state}</strong></h3>
			</div>
			<em>${park.description}</em>
<br>
				<c:choose>
					<c:when test="${size > 0}">
                    		Activities: 
                    		<br>
						<c:forEach items="${tripactivities}" var="tripactivity">
							<input type="checkbox" name="activityIds"
								value="${tripactivity.activity.id }" checked="checked">  ${tripactivity.activity.name}
								<br>
                    		</c:forEach>
						<c:forEach items="${remainingParkActivities}"
							var="remainingActivity">
							
							<input type="checkbox" name="activityIds"
								value="${remainingActivity.id }">  ${remainingActivity.name}
								<br>
                    		</c:forEach>
					</c:when>
					<c:otherwise>
                    		Activities: 
                    		<br>
						<c:forEach items="${park.activities}" var="activity">
							<input type="checkbox" name="activityIds" value="${activity.id }">  ${activity.name}
							<br>
                    		</c:forEach>
					</c:otherwise>
				</c:choose>

			<div class="link">
				For more information about ${park.name}: <a href="${park.link}">National Park Service</a>
			</div>
			
				Trip Name: <input type="hidden" name="id" value="${trip.id}" /> <input
					type="hidden" name="parkId" value="${park.id}" /> <input
					type="text" name="name" value="${trip.name}"> <input
					type="submit" value="Save Trip" />
			</form>
		</c:if>
	</div>
	<br>
	<br>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>