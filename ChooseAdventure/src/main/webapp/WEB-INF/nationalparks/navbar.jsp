<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

	<nav
		class="navbar navbar-inverse navbar-expand-sm inline justify-content-center">

		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#myNavbar">
	</button>
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

					<div class="dropdown">
						<button class="dropbtn">

							Login
							<div class="dropdown-content">

								<form action="login.do" method="POST" modelAttribute="account">

									<input type="text" name="username" placeholder="username" /> 
									<input type="password" name="password" placeholder="password" /> 
									<input type="submit" value="Submit" />
									
								</form>
							</div>
						</button>

					</div>

					<form action="userprofile.do" method="POST">
						<button type="submit" class="btn btn-primary"
							value="Create Account">Create Account</button>
					</form>


				</div>
			</div>
	</nav>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>

</body>
</html>