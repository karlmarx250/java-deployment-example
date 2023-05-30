/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */


function addToCart(productId, price) {
    var currentUser = '${currentUser}';
    if (currentUser != null && currentUser.length > 0) {
        var quantityInput = document.getElementById("quantityInput");
        var quantity = quantityInput.value.trim();

        if (quantity !== "" && !isNaN(quantity)) {
            var totalPrice = parseFloat(quantity) * parseFloat(price);
            window.location.href = "prod_details.htm?id=" + productId + "&quantity=" + quantity + "&totalPrice=" + totalPrice.toFixed(2) + "&userId=" + currentUser[0].id;

            alert("Product added to cart! Total Price: $" + totalPrice.toFixed(2));
        } else {
            alert("Invalid quantity!");
        }
    } else {
        alert("Please login to add products to your cart.");
        window.location.href = "login.htm";
    }
}
