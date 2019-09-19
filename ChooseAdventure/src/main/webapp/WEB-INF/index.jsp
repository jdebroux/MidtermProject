<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Adventure Planner</title>
<meta charset="UTF-8">
<jsp:include page="nationalparks/bootstrapUpper.jsp" />
<link rel="stylesheet" href="IndexStyle.css" />

</head>
<body>
	<jsp:include page="nationalparks/navbar.jsp" />
	<br>
	<br>
	<br>
	<br>
	<div class="container-fluid">

		<div id="YAP">Your Adventure Planner!</div>
		<div id="SearchForParksByActivity">Search for parks by activity:</div>
<!-- 		<div class="row">
			<div class="col-sm-1"></div> -->
		<!-- 	<div class="col-md-7">
				<div>
					<div class="col-sm-4"></div>
					<div class="row">
						<div class="col-sm-3"></div>
						<div class="col-md-7">
						</div>
						<div>
							<h3>Plan Your Trip!</h3>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
			</div> -->
			<!-- <br> -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-md-7">
						<div>
							<form action="activities.do" method="POST">
								<h5>
								<ul id="activityList">
									<c:forEach items="${activities}" var="activity">
										<li><input type="checkbox" name="activityIds"
											value="${activity.id }"> ${activity.name}</li> 
									</c:forEach>
									</ul>
								</h5>
								<input type="submit" value="Find Parks" />
							</form>
							<div class="col-sm-2"></div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="nationalparks/bootstrapLower.jsp" />
</body>
</html>