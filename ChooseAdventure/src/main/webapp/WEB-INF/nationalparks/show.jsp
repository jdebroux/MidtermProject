<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="navbar">
	<button onclick="index.do"> Home</button> 
	<button onclick="results.do"> See All Parks</button>
	<button onclick="search.do"> Search</button>
	
	<div class="dropdown">
		<button class="dropbtn">
			Login 
		<div class="dropdown-content">
			<form action="login.do">
			 <input type="text" name="username" placeholder="username"/> 
			 <input type="text" name="password" placeholder="password"/> 
			</form>
		</div>
		</button>
	</div>
</div>

<div>
		<h3>
			<a href="/">Main Menu</a>
		</h3>
		<h2>Chess Game Results</h2>
		<c:choose>
			<c:when test="${! empty chess.id }">

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
	</div>
	
	<input type="submit" value="Plan a Trip" />
	<input type="submit" value="Save Trip" /> 
	
	





</body>
</html>