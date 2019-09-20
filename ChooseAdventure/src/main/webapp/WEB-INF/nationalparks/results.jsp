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

</head>
<body>
	<jsp:include page="navbar.jsp" />

	<br>
	<br>
	<br>
	<br>
	<c:choose>
		<c:when test="${not empty parks}">

			<!-- <ul style="list-style: none;"> -->
			<c:forEach items="${parks}" var="park">
				<div class="container">
						<img src="${park.picture}" alt="Avatar" class="image">
						<div class="outsidemiddle">
							<b>${park.name}</b> <small> - ${park.location.state}</small>
						</div>
					<div class="middle">
						<div class="text">
								<form action="gotoshowpark.do" method="GET">
									<input type="hidden" name="pid" value="${park.id}"> <input
										type="submit" class="btn btn-primary" value="Park Details">
								</form>
						</div>
					</div>
				</div>
				<br>
			</c:forEach>


		</c:when>

		<c:otherwise>
			<h4>None</h4>
		</c:otherwise>
	</c:choose>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>