<%-- 
    Document   : allUsers
    Created on : May 18, 2023, 4:13:45 PM
    Author     : w
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>users view</title>
 <link rel="stylesheet" href="navbar.css">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
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
          
        <a href="registerUser.htm"class=" text-decoration-none btn btn-outline-dark m-4">new user</a>
        
        <table class="table table-dark table-borderless table-striped table-hover rounded rounded-3 overflow-hidden">
            <tr>
                <th>ID</th>   
                 <th>NAME</th>   
                  <th>EMAIL</th> 
                  <th>JOINED TIME</th> 
                  <th>Action</th> 
                
            </tr>   
            <c:forEach items="${Users}" var="user">
                <tr>
                    <td>${user.id}</td>    
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                    <td>${user.created_At}</td>
                    
                    <td>
                        
                        <a href="edit.htm?id=${user.id}" class="text-decoration-none btn btn-outline-warning">EDIT</a>    
                         <a href="delete.htm?id=${user.id}" class="text-decoration-none btn btn-outline-danger">DELETE</a> 
                    </td>
                    
                </tr>
            </c:forEach>
        </table>

    </body>
</html>
