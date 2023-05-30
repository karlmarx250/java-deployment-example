/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import config.*;
//import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
//import jdk.internal.org.objectweb.asm.TypeReference;

import model.UserDetails;
import model.dbModel;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.*;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


public class Mycontroller {
//    private static final Logger logger = Logger.getLogger(Mycontroller.class);
   ConnectionConf con =new ConnectionConf() ;
   JdbcTemplate jdbctemp= new JdbcTemplate (con.Connect());
    ModelAndView mv =new ModelAndView ();
    JdbcTemplate jdbcTemplate = new JdbcTemplate(con.Connect());
    List<Map<String, Object>> cartItems = new ArrayList<>();
    double totalPrice = 0;
    List Datas;
    List userList;
    List currentUserList;
    List homeProductList;
    List viewProdById;
   
    

    
    
      @RequestMapping(value="index.htm")
public ModelAndView listProductsIndex() {
    String sql = "SELECT * FROM products";
    List<Map<String, Object>> allProdAtIndexPage = this.jdbctemp.queryForList(sql);

    for (Map<String, Object> product : allProdAtIndexPage) {
        byte[] imageBytes = (byte[]) product.get("image");
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        product.put("imageBase64", base64Image);
    }

    ModelAndView mv = new ModelAndView();
    mv.addObject("ProductList", allProdAtIndexPage);
    mv.setViewName("index");
    return mv;
}

  @RequestMapping(value="adminIndex.htm")
public ModelAndView listProducts() {
    String sql = "SELECT * FROM products";
    List<Map<String, Object>> products = this.jdbctemp.queryForList(sql);

    for (Map<String, Object> product : products) {
        byte[] imageBytes = (byte[]) product.get("image");
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        product.put("imageBase64", base64Image);
    }

    ModelAndView mv = new ModelAndView();
    mv.addObject("ProductList", products);
    mv.setViewName("adminIndex");
    return mv;
}







   
   
     @RequestMapping(value="allUsers.htm")
   public ModelAndView Users(){
        String sql="select * from users";
    userList=this.jdbctemp.queryForList(sql);
    mv.addObject("Users",userList);
    mv.setViewName("allUsers");
    return mv;
    }
   
   
//        @RequestMapping(value="home.htm",method=RequestMethod.GET)
//   public ModelAndView AddCartTest(){
//   mv.addObject(new CartItem());
//   mv.setViewName("home");
//   
//   return mv;        
//   
//   
//   }
   
   
//       @RequestMapping(value="home.htm",method=RequestMethod.POST)
//   public ModelAndView AddCartTest(CartItem u){
//   String sql ="INSERT INTO cart (userId, productId, productName, quantity, totalPrice) VALUES (?, ?, ?, ?, ?)";
//   this.jdbctemp.update(sql,u.getUserId(),u.getProductId(),u.getProductName(),u.getQuantity(),u.getTotalPrice());
//   
//   return new ModelAndView("redirect:prod_details.htm") ;        
//   
//   
//   }
   
   
      @RequestMapping(value="registerUser.htm",method=RequestMethod.GET)
   public ModelAndView AddUser(){
   mv.addObject(new UserDetails());
   mv.setViewName("registerUser");
   
   return mv;        
   
   
   }
   
   
   
        @RequestMapping(value="registerUser.htm",method=RequestMethod.POST)
   public ModelAndView AddUser(UserDetails u){
   String sql ="insert into users (username,password,email,role)value(?,?,?,?)";
   this.jdbctemp.update(sql,u.getUsername(),u.getPassword(),u.getEmail(),u.getRole());
   
   return new ModelAndView("redirect:allUsers.htm") ;        
   
   
   }
   
   
       @RequestMapping(value="login.htm")
   public ModelAndView UserLoging(){
        String sql="select * from users";
   currentUserList=this.jdbctemp.queryForList(sql);
    mv.addObject("currentUser",currentUserList);
    mv.setViewName("login");
    return mv;
    } 
   
   
      

   


   

   
   
    
     @RequestMapping(value="register.htm",method=RequestMethod.GET)
   public ModelAndView AddProduct(){
   mv.addObject(new dbModel());
   mv.setViewName("register");
   
   return mv;        
   
   
   }
   

   
   
@RequestMapping(value = "register.htm", method = RequestMethod.POST)
public ModelAndView AddProduct(@ModelAttribute dbModel p, @RequestParam(value = "image", required = false) MultipartFile image) {
    if (image != null && !image.isEmpty()) {
        try {
            byte[] imageBytes = image.getBytes();
            p.setImage(imageBytes);
        } catch (IOException e) {
            e.printStackTrace();
        }
    } else {
        // Set a default image
        byte[] defaultImage = getDefaultImage(); 
        p.setImage(defaultImage);
    }

    String sql = "INSERT INTO products (name, description, price, image) VALUES (?, ?, ?, ?)";
    this.jdbctemp.update(sql, p.getName(), p.getDescription(), p.getPrice(), p.getImage());

    return new ModelAndView("redirect:index.htm");
}

private byte[] getDefaultImage() {
    String sql = "SELECT image FROM default_images WHERE id = ?";
    byte[] defaultImage = null;
    try {
        defaultImage = this.jdbctemp.queryForObject(sql, new Object[]{1}, byte[].class);
    } catch (EmptyResultDataAccessException e) {
        e.printStackTrace();
    }
    return defaultImage;
}


   
   
     @RequestMapping(value="prod_details.htm",method=RequestMethod.GET)
   public ModelAndView prodById( @RequestParam("id")int id){
   String sql ="select * from products where id='"+id+"'";
  Datas=this.jdbctemp.queryForList(sql);
   mv.addObject("getProById",viewProdById);
   mv.setViewName("prod_details");
   return mv;        
   
   
   }
   
   
    @RequestMapping(value="edit.htm",method=RequestMethod.GET)
   public ModelAndView Edit( @RequestParam("id")int id){
   String sql ="select * from products where id='"+id+"'";
  Datas=this.jdbctemp.queryForList(sql);
   mv.addObject("EditProduct",Datas);
   mv.setViewName("edit");
   return mv;        
   
   
   }
  
   @RequestMapping(value="edit.htm",method=RequestMethod.POST)
   public ModelAndView Editing(dbModel product){
   String sql ="update products SET name=?,description=? ,price=? ,image=? where id =?";
   this.jdbctemp.update(sql, product.getName(),product.getDescription(),product.getPrice(),product.getImage());

   
   return new ModelAndView("redirect:adminIndex.htm") ;        
   
   
   }

   
     
    @RequestMapping(value="delete.htm")
   public ModelAndView delete( @RequestParam("id")int id){
  
   String sql ="delete from products where id='"+id+"'";
   this.jdbctemp.update(sql);
    return new ModelAndView("redirect:adminIndex.htm") ;
   }


private boolean authenticateUser(String username, String password) {
    UserDetails user = getUserByUsername(username);

    if (user != null) {
        String storedPassword = user.getPassword();

        if (password.equals(storedPassword)) {
           
            return true;
        }
    }

  
    return false;
}

private UserDetails getUserByUsername(String username) {
    String sql = "SELECT * FROM users WHERE username = ?";
    List<UserDetails> users = jdbctemp.query(sql, new Object[]{username}, new RowMapper<UserDetails>() {
        @Override
        public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
            UserDetails user = new UserDetails();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));
            user.setCreatedAt(rs.getString("created_At"));
            // Set other user properties as needed
            return user;
        }
    });

    if (!users.isEmpty()) {
        return users.get(0);
    }

    return null;
}


  @RequestMapping(value = "home.htm")
    public ModelAndView home(HttpServletRequest request) {
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // not authenticated, redirect to login page
            return new ModelAndView("redirect:login.htm");
        }

        // Get products
        String sql = "SELECT * FROM products";
         List<Map<String, Object>> homeProductList = this.jdbctemp.queryForList(sql);

    for (Map<String, Object> product : homeProductList) {
        byte[] imageBytes = (byte[]) product.get("image");
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        product.put("imageBase64", base64Image);
    }
        mv.addObject("ProductList", homeProductList);

        // Proceed to home page
        UserDetails currentUser = getCurrentUser(request);
        mv.addObject("currentUser", currentUser);
        mv.setViewName("home");
        return mv;
    }


    
    
    


@RequestMapping(value = "login.htm", method = RequestMethod.POST)
public ModelAndView userLogin(@RequestParam("username") String username,
                              @RequestParam("password") String password,
                              HttpServletRequest request) {
    ModelAndView mv = new ModelAndView();

    // Authentication
    if (authenticateUser(username, password)) {
        UserDetails user = getUserByUsername(username);
        setCurrentUser(request, user);

        // Check user role
        if (isUserAdmin(request)) {
            mv.setViewName("redirect:adminIndex.htm"); 
        } else {
            mv.setViewName("redirect:home.htm"); 
        }
    } else {
        mv.addObject("error", "Invalid username or password");
        mv.setViewName("login");
    }

    return mv;
}

private boolean isUserAdmin(HttpServletRequest request) {
    HttpSession session = request.getSession();
    UserDetails currentUser = (UserDetails) session.getAttribute("currentUser");
    return currentUser != null && currentUser.getRole().equals("admin");
}

    
    
  private boolean isUserAuthenticated(HttpServletRequest request) {
    
        return getCurrentUser(request) != null;
    }

 
    private UserDetails getCurrentUser(HttpServletRequest request) {
        return (UserDetails) request.getSession().getAttribute("currentUser");
    }

    // the current user in the session
    private void setCurrentUser(HttpServletRequest request, UserDetails user) {
        request.getSession().setAttribute("currentUser", user);
    }


    
    
@RequestMapping(value = "home.htm", method = RequestMethod.POST)
public ModelAndView addToCart(@RequestParam("id") int id,
                              @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                              HttpServletRequest request) {
    // Retrieve the user ID from the session
    UserDetails currentUser = (UserDetails) request.getSession().getAttribute("currentUser");
    
    if (currentUser != null) {
        int userId = currentUser.getId();

        // Check if the product already exists in the cart
        boolean isProductExist = false;
        List<Map<String, Object>> cartItems = new ArrayList<>();

        // Retrieve the existing cart for the current user from the database
        String selectSql = "SELECT * FROM cart WHERE userId = ?";
        List<Map<String, Object>> existingCartItems = jdbcTemplate.queryForList(selectSql, userId);

        for (Map<String, Object> item : existingCartItems) {
    int productId = (int) item.get("productId");
    if (productId == id) {
        int itemQuantity = (int) item.get("quantity");
        item.put("quantity", itemQuantity + quantity);

       
        double price = Double.parseDouble(item.get("totalPrice").toString());
        double totalPrice = price * (itemQuantity + quantity);
        item.put("totalPrice", totalPrice);

        
        String updateSql = "UPDATE cart SET quantity = ?, totalPrice = ? WHERE userId = ? AND productId = ?";
        jdbcTemplate.update(updateSql, item.get("quantity"), item.get("totalPrice"), userId, productId);

        isProductExist = true;
        break;
    }
}

        if (!isProductExist) {
      
            String selectProductSql = "SELECT * FROM products WHERE id = ?";
            Map<String, Object> product = jdbcTemplate.queryForMap(selectProductSql, id);
            product.put("quantity", quantity);

            // Calculate the totalPrice
            double price = Double.parseDouble(product.get("price").toString());
            double totalPrice = price * quantity;
            product.put("totalPrice", totalPrice);

            // Insert the new product into the cart table
            String insertSql = "INSERT INTO cart (userId, productId, productName, quantity, totalPrice) VALUES (?, ?, ?, ?, ?)";
            jdbcTemplate.update(insertSql, userId, id, product.get("name"), quantity, totalPrice);
            cartItems.add(product);
        }

        double overallTotalPrice = 0;
        for (Map<String, Object> item : cartItems) {
            double totalPrice = Double.parseDouble(item.get("totalPrice").toString());
            overallTotalPrice += totalPrice;
        }

        // Redirect the user to the cart page
        ModelAndView mv = new ModelAndView("redirect:cartView.htm");
        mv.addObject("cartItems", cartItems);
        mv.addObject("totalPrice", overallTotalPrice);
        return mv;
    } else {
       
        ModelAndView mv = new ModelAndView("redirect:login.htm");
        return mv;
    }
}







