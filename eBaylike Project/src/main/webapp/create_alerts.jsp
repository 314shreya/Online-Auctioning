<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.credentials.*" %>
<%@ page import="com.ebaylikeproject.auction.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<!-- <link rel="stylesheet" href="style.css"> -->
<style>

	body {
	  margin: 0;
	  font-family: Arial, Helvetica, sans-serif;
	}
	
	.nav_bar {
	  overflow: hidden;
	  background-color: #333;
	}
	
	.nav_bar a {
	  float: left;
	  color: #f2f2f2;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	  font-size: 17px;
	}
	
	.nav_bar a:hover {
	  background-color: #ddd;
	  color: black;
	}
	
	.nav_bar a.is_act {
	  background-color: #265df2;
	  color: white;
	}
	.nav_bar a.log_out {
	background-color: orange;
	float: right;
	color: white;
	}

	.index_body {
		text-align: center;
		padding-text: 10px;
		padding-top: 100px;
		padding-bottom: 100px;
	}
	.bd_index{
		background-color: #265df2;
		
	}
	.footer {
	position: fixed;
	left: 0;
	bottom: 0;
	padding-bottom: 1px;
	width: 100%;
	background-color: #333;
	color: white;
	line-height:2em;
	text-align: center;
	text-color: white;
	}
	
	
	
	
	
	</style>
	<!-- ===== Iconscout CSS ===== -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

<!-- ===== CSS ===== -->
<link rel="stylesheet" href="style.css">



<!-- ===== JS ===== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- ===== Google Fonts ===== -->
<link href="https://fonts.googleapis.com/css?family=Roboto:400,500&display=swap" rel="stylesheet">



         
    <!--<title>Auction Form</title>-->
</head>
<body class = "bd_index" onload="check_admin()">
<div class="nav_bar">
  <a href="index.jsp">Home</a>
  <a href="auctionbids.jsp" id="buy">Buy</a>
  <a href="auction.jsp" id="sell">Sell</a>
  <a href="created_auction.jsp" id="created_auction">Created Auction</a>
  <a href="search.jsp" id="search">Search</a>
  <a href="q&a.jsp" id="q&a">Q&A</a>
  <a class = "is_act" href="create_alerts.jsp" id="create_alerts">Create Alerts</a>
  <a href="reports.jsp" id="reports" style="display: none">Reports</a>
  <a href="customer_representative.jsp" id="customer_representative" style="display: none">Customer Representative</a>
  <a href="account_management.jsp" id="account_management" style="display: none">Account Management</a>
  <a href="auction_management.jsp" id="auction_management" style="display: none">Auction Management</a>
  <a href="bid_management.jsp" id="bid_management" style="display: none">Bid Management</a>
  <a class = "log_out" href="logout">Sign Out</a>
</div>

<!-- check if the item, type, manufacturer, manufacturing date etc is available --- JOIN item table with auction table -->
<!-- if not available, give a button to create alert on said (optional) fields -->


<!-- START HERE -->

<div style="margin-left:5%">
<h2 style="margin-left:5%">Get All Items</h2>
<form action="" method="GET" style="margin: 5% 0; display: flex; flex-direction: column; align-items: center;">
  <div style="display: flex; flex-direction: row; align-items: center;">
    <label for="item_name" style="margin-right: 20px;">Item Name:</label>
    <input type="text" id="item_name" name="item_name" style="flex: 1;">
    
    <label for="type" style="margin-right: 20px; margin-left: 20px;">Type:</label>
    <input type="text" id="type" name="type" style="flex: 1;">
    
    <label for="item_name" style="margin-right: 20px;">Manufacturer:</label>
    <input type="text" id="manufacturer" name="manufacturer" style="flex: 1;">
   </div>
   <br>
   <div style="display: flex; flex-direction: row; align-items: center;">
    <label for="item_name" style="margin-right: 20px;">Fuel Type:</label>
    <input type="text" id="fuel_type" name="fuel_type" style="flex: 1;">
    
    <label for="item_name" style="margin-right: 20px; margin-left: 20px;">Mileage:</label>
    <input type="text" id="mileage" name="mileage" style="flex: 1;">
    
    <label for="item_name" style="margin-right: 20px; margin-left: 20px;">Passengers:</label>
    <input type="text" id="passengers" name="passengers" style="flex: 1;">
  </div>
  
  <div style="display: flex; flex-direction: row; margin-top: 20px;">
    <button type="submit" class="btn btn-primary" style="margin-right: 20px;">Get All Items</button>
  </div>
</form>

<h2 style="margin-left:5%">Create Alert!</h2>
<form action="createalerts" method="POST" style="margin: 5% 0; display: flex; flex-direction: column; align-items: center;">
  <div style="display: flex; flex-direction: row; align-items: center;">
    <label for="item_name" style="margin-right: 20px;">Item Name:</label>
    <input type="text" id="item_name" name="item_name" style="flex: 1;">
    
    <label for="type" style="margin-right: 20px; margin-left: 20px;">Type:</label>
    <input type="text" id="type" name="type" style="flex: 1;">
    
    <label for="item_name" style="margin-right: 20px; margin-left: 20px;">Manufacturer:</label>
    <input type="text" id="manufacturer" name="manufacturer" style="flex: 1;">
  </div>
   <br>
   <div style="display: flex; flex-direction: row; align-items: center;">  
    <label for="item_name" style="margin-right: 20px;">Fuel Type:</label>
    <input type="text" id="fuel_type" name="fuel_type" style="flex: 1;">
    
    <label for="item_name" style="margin-right: 20px;">Mileage:</label>
    <input type="text" id="mileage" name="mileage" style="flex: 1;">
    
    <label for="item_name" style="margin-right: 20px; margin-left: 20px;">Passengers:</label>
    <input type="text" id="passengers" name="passengers" style="flex: 1;">
  </div>
  
  <div style="display: flex; flex-direction: row; margin-top: 20px;">
    <button type="submit" class="btn btn-primary" style="margin-right: 20px;">Create Alert</button>
  </div>
</form>
	
	<h2>Getting All Items</h2>
	<table style="margin-top: 5px; border-collapse: collapse;">
	    <tr>
	        <% 
		        String email = (String)session.getAttribute("email");
				System.out.println("email: "+email);
				Connection con = null;
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
	            String item_name = request.getParameter("item_name");
	        	String type = request.getParameter("type");
	        	
	        	
	            String baseQuery = "select * from item i inner join auction a inner join created_auction ca where i.item_id = ca.item_id and a.auction_id = ca.auction_id";
	            if(item_name != null && !item_name.isEmpty()){
	            	baseQuery += " and item_name like '%" + item_name + "%'";
	            }
	            if(type != null && !type.isEmpty()){
	            	baseQuery += " and type like '%" + type + "%'";
	            }
	            PreparedStatement pstQuery = con.prepareStatement(baseQuery); 
	            ResultSet rsAlerts = pstQuery.executeQuery();
	            out.println("<tr> <th style='border: 1px solid black; padding: 8px;'>Item Name</th> <th style='border: 1px solid black; padding: 8px;'>Type</th><th style='border: 1px solid black; padding: 8px;'>Manufacturer</th><th style='border: 1px solid black; padding: 8px;'>Fuel Type</th><th style='border: 1px solid black; padding: 8px;'>Mileage</th><th style='border: 1px solid black; padding: 8px;'>No Of Passengers</th></tr>"); 
	            while (rsAlerts.next()) {
	                out.println("<tr><td style='border: 1px solid black; padding: 8px;'>"+rsAlerts.getString("item_name")+"</td>"+"<td style='border: 1px solid black; padding: 8px;'>"+rsAlerts.getString("type")+"</td><td style='border: 1px solid black; padding: 8px;'>"+rsAlerts.getString("manufacturer")+"</td><td style='border: 1px solid black; padding: 8px;'>"+rsAlerts.getString("fuel_type")+"</td><td style='border: 1px solid black; padding: 8px;'>"+rsAlerts.getString("mileage")+"</td><td style='border: 1px solid black; padding: 8px;'>"+rsAlerts.getString("passengers")+"</td></tr>"); 
	            }
	            
	            con.close();
	        %>
	    </tr>
	</table>
<br>
<br>
<br>
<br>
</div>



<div class= "footer">
	<p class="lead"> made by Shreya, Dwijesh, Kush, Manad &copy; 2023</p>
</div>

<script>
function check_admin()
{
	var is_admin = '<%= session.getAttribute("is_admin") %>';
	if (is_admin == "2")
	{
		document.getElementById('reports').style.display = 'block';
		document.getElementById('customer_representative').style.display = 'block';
		document.getElementById('buy').style.display = 'none';
		document.getElementById('sell').style.display = 'none';
		document.getElementById('created_auction').style.display = 'none';
		document.getElementById('search').style.display = 'none';
		document.getElementById('create_alerts').style.display = 'none';
		document.getElementById('q&a').style.display = 'none';
	}
	if (is_admin == "1")
	{
		document.getElementById('account_management').style.display = 'block';
		document.getElementById('auction_management').style.display = 'block';
		document.getElementById('bid_management').style.display = 'block';
		document.getElementById('buy').style.display = 'none';
		document.getElementById('sell').style.display = 'none';
		document.getElementById('created_auction').style.display = 'none';
		document.getElementById('search').style.display = 'none';
		document.getElementById('create_alerts').style.display = 'none';
	}
}
</script>
</body>
</html>