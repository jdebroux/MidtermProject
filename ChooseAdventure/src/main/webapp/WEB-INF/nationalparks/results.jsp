<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<div class="dropdown">
	<button class="dropbtn">
		Login
		<div class="dropdown-content">
			<form action="login.do">
				<input type="text" name="username" placeholder="username" /> <input
					type="text" name="password" placeholder="password" />
			</form>
		</div>
	</button>
</div>
</div>

<div>
</head>
<body>
	<h3>Parks in {location.state}</h3>
	
	<c:choose>
		<c:when test="${! empty national_park.id }">
	
	<ul style="list-style: none;">
		<c:forEach items="${national_park }" var="park">

			<li><a href="results.do?cid=${national_park.id }}"> 
		</c:forEach>
	</ul>
			<ul style="list-style: none;">
				<li>${national_park.name}</li>
				<li>${national_park.description}</li>
				<li>${location.state}</li>
				<li>${national_park.link_nps}</li>
			</ul>
		</c:when>
		
		<c:otherwise>
			<h4>No Park found</h4>
		</c:otherwise>
	</c:choose>
</body>
</html>