<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<jsp:include page="bootstrapUpper.jsp" />
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
		<div class="col-sm-8, index">
			<h3>Welcome, ${loggedIn.firstName}</h3>
			<br>
			<c:forEach items="${accounts}" var="account">
				<h4>Username: ${account.username}</h4>
				<ul>
					<li>Active: ${account.active}</li>
					<li>First Name: ${account.firstName}</li>
					<li>Last Name: ${account.lastName}</li>
					<li>Email: ${account.email}</li>
					<li>Privilege: ${account.privilege}</li>
				</ul>
				<c:if test="${account.privilege == false}">
					<form action="toggleuseraccountactive.do" method="POST">
						<input type="hidden" name="id" value="${account.id}" />
						<button type="submit" class="btn btn-primary">Toggle
							Active</button>
					</form>
				</c:if>
			</c:forEach>
		</div>
		<div class="col-sm-2"></div>
	</div>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>