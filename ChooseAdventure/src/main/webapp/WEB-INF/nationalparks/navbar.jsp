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