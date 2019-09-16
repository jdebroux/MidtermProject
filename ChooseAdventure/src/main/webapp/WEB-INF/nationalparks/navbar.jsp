<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="navbar navbar-inverse">
	<button onclick="index.do">Home</button>
	<button onclick="results.do">See All Parks</button>
	<form action="search.do" method="GET">
		<button type="submit" class="btn btn-primary" value="Search By State" >Search By State</button>
	</form>
	<div class="dropdown">
		<button class="dropbtn">
			Login
			<div class="dropdown-content">
				<form action="login.do">
					<input type="text" name="username" placeholder="username" /> <input
						type="text" name="password" placeholder="password" /> <input
						type="submit" value="Submit" />
				</form>
			</div>
		</button>
	</div>
</div>