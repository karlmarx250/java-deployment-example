<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    <script>
        function validateForm() {
            var name = document.forms["myForm"]["name"].value;
            var description = document.forms["myForm"]["description"].value;
            var price = document.forms["myForm"]["price"].value;
            var image = document.forms["myForm"]["image"].value;

            if (name == "") {
                alert("Please enter a name.");
                return false;
            }

            if (description == "") {
                alert("Please enter a description.");
                return false;
            }

            if (price == "") {
                alert("Please enter a price.");
                return false;
            }

            if (image == "") {
                alert("Please select an image.");
                return false;
            }

            return true;
        }
    </script>
    
    <style>
        .form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 4px;
        }
        
        .label {
            margin-bottom: 10px;
        }
        
        .btn {
            background-color: #007bff;
            color: #fff;
            border: none;
        }
        
        .btn:hover {
            background-color: #0069d9;
            color: #fff;
        }
    </style>
 <link rel="stylesheet" href="navbar.css">
</head>
<body>
<nav class="navbar">
        <a class="navbar-brand" href="#">logo</a>
  
        <ul>
            <li><a href="home.htm">Home</a></li>
        </ul>
    
        <ul>
            <li><a href="index.htm">Logout</a></li>
        </ul>
    </nav>
    <div class="text-center">
        <h1>NEW Product</h1>
    </div>
    <div class="container form">
        <form method="POST" name="myForm" onsubmit="return validateForm()" enctype="multipart/form-data">
            <input type="text" name="name" placeholder="Enter Name" class="form-control label"><br>
            <input type="text" name="description" placeholder="Enter Description" class="form-control label"><br>
            <input type="number" name="price" placeholder="Enter Price" class="form-control label"><br>
            <hr>
            <input type="file" name="imageFile" class="form-control label" alt="Product Image"><br>
            <input type="submit" value="Submit" class="btn btn-primary">
        </form>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.5.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
