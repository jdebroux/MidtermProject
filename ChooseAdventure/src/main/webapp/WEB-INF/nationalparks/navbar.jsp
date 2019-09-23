<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<style>
.navbar {
	height: 50px;
}

.collapse navbar-collapse {
	font-size: 12px;
	color: white !important;
}
/* .navbar-inverse {
    background: linear-gradient(#8c8c8c, #c4c4c4);
} */
.navbar-header a {
	height: 120px;
	width: auto;
	padding-top: 3px;
	color: white !important;
}

.btn {
	background-color: 353A3F;
	border: none;
	color: Dodger-Blue;
	/* padding: 12px 16px; */
	font-size: 22px;
	text-shadow: 2px 2px #000000;
	cursor: pointer;
} 

.navbar-brand {
	color: Dodger-Blue;
	font-size: 26;
	padding: 30px; 
}

.dropdown-item {
	background-color: #353A3F;
	border: none;
	color: Dodger-Blue;
	/* padding: 12px 16px; */
	font-size: 22px;
	text-shadow: 0px 0px #000000;
}

.btn2 {
	border: none;
	color: Dodger-Blue;
	/* padding: 12px 16px; */
	font-size: 22px;
	text-shadow: 0px 0px #000000;
}

.dropdown-menu {
background-color: #353A3F; }

</style>




<nav
	class="navbar fixed-top navbar-inverse bg-dark navbar-expand-sm inline justify-content-center">
	<div class="collapse navbar-collapse">

<form action="index.do" method="GET">
			<button type="submit" class="btn btn-link" value="Home">Home
			</button>
		</form>
		

		<div class="navbar-brand" >Your Adventure Planner</div>



		

		<div class="dropdown show">
			<div class="btn btn-dropdownMenuLink dropdown-toggle" 
				role="button" id="dropdownMenuLink" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false"> Parks </div>

			<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">

				<div class="dropdown-item"><form action="results.do"
						method="GET">
						<button type="submit" class="btn2 btn-link" name="keyword">See
							All Parks</button>
					</form></div> <div class="dropdown-item" ><form action="search.do"
						method="GET">
						<button type="submit" class="btn2 btn-link"
							value="Search For Parks">Search For Parks</button>
					</form></div>
			</div>
		</div>

		<c:if test="${empty loggedIn }">


			<div class="dropdown show">
				<div class="btn btn-dropdownMenuLink dropdown-toggle" 
					role="button" id="dropdownMenuLink" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> Login </div>

				<div class="dropdown-menu dropdwon-menu-left"
					aria-labelledby="dropdownMenuLink">

					<div class="dropdown-item" >
						<div class="dropdown-content">

							<form action="login.do" method="POST" modelAttribute="account">

								<input type="text" name="username" placeholder="username" /> <input
									type="password" name="password" placeholder="password" /> <input
									type="submit" value="Submit" />

							</form>


							<div class="dropdown-item" ><form
									action="userprofile.do" method="POST">
									<button type="submit" class="btn2 btn-link"
										value="Create Account">Create Account</button>
								</form></div>
						</div>
				</div>
				</div>
			</div>
		</c:if>
		<c:if test="${! empty loggedIn }">

			<div class="dropdown show">
				<div class="btn btn-dropdownMenuLink dropdown-toggle" 
					role="button" id="dropdownMenuLink" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> Account </div>

				<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">

					<div class="dropdown-item" >

						<form action="logout.do" method="POST">
							<button type="submit" class="btn2 btn-link" value="Logout">Logout</button>
						</form>
					</div> <div class="dropdown-item" ><form action="seeprofile.do"
							method="POST">
							<button type="submit" class="btn2 btn-link" value="Profile">Profile
							</button>
						</form></div>
				</div>
			</div>
			<form action="gotobucketlist.do" method="POST">
				<button type="submit" class="btn btn-link">Bucket List</button>
			</form>

		</c:if>
		
		<%-- <form action="about.do" method="POST">
				<button type="submit" class="btn btn-link">About</button>
			</form> --%>
		

	</div>

</nav>