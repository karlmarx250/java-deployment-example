<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
   
    <style>
        .payment-card {
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .payment-card .card-title {
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
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
<div class="container p-4">
    <h2 class="mt-4">Payment</h2>

    <div class="row p-3 ">
        <div class="col-md-6  shadow p-3 mb-5 bg-body-tertiary rounded mr-4 ml-4">
            <h4>Checkout Items:</h4>
            <div class="card mb-3 border-0 mr-4 ml-4">
                <div class="card-body">
                    <h5 class="card-title">Checkout Items:</h5>
                    <div id="productTable" style="display: none;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Map<String, Object>> cartItems = (List<Map<String, Object>>) request.getAttribute("cartItems");
                                double totalPrice = (double) request.getAttribute("totalPrice");

                                if (cartItems != null && !cartItems.isEmpty()) {
                                    for (Map<String, Object> item : cartItems) {
                                        String productName = (String) item.get("productName");
                                        int quantity = (int) item.get("quantity");
                                        double unitPrice = (double) item.get("unitPrice");
                                        double itemTotalPrice = quantity * unitPrice;
                                %>
                                <tr>
                                    <td><%= productName %></td>
                                    <td><%= quantity %></td>
                                    <td><%= unitPrice %></td>
                                    <td><%= itemTotalPrice %></td>
                                </tr>
                                <% 
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="4">No items in cart</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col text-right">
                                <button id="collapseTableBtn" class="btn btn-link">Collapse</button>
                            </div>
                        </div>
                    </div>
                    <div id="totalPriceSection">
                        <div class="row">
                            <div class="col text-right">
                                <h4>Total Price: <%= totalPrice %></h4>
                                <button id="expandTableBtn" class="btn btn-link">Show All</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 shadow p-3 mb-5 bg-body-tertiary rounded mr-4 m-1">
            <h4>Payee Details:</h4>
            <div class="card mb-3 border-0 mr-4 ml-4">
                <div class="card-body">
                    <h5 class="card-title">Payee Details:</h5>
                    <p>Username: <%= request.getAttribute("username") %></p>
                    <p>Email: <%= request.getAttribute("email") %></p>
                </div>
            </div>
        </div>
    </div>

    <form id="paymentForm" method="post" onsubmit="return validatePaymentForm()">
        <div class="form-group">
            <label for="paymentMethod">Payment Method:</label>
            <select class="form-control" name="paymentMethod" id="paymentMethod">
                <option value="visa">Visa Card</option>
                <option value="mobileMoney">Mobile Money</option>
            </select>
        </div>

        <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
        <input type="hidden" name="cartItems" value="<%= cartItems %>">
        <div id="visaCardForm" style="display: none;">
            <div class="payment-card mb-4">
                <h4 class="card-title">Visa Card Details:</h4>
                <div class="form-group">
                    <label for="cardNumber">Card Number:</label>
                    <div class="input-group">
                        <input type="text" class="form-control" name="cardNumber" id="cardNumber" required>
                        <div class="input-group-append">
                            <span class="input-group-text"><i class="fas fa-credit-card"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="mobileMoneyForm" style="display: none;">
            <div class="payment-card mb-4">
                <h4 class="card-title">Mobile Money Details:</h4>
                <div class="form-group">
                    <label for="mobileNumber">Mobile Number:</label>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">+250</span>
                        </div>
                        <input type="text" class="form-control" name="mobileNumber" id="mobileNumber" required>
                    </div>
                </div>
            </div>
        </div>

        <button type="submit" class="btn btn-primary  mt-3">Pay Now</button>
    </form>

   
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>

    <script>
        document.getElementById("paymentMethod").addEventListener("change", function() {
            var selectedPaymentMethod = this.value;
            var visaCardForm = document.getElementById("visaCardForm");
            var mobileMoneyForm = document.getElementById("mobileMoneyForm");

            if (selectedPaymentMethod === "visa") {
                visaCardForm.style.display = "block";
                mobileMoneyForm.style.display = "none";
            } else if (selectedPaymentMethod === "mobileMoney") {
                visaCardForm.style.display = "none";
                mobileMoneyForm.style.display = "block";
            } else {
                visaCardForm.style.display = "none";
                mobileMoneyForm.style.display = "none";
            }

       
            var form = document.getElementById("paymentForm");
            var totalPriceInput = document.querySelector('input[name="totalPrice"]');
            form.action = "processPayment.htm?paymentMethod=" + selectedPaymentMethod + "&totalPrice=" + totalPriceInput.value;
        });

        function validatePaymentForm() {
            var paymentMethod = document.getElementById("paymentMethod").value;
            var cardNumber = document.getElementById("cardNumber");
            var mobileNumber = document.getElementById("mobileNumber");
            var errorMessage = "";

            // Check if both payment methods are selected
            var visaCardForm = document.getElementById("visaCardForm");
            var mobileMoneyForm = document.getElementById("mobileMoneyForm");

            if (visaCardForm.style.display !== "none" && mobileMoneyForm.style.display !== "none") {
                errorMessage = "Please select only one payment method.";
            } else if (paymentMethod === "visa") {
                if (!validateVisaCardNumber(cardNumber.value)) {
                    errorMessage = "Invalid Visa card number. It should have 16 digits.";
                }
            } else if (paymentMethod === "mobileMoney") {
                if (!validateMobileMoneyNumber(mobileNumber.value)) {
                    errorMessage = "Invalid Mobile Money number. It should start with 078 or 079 and have 10 digits.";
                }
            } else {
                errorMessage = "Please select a payment method.";
            }

            if (errorMessage) {
                alert(errorMessage);
                return false;
            }

        
            if (paymentMethod === "visa") {
                mobileNumber.value = "";
            } else if (paymentMethod === "mobileMoney") {
                cardNumber.value = "";
            }

       
            var formData = {
                paymentMethod: paymentMethod,
                cardNumber: cardNumber.value,
                mobileNumber: mobileNumber.value
            };
            alert(JSON.stringify(formData));

            return true;
        }

        function validateVisaCardNumber(cardNumber) {
            var visaCardRegex = /^\d{16}$/;
            return visaCardRegex.test(cardNumber);
        }

        function validateMobileMoneyNumber(mobileNumber) {
            var mobileMoneyRegex = /^(078|079)\d{7}$/;
            return mobileMoneyRegex.test(mobileNumber);
        }
    </script>
</div>
</body>
</html>
