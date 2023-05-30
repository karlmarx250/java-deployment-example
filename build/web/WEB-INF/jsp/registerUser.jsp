<%-- 
    Document   : registerUser
    Created on : May 18, 2023, 4:28:31 PM
    Author     : w
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
 <link rel="stylesheet" href="navbar.css">
</head>
<body>
<nav class="navbar navbar-dark navbar-expand p-0 bg-dark">
<div class="container-fluid">
    <ul class="navbar-nav d-none d-md-flex mr-auto">
		 <li class="nav-item">
		    <div class="d-flex flex-row">
		        <img src="https://i.imgur.com/EYFtR83.jpg" class="rounded-circle" width="30">
		    </div>
		</li>
		<li class="nav-item">
		    <a href="#" class="nav-link d-flex align-items-center" data-abc="true"><span> ${currentUser.username} </span><i class='bx bxs-chevron-down'></i></a>
		</li>
		<li class="nav-item"><a class="nav-link" href="home.htm" data-abc="true">Home</a></li>
		
    </ul>
    <ul class="navbar-nav d-flex align-items-center">
       
		<li class="nav-item">
		    <a href="index.htm" class="nav-link d-flex align-items-center" data-abc="true"><span>Logout</span><i class='bx bxs-chevron-down'></i></a>
		</li>
		
	</ul> 
  </div> 

</nav>
    <div class="container">
        <h1>Register</h1>
    
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>
        </c:if>
        <form method="POST" class="col-6 m-auto">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" name="username" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" class="form-control" name="confirmPassword" required>
            </div>
            <input type="submit" class="btn btn-outline-primary mt-2 w-100" name="register" value="Register">
        </form>
    </div>
</body>
</html>