//just mapping to modelAndView 
@RequestMapping(value = "cartView.htm")
public ModelAndView cartPage(HttpServletRequest request) {
    // Retrieve the user ID from the session
    UserDetails currentUser = (UserDetails) request.getSession().getAttribute("currentUser");
    int userId = currentUser.getId();

    // Retrieve the existing cart items for the current user from the database
    String selectSql = "SELECT cart.*, products.price AS unitPrice FROM cart " +
                       "JOIN products ON cart.productId = products.id " +
                       "WHERE cart.userId = ?";
    List<Map<String, Object>> cartItems = jdbcTemplate.queryForList(selectSql, userId);

    // Calculate the overall total price
    double overallTotalPrice = 0;
    for (Map<String, Object> item : cartItems) {
        double totalPrice = Double.parseDouble(item.get("totalPrice").toString());
        overallTotalPrice += totalPrice;
    }

    // Return the cart items and total price to the cart view
    ModelAndView mv = new ModelAndView("cartView");
    mv.addObject("cartItems", cartItems);
    mv.addObject("totalPrice", overallTotalPrice);
  
 

    return mv;
}


@RequestMapping(value = "replaceProduct.htm", method = RequestMethod.GET)
public ModelAndView replaceProduct(@RequestParam("productId") int productId,
                                   HttpServletRequest request) {
    // Retrieve the user ID from the session
    UserDetails currentUser = (UserDetails) request.getSession().getAttribute("currentUser");
    int userId = currentUser.getId();

    // Check if the product exists in the cart for the current user
    String selectSql = "SELECT * FROM cart WHERE userId = ? AND productId = ?";
    List<Map<String, Object>> existingCartItems = jdbcTemplate.queryForList(selectSql, userId, productId);

    if (!existingCartItems.isEmpty()) {
        // Retrieve the product details from the database
        String selectProductSql = "SELECT * FROM products WHERE id = ?";
        Map<String, Object> product = jdbcTemplate.queryForMap(selectProductSql, productId);
        
        // Calculate the totalPrice
        double price = Double.parseDouble(product.get("totalPrice").toString());
        int quantity = 1; // Set the default quantity as 1 for the replacement
        double totalPrice = price * quantity;
        product.put("quantity", quantity);
        product.put("totalPrice", totalPrice);

        // Update the existing item in the cart table
        String updateSql = "UPDATE cart SET productId = ?, productName = ?, quantity = ?, totalPrice = ? WHERE userId = ? AND productId = ?";
        jdbcTemplate.update(updateSql, productId, product.get("name"), quantity, totalPrice, userId, productId);

        // Redirect the user to the home page
        ModelAndView mv = new ModelAndView("redirect:home.htm");
        return mv;
    } else {
        // Product does not exist in the cart, handle the error or redirect to an appropriate page
        ModelAndView mv = new ModelAndView("redirect:error.htm");
        return mv;
    }
}





/// Method for deleting a single product from the cart
@RequestMapping(value = "removeFromCart.htm", method = RequestMethod.POST)
public ModelAndView removeFromCart(@RequestParam("productId") int productId, HttpServletRequest request) {
  
    UserDetails currentUser = (UserDetails) request.getSession().getAttribute("currentUser");

    if (currentUser != null) {
        int userId = currentUser.getId();

       
        String deleteSql = "DELETE FROM cart WHERE userId = ? AND productId = ?";
        jdbcTemplate.update(deleteSql, userId, productId);

      
        ModelAndView mv = new ModelAndView("redirect:cartView.htm");
        return mv;
    } else {
      
        ModelAndView mv = new ModelAndView("redirect:login.htm");
        return mv;
    }
}

// Method for deleting all products in the cart for the current user
@RequestMapping(value = "cancelAllCart.htm", method = RequestMethod.POST)
public ModelAndView cancelAllCart(HttpServletRequest request) {
    // Retrieve the user ID from the session
    UserDetails currentUser = (UserDetails) request.getSession().getAttribute("currentUser");

    if (currentUser != null) {
        int userId = currentUser.getId();

        // Delete all products from the cart for the user
        String deleteSql = "DELETE FROM cart WHERE userId = ?";
        jdbcTemplate.update(deleteSql, userId);

        // Redirect the user back to the cart page
        ModelAndView mv = new ModelAndView("redirect:cartView.htm");
        return mv;
    } else {
        // User is not logged in, redirect to the login page
        ModelAndView mv = new ModelAndView("redirect:login.htm");
        return mv;
    }
}


@RequestMapping(value = "checkout.htm", method = RequestMethod.POST)
public ModelAndView performCheckout(HttpServletRequest request) {
    
    UserDetails currentUser = (UserDetails) request.getSession().getAttribute("currentUser");
    if (currentUser != null) {
        
    
    int userId = currentUser.getId();
    

    // Retrieve the existing cart items for the current user from the database
    String selectCartItemsSql = "SELECT cart.*, CAST(products.price AS DOUBLE) AS unitPrice FROM cart " +
                            "JOIN products ON cart.productId = products.id " +
                            "WHERE cart.userId = ?";

    List<Map<String, Object>> cartItems = jdbcTemplate.queryForList(selectCartItemsSql, userId);

   
    double overallTotalPrice = 0;
    for (Map<String, Object> item : cartItems) {
        double totalPrice = Double.parseDouble(item.get("totalPrice").toString());
        overallTotalPrice += totalPrice;
    }

 
    String selectUserSql = "SELECT username, email FROM users WHERE id = ?";
    Map<String, Object> user = jdbcTemplate.queryForMap(selectUserSql, userId);
    String username = (String) user.get("username");
    String email = (String) user.get("email");

    // Return the cart items, total price, username, and email to the payment view
    ModelAndView mv = new ModelAndView("payment");
    mv.addObject("cartItems", cartItems);
    mv.addObject("totalPrice", overallTotalPrice);
    mv.addObject("username", username);
    mv.addObject("email", email);

    return mv;
    }else{
    
    ModelAndView mv = new ModelAndView("home.htm");
    }
     return mv;
}



@RequestMapping(value = "processPayment.htm", method = RequestMethod.POST)
public ModelAndView processPayment(HttpServletRequest request) {
    String paymentMethod = request.getParameter("paymentMethod");
    double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

    UserDetails currentUser = (UserDetails) request.getSession().getAttribute("currentUser");

    if (currentUser == null) {
        ModelAndView mv = new ModelAndView("home");
        return mv;
    }

    int userId = currentUser.getId();
    String username = currentUser.getUsername();
    String email = currentUser.getEmail();

       // List<Map<String, Object>> cartItems = null;
       String cartItemsJson = request.getParameter("cartItems");
//       cartItems = new ObjectMapper().readValue(cartItemsJson, new TypeReference<List<Map<String, Object>>>() {
//       });

    StringBuilder productNamesBuilder = new StringBuilder();
    for (Map<String, Object> item : cartItems) {
        String productName = (String) item.get("productName");
        productNamesBuilder.append(productName).append(",");
    }
    String productNames = productNamesBuilder.toString();
    if (productNames.endsWith(",")) {
        productNames = productNames.substring(0, productNames.length() - 1);
    }

    String cardNumber = request.getParameter("cardNumber");
    String mobileNumber = request.getParameter("mobileNumber");

    String insertSql = "INSERT INTO productsold (userId, username, email, paymentMethod, cardNumber, mobileNumber, totalPrice, productNames) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    jdbcTemplate.update(insertSql, userId, username, email, paymentMethod, cardNumber, mobileNumber, String.valueOf(totalPrice), productNames);

    if (currentUser != null) {
      

     
        String deleteSql = "DELETE FROM cart WHERE userId = ?";
        jdbcTemplate.update(deleteSql, userId);

       
        ModelAndView mv = new ModelAndView("redirect:thankforshoping.htm");
        return mv;
    } else {
       
        ModelAndView mv = new ModelAndView("redirect:cartView.htm");
        return mv;
    }

   
  
}


  @RequestMapping(value="thankforshoping.htm")
   public ModelAndView thanks(){
 
    return new ModelAndView("thankforshoping") ;
   }


}