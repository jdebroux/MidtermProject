<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="navbar navbar-inverse">
	<form action="index.do" method="GET">
		<button type="submit" class="btn btn-primary" value="Home" >Home</button>
		</form>
	<form action="results.do" method="GET">
		<button type="submit" class="btn btn-primary" value="See All Parks" >See All Parks</button>
		</form>
	<form action="search.do" method="GET">
		<button type="submit" class="btn btn-primary" value="Search By State" >Search By State</button>
	</form>
	<div class="dropdown">
		<button class="dropbtn">
			Login
			<div class="dropdown-content">
				<form action="login.do" >
					<input type="text" name="username" placeholder="username" /> <input
						type="text" name="password" placeholder="password" /> <input
						type="submit" value="Submit" />
				</form>
			</div>
		</button>
	</div>
</div>