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
<link rel="stylesheet" href="IndexStyle.css" />
<style>
table {
	border-spacing: 5px;
}

table, th, td {
	border: 1px solid black;
}

th, td {
	padding: 5px;
	text-align: left;
}
</style>
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
			Welcome, ${loggedIn.firstName} <br>
			<table class="table-admin">
				<tr>

					<th>Username</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Privilege</th>
					<th>Active</th>
					<th>Toggle</th>

				</tr>
				<c:forEach items="${accounts}" var="account">
					<tr>
						<td>${account.username}</td>
						<td>${account.firstName}</td>
						<td>${account.lastName}</td>
						<td>${account.email}</td>
						<td>${account.privilege}</td>
						<td>${account.active}</td>
						<td><c:if test="${account.privilege == false}">
								<form action="toggleuseraccountactive.do" method="POST">
									<input type="hidden" name="id" value="${account.id}" />
									<button type="submit" class="btn btn-link">Toggle
										Active</button>
								</form>
							</c:if></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="col-sm-2"></div>
	</div>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>