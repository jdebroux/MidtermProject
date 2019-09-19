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

<jsp:include page="nationalparks/navbar.jsp" />
</head>
<body>
	<br>
	<br>
	<br>
	<br>

	<div id="YAP">Your Adventure Planner!</div>


	<form action="activities.do" method="POST">
		<div class="activitiesforeach, container">
			Search for parks by activity: <br>
			<table>
				<c:forEach items="${activities}" var="activity">
					<tr>
						<td><input type="checkbox" name="activityIds"
							value="${activity.id }"> ${activity.name}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="button">
			<br> <input type="submit" value="Find Parks" />
			</div>
	</form>

	<jsp:include page="nationalparks/footer.jsp" />
	<jsp:include page="nationalparks/bootstrapLower.jsp" />

</body>
</html>