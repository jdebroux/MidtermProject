<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Adventure Planner</title>
<meta charset="utf-8">

<jsp:include page="bootstrapUpper.jsp" />
<link rel="stylesheet" href="IndexStyle.css" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<br>
	<br>
	<br>
	<br>

	<div class="row">
		<div class="col-sm-2"></div>
		<div class="col-sm-8, index">
			<form action="showpark.do" method="GET">
				Search For a National Park<br> By State: <select name="state">
					<c:forEach items="${states}" var="state">
						<option value="${state}">${state}</option>
					</c:forEach>
				</select>
				<button type="submit" class="btn btn-dark btn-sm" value="Submit">Submit</button>
			</form>
			<div>
				<form action="results.do" method="GET">
					By Keyword: <input id="button" type="text" name="keyword"
						placeholder="keyword search" />
					<button type="submit" class="btn btn-dark btn-sm" value="Submit">Submit</button>
				</form>
			</div>
		</div>
		<div class="col-sm-2"></div>
	</div>
	<div class="row"></div>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapLower.jsp" />
</body>
</html>
