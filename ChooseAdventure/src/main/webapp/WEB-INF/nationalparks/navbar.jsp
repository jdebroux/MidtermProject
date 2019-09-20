<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="NavBar.css" />
<nav
	class="navbar fixed-top navbar-inverse bg- navbar-expand-sm inline justify-content-center">
	<div class="collapse navbar-collapse">

		<form action="index.do" method="GET">
			<font color="white">
				<button type="submit" class="btn btn-link" value="Home">Home</button>
			</font>
		</form>


		<div class="dropdown show">
			<a class="btn btn-dropdownMenuLink dropdown-toggle" href="#"
				role="button" id="dropdownMenuLink" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false"> Parks </a>

			<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">

				<a class="dropdown-item" href="#"><form action="results.do"
						method="GET">
						<button type="submit" class="btn btn-link" name="keyword">See
							All Parks</button>
					</form></a> <a class="dropdown-item" href="#"><form action="search.do"
						method="GET">
						<button type="submit" class="btn btn-link"
							value="Search For Parks">Search For Parks</button>
					</form></a>
			</div>
		</div>

		<c:if test="${empty loggedIn }">


			<div class="dropdown show">
				<a class="btn btn-dropdownMenuLink dropdown-toggle" href="#"
					role="button" id="dropdownMenuLink" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> Login </a>

				<div class="dropdown-menu dropdwon-menu-right"
					aria-labelledby="dropdownMenuLink">

					<a class="dropdown-item" href="#">
						<div class="dropdown-content">

							<form action="login.do" method="POST" modelAttribute="account">

								<input type="text" name="username" placeholder="username" /> <input
									type="password" name="password" placeholder="password" /> <input
									type="submit" value="Submit" />

							</form>


							<a class="dropdown-item" href="#"><form
									action="userprofile.do" method="POST">
									<button type="submit" class="btn btn-link"
										value="Create Account">Create Account</button>
								</form></a>
						</div>
				</div>
		</c:if>
		<c:if test="${! empty loggedIn }">
			<form action="logout.do" method="POST">
				<button type="submit" class="btn btn-link" value="Logout">Logout</button>
			</form>
			<form action="gotobucketlist.do" method="POST">
				<button type="submit" class="btn btn-link">See Trips</button>
			</form>
		</c:if>
	</div>
	</div>

</nav>
