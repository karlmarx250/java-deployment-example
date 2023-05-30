<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
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
<div class="container">
    <h2>Cart</h2>

    <table class="table table-dark table-borderless table-striped table-hover rounded rounded-3 overflow-hidden">
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total Price</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td>${item.productName}</td>
                <td>${item.quantity}</td>
                <td>${item.unitPrice}</td>
                <td>${item.unitPrice * item.quantity}</td>
                <td>
                    <button class="btn btn-sm btn-danger" onclick="removeFromCart(${item.id})">Remove</button>
                    <button class="btn btn-sm btn-primary" onclick="replaceProduct(${item.id})">Replace</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="3">Total:</th>
            <th>${totalPrice}</th>
            <th></th>
        </tr>
        </tfoot>
    </table>
            
   <form id="checkoutForm" action="checkout.htm" method="post">
    <button class="btn btn-primary" type="submit">Checkout</button>
</form>
    <button class="btn  btn-outline-info  mt-3 mr-1" onclick="continueShopping()">Continue Shopping</button>
    <button class="btn  btn-outline-danger mt-3" onclick="cancelCart()">Cancel Cart</button>
    

</div>

<!-- Include Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- ... -->
<script>
    function removeFromCart(productId) {
        document.getElementById("removeFormProductId").value = productId;
        document.getElementById("removeForm").submit();
    }

    function replaceProduct(productId) {
        if (${not empty currentUser}) {
            window.location.href = "replaceProduct.htm?productId=" + productId;
        } else {
            window.location.href = "login.htm";
        }
    }

    function continueShopping() {
        alert("Redirecting to continue shopping page...");
        window.location.href = "home.htm";
    }

    function cancelCart() {
        var confirmation = confirm("Are you sure you want to cancel the cart? This will remove all items.");

        if (confirmation) {
            document.getElementById("cancelAllForm").submit();
        } else {
            alert("Cart cancellation canceled.");
        }
    }

function checkout() {
    document.getElementById("checkoutForm").submit();
}


</script>
<!-- ... -->

<!-- Hidden forms -->
<form id="removeForm" action="removeFromCart.htm" method="post">
    <input type="hidden" id="removeFormProductId" name="productId" value="">
</form>

<form id="cancelAllForm" action="cancelAllCart.htm" method="post"></form>

</body>
</html>
