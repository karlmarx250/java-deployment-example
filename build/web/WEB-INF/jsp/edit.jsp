<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
 
</head>
<body>
    <div class="container-fluid">
    <a href="index.htm" class="btn btn-dark border-bottom w-50 mb-3">Home</a>
    <h1 class="m-auto">Edit Product</h1>
    <div class="container">
        <div class="mt-3">
          
          
        </div>
        
        <div class="container form">
            <form method="POST" class="form col-8 m-auto">
                <input type="text" name="id" class="label form-control" value="${EditProduct[0].id}" placeholder="id"><br>
                <input type="text" name="name" class="label form-control" value="${EditProduct[0].name}" placeholder="name"><br>
                <input type="text" name="description" class="label form-control" value="${EditProduct[0].department}" placeholder="description"><br>
                <input type="text" name="price" class="label form-control" value="${EditProduct[0].price}" placeholder="price"><br>
                <img src="data:image/jpeg;base64,<c:out value="${EditProduct[0].imageBase64}" />" alt="Product Image"><br>
                <hr class="border-2 border-primary rounded rounded-3">
                <input type="Submit" value="Submit" class="btn btn-dark w-100"><br>
            </form>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.5.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
