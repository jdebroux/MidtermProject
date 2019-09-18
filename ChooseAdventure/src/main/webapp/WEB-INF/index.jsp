<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Adventure Planner</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">

<link rel="stylesheet" href="IndexStyle.css" />

</head>
<body>
	<jsp:include page="nationalparks/navbar.jsp" />
	<br>
	<br>
	<div class="container-fluid">

		<div class="row">
			<div class="col-sm-1"></div>

			<div class="col-md-7">

				<div>
					<h1>Your Adventure Planner!</h1>



					<div class="col-sm-4"></div>

					<div class="row">
						<div class="col-sm-3"></div>

						<div class="col-md-7">
							<br> <br> <br> <br> <br>
							<h4>Build a bucket list of National Parks to visit based on
								your interests.</h4>
						</div>
						<!-- <div>
							<h3>Plan Your Trip!</h3>
						</div> -->
						<div class="col-sm-2"></div>
					</div>
				</div>
			</div>
			<br>
			<div class="container-fluid">

				<div class="row">
					<div class="col-sm-3"></div>

					<div class="col-md-7">

						<div>

							<form action="activities.do" method="POST">
								<h5>
									Find Parks by Activity: <br>
									<c:forEach items="${activities}" var="activity">
										<input type="checkbox" name="activityIds"
											value="${activity.id }">       ${activity.name } 
					</c:forEach>
								</h5>
								<input type="submit" value="Find Parks" />
							</form>
							<div class="col-sm-2"></div>
						</div>
					</div>
				</div>
			</div>




			<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
				integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
				crossorigin="anonymous"></script>
			<script
				src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
				integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
				crossorigin="anonymous"></script>
			<script
				src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
				integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
				crossorigin="anonymous"></script>
</body>
</html>