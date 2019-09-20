<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
		<c:if test="${ empty loggedIn.username}">

			<ul style="list-style: none;">
				<li><strong><a href="${park.link}">${park.name}</a> -
						${park.location.state}</strong></li>
				<li><em>${park.description}</em></li>
				<p>
					Activities:
					<c:forEach items="${park.activities}" var="activity">
                      ${activity.name},  
                                        
                    </c:forEach>
				</p>
			</ul>
	<h4>To plan a trip, please create an account or login.</h4>
		</c:if>
		<c:if test="${! empty loggedIn.username}">
			<form action="bucketlist.do" method="POST">

				<ul style="list-style: none;">
					<li><strong><a href="${park.link}">${park.name}</a> -
							${park.location.state}</strong></li>
					<li><em>${park.description}</em></li>
					<%-- <c:forEach items="${park.activities}" var="activity">
						<input type="checkbox" name="activityIds" value="${activity.id }" <c:if test="${trip.tripActivities.contains('activity')}"> checked="checked" </c:if>>  ${activity.name}
                    </c:forEach> --%>
                   
                    <%-- <c:forEach items="${park.activities}" var="activity">
                    	<c:forEach items="${tripactivities}" var="tripactivity">
						<c:choose>
							<c:when test="${activity.name.equals(tripactivity.activity.name)}">
								<input type="checkbox" name="activityIds" value="${activity.id }" checked="checked">  ${activity.name}
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="activityIds" value="${activity.id }">  ${activity.name}
                       	 	</c:otherwise>
                      	</c:choose>
                      	</c:forEach>   
                    </c:forEach> --%>
                    
                    
                    
                    <c:forEach items="${tripactivities}" var="tripactivity">
                    	<input type="checkbox" name="activityIds" value="${tripactivity.id }" checked="checked">  ${tripactivity.activity.name}
                    </c:forEach>
                    <c:forEach items="${remainingParkActivities}" var="remainingActivity">
                    	<input type="checkbox" name="activityIds" value="${remainingActivity.id }">  ${remainingActivity.name}
                    </c:forEach>
                    
                    
				</ul>
				Trip Name: 
				<input type="hidden" name="id" value="${trip.id}"/>
				<%-- <input type="hidden" name="account_id" value="${loggedIn.id}"/> --%>
				<input type="hidden" name="parkId" value="${park.id}"/>
				<input type="text" name="name" value="${trip.name}">
				
				<input type="submit" value="Save Trip" />
			</form>
		</c:if>
	</div>
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>