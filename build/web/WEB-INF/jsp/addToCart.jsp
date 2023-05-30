<%-- 
    Document   : addToCart
    Created on : May 20, 2023, 5:52:47 PM
    Author     : w
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add to Cart</title>
 <link rel="stylesheet" href="navbar.css">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <style>
        /* CSS for modal dialog */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
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
    <h1>Add to Cart</h1>
    <c:if test="${not empty errorMessage}">
        <p style="color: red">${errorMessage}</p>
    </c:if>
    <c:if test="${not empty successMessage}">
        <p style="color: green">${successMessage}</p>
    </c:if>

    <button onclick="openModal(${productId})">Add to Cart</button>

    <!-- Modal dialog -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <form id="addToCartForm" action="addToCart.htm" method="post">
                <input type="hidden" name="productId" id="productId" value="">
                <label for="quantity">Quantity:</label>
                <input type="number" name="quantity" id="quantity" required>
                <br>
                <input type="submit" value="Add to Cart">
            </form>
        </div>
    </div>

    <script>
        // Open the modal dialog and set the product ID
        function openModal(productId) {
            document.getElementById('productId').value = productId;
            document.getElementById('myModal').style.display = 'block';
        }

        // Close the modal dialog
        function closeModal() {
            document.getElementById('myModal').style.display = 'none';
        }

        // Submit the form when the user clicks outside the modal
        window.onclick = function(event) {
            var modal = document.getElementById('myModal');
            if (event.target == modal) {
                document.getElementById('addToCartForm').submit();
            }
        };
    </script>
</body>
</html>
