<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<nav
	class="navbar navbar-inverse navbar-expand-sm inline justify-content-center">

	<button type="button" class="navbar-toggle" data-toggle="collapse"
		data-target="#myNavbar"></button>
	<div class="container-fluid">
		<div class="navbar-header">

			<form action="index.do" method="GET">

				<button type="submit" class="btn btn-primary" value="Home">Home</button>

			</form>
			<form action="results.do" method="GET">
				<button type="submit" class="btn btn-primary" name="keyword">See
					All Parks</button>
			</form>
			<form action="search.do" method="GET">
				<button type="submit" class="btn btn-primary"
					value="Search For Parks">Search For Parks</button>
			</form>
			<c:if test="${empty loggedIn }">
				<div class="dropdown">
					<button class="dropbtn">

						Login
						<div class="dropdown-content">

							<form action="login.do" method="POST" modelAttribute="account">

								<input type="text" name="username" placeholder="username" /> <input
									type="password" name="password" placeholder="password" /> <input
									type="submit" value="Submit" />

							</form>
						</div>
					</button>

				</div>

				<form action="userprofile.do" method="POST">
					<button type="submit" class="btn btn-primary"
						value="Create Account">Create Account</button>
				</form>
			</c:if>
			<c:if test="${! empty loggedIn }">
				<form action="logout.do" method="POST">
					<button type="submit" class="btn btn-primary" value="Logout">Logout</button>
				</form>
				<form action="bucketlist.do" method="GET">
					<button type="submit" class="btn btn-primary">See Trips</button>
				</form>
			</c:if>


		</div>
	</div>
</nav>