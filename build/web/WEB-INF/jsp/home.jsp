<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <style>
        .profile {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #f5f5f5;
            height: 110px;
           box-sizing: border-box;

            
        }
.profile p{
    display: inline-block;
    padding: 2px;
}

        .product-card {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
        }
        
        .cart-icon {
            position: fixed;
            top: 20px;
            right: 10px;
            cursor: pointer;
            padding-right: 20px;
        }
        
        .cart-icon img {
            width: 30px;
        }
        
        .notification-sign {
            position: absolute;
            top: -5px;
            right: -5px;
            width: 10px;
            height: 10px;
            background-color: red;
            border-radius: 50%;
        }
    </style>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2>Available Products</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="cart-icon">
                    <a href="cartView.htm">
                        <img src="cart-icon.png" alt="Cart">
                        <c:if test="${not empty cartItems}">
                            <div class="notification-sign"></div>
                        </c:if>
                    </a>
                </div>
            </div>
        </div>
    
        
        <div class="row h-50 p-0 sticky-top ">
            <div class="col-md-9 mb-5 ">
                <div class="profile d-inline ">
                    <h2 class=" fw-bold  ">User Profile</h2>
                    <p class=" bg-light shadow p-1 mb-5 bg-body-tertiary rounded">Username: ${currentUser.username}</p>
                    <p class=" bg-light shadow p-1 mb-5 bg-body-tertiary rounded">Email: ${currentUser.email}</p>
                    <p class=" bg-light shadow p-1 mb-5 bg-body-tertiary rounded">Joined At: ${currentUser.createdAt}</p>
                <div class="cart-icon">
        <a href="cartView.htm">
            <img src="cart-icon.png" alt="Cart">
            <c:if test="${not empty cartItems}">
                <div class="notification-sign"></div>
            </c:if>
        </a>
    </div>
                </div>
            </div>
        </div>
    </div>
    
  

    <div class="container mt-lg-5">
        <h2>Available Products</h2>
        <div class="row">
            <c:forEach var="product" items="${ProductList}">
                <div class="col-md-4">
                    <div class="card product-card p-2 h-50">
                        <img src="data:image/jpeg;base64,${product.imageBase64}" class="card-img-top card-img" alt="Product Image" style="">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">${product.description}</p>
                            <p class="card-text">Price: $${product.price}</p>
                            <button class="btn btn-primary btn-outline-dark" onclick="addToCart(${product.id}, ${product.price}, '${product.name}', ${product.price})">Add to Cart</button>
                            <button class="btn btn-secondary "><a href="prod_details.htm?id=${product.id}" style="color: white;">View Details</a></button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Include Bootstrap JS -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script>
        function addToCart(productId, price, productName, productPrice) {
            // Check if the user is logged in
            var currentUser = '${currentUser}';
            if (currentUser != null && currentUser.length > 0) {
                var quantity = prompt("Enter the quantity:", "1");

                if (quantity != null && quantity !== "" && !isNaN(quantity)) {
                    var totalPrice = parseFloat(quantity) * parseFloat(price);

                    var form = document.createElement("form");
                    form.method = "POST";
//                    form.action = "prod_details.htm";

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
                    userIdInput.value = ${currentUser.id}; 

                    var productNameInput = document.createElement("input");
                    productNameInput.type = "hidden";
                    productNameInput.name = "productName";
                    productNameInput.value = productName;

                    var productPriceInput = document.createElement("input");
                    productPriceInput.type = "hidden";
                    productPriceInput.name = "productPrice";
                    productPriceInput.value = productPrice;

                    form.appendChild(productIdInput);
                    form.appendChild(quantityInput);
                    form.appendChild(totalPriceInput);
                    form.appendChild(userIdInput);
                    form.appendChild(productNameInput);
                    form.appendChild(productPriceInput);

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
