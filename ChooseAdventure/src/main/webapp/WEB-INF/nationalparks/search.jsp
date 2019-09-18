<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Choose Adventure</title>
<meta charset="utf-8">

	<jsp:include page="bootstrapUpper.jsp" />
	<link rel="stylesheet" href="IndexStyle.css" />
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<div>
		<h1>Search For a National Park</h1>
		<form action="showpark.do" method="GET">
			By State: <select name="state">
				<c:forEach items="${states}" var="state">
					<option value="${state}">${state}</option>
				</c:forEach>
			</select> <input type="submit" value="Submit" />
		</form>
	</div>
	<div>
		<form action="results.do" method="GET">
			By Keyword: <input type="text" name="keyword"
				placeholder="keyword search" /> <input type="submit" value="Submit" />
		</form>
	</div>

	<jsp:include page="bootstrapLower.jsp" />

</body>
</html>
