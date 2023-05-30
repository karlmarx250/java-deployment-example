<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
     <link rel="stylesheet" href="navbar.css">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <style>
        .profile {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #f5f5f5;
            padding: 10px;
        }

        .product-card {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
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
    <h2>Available Products</h2>
    <div class="container">
        <div class="row">
            <c:forEach var="product" items="${ProductList}">
                <div class="col-md-4">
                    <div class="card product-card">
                        <img src="data:image/jpeg;base64,${product.imageBase64}" class="card-img-top" alt="Product Image">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">${product.description}</p>
                            <p class="card-text">Price: $${product.price}</p>
                            <button class="btn btn-primary" onclick="addToCart(${product.id}, ${product.price})">Add to Cart</button>
                            <button class="btn btn-secondary"><a href="checkout.htm?id=${product.id}" style="color: white;">View Details</a></button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Include Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        function addToCart(productId, price) {
            // Check if the user is logged in
            var currentUser = '${currentUser}';
            if (currentUser != null && currentUser.length > 0) {
                var quantity = prompt("Enter the quantity:", "1");

                if (quantity != null && quantity !== "" && !isNaN(quantity)) {
                    var totalPrice = parseFloat(quantity) * parseFloat(price);

                    var form = document.createElement("form");
                    form.method = "post";
                    form.action = "viewCart.htm";

                    var productIdInput = document.createElement("input");
                    productIdInput.type = "hidden";
                    productIdInput.name = "id";
                    productIdInput.value = productId;

                    var quantityInput = document.createElement("input");
                    quantityInput.type = "hidden";
                    quantityInput.name = "quantity";
                    quantityInput.value = quantity;

                    var totalPriceInput = document.createElement("input");
                    totalPriceInput.type = "hidden";
                    totalPriceInput.name = "totalPrice";
                    totalPriceInput.value = totalPrice.toFixed(2); // Rounded to 2 decimal places

                    var userIdInput = document.createElement("input");
                    userIdInput.type = "hidden";
                    userIdInput.name = "userId";
                    userIdInput.value = currentUser[0].id; // Assuming user ID is stored in 'id' field

                    form.appendChild(productIdInput);
                    form.appendChild(quantityInput);
                    form.appendChild(totalPriceInput);
                    form.appendChild(userIdInput);

                    document.body.appendChild(form);
                    form.submit();

                    alert("Product added to cart! Total Price: $" + totalPrice.toFixed(2));
                } else {
                    alert("Invalid quantity!");
                }
            } else {
                alert("Please login to add products to your cart.");
                window.location.href = "login.htm";
            }
        }
    </script>
</body>
</html>
