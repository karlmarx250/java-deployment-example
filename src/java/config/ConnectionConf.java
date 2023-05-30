/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import org.springframework.jdbc.datasource.DriverManagerDataSource;


public class ConnectionConf {
    
 public DriverManagerDataSource Connect()   {
     
 DriverManagerDataSource dt= new DriverManagerDataSource();
 dt.setDriverClassName("com.mysql.jdbc.Driver");
 dt.setUrl("jdbc:mysql://6t4hqz.stackhero-network.com:3306/shopify");
 dt.setUsername("root");
 dt.setPassword("LtllZ90BrgX8IlqgGZNaO3GfeOqBOzaQ");
 return dt;
 
 
 
 
 
 }
    
    
    
    
    
    
    
    
}
