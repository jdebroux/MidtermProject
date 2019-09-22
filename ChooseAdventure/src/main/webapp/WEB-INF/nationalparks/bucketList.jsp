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
	<div class="row">
		<div class="col-sm-2"></div>
		<div class="col-sm-8">
			<c:choose>
				<c:when test="${not empty trips}">
					<div class="index">
						<h3>${loggedIn.firstName}'s Bucket List</h3>
					</div>
					<br>
					<c:forEach items="${trips}" var="singletrip">
						<div class="index">
							<c:if test="${singletrip.completed == true}">
							- Completed Adventure - 
							<br>
							</c:if>
							<c:if test="${singletrip.completed == false}">
							- Awaiting Adventure -
							<br>
							</c:if>

							Trip Name:
							<c:out value="${singletrip.name}"></c:out>
							<br> Park Name:
							<c:out value="${singletrip.nationalPark.name}"></c:out>
							<br> Activities:
							<c:forEach items="${singletrip.tripActivities}"
								var="tripActivity">
								<c:out value="${tripActivity.activity.name} "></c:out>
							</c:forEach>


							<form action="deletetrip.do" method="POST">
								<input type="hidden" name="tripId" value="${singletrip.id}" />
								<input type="submit" class="btn btn-dark btn-sm"
									value="Delete Trip" />
							</form>
							<form action="edittrip.do" method="POST">
								<input type="hidden" name="tripId" value="${singletrip.id}" />
								<input type="submit" class="btn btn-dark btn-sm"
									value="Update Trip" />
							</form>
							<c:if test="${singletrip.completed == false}">
								<form action="completetrip.do" method="POST">
									<input type="hidden" name="tripId" value="${singletrip.id}" />
									<input type="submit" class="btn btn-dark btn-sm"
										value="Complete Trip" />
								</form>
							</c:if>
							<c:if test="${singletrip.completed == true}">
								<form action="completetrip.do" method="POST">
									<input type="hidden" name="tripId" value="${singletrip.id}" />
									<input type="submit" class="btn btn-dark btn-sm"
										value="Undo Completed Trip" />
								</form>
							</c:if>
						</div>
						<br>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="index">
						<h3>
							${loggedIn.firstName}, you should plan an exciting trip!! <br>Click
							on home above to begin planning.
						</h3>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="col-sm-2"></div>
	</div>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>