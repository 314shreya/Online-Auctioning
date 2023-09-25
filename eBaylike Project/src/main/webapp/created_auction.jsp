<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.credentials.*" %>
<%@ page import="java.sql.Date" %>


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
	table, th, td {
	  border:1px solid black;
	  text-align: center;
	}
	
	
	table{
		width: 100%;
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
  <a class="is_act" href="created_auction.jsp" id="created_auction">Created Auction</a>
  <a href="search.jsp" id="search">Search</a>
  <a href="q&a.jsp" id="q&a">Q&A</a>
  <a href="create_alerts.jsp" id="create_alerts">Create Alerts</a>
  <a href="reports.jsp" id="reports" style="display: none">Reports</a>
  <a href="customer_representative.jsp" id="customer_representative" style="display: none">Customer Representative</a>
  <a href="account_management.jsp" id="account_management" style="display: none">Account Management</a>
  <a href="auction_management.jsp" id="auction_management" style="display: none">Auction Management</a>
  <a href="bid_management.jsp" id="bid_management" style="display: none">Bid Management</a>
  <a class = "log_out" href="logout">Sign Out</a>
</div>

<div>
    <table>
    	<tr>
    	<%
			Connection con = null;
			Class.forName("com.mysql.jdbc.Driver");
			String email = (String) session.getAttribute("email");
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			java.sql.Date timeNow = new Date(new java.util.Date().getTime());
			 System.out.println(timeNow);
			String query = "SELECT  item.type as type,item.item_name as name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, bid_value as currentprice , auction_bids.email as email1, auction.end_date as end_date, auction.highest_price as high FROM ((((item INNER JOIN created_auction ON item.item_id = created_auction.item_id) INNER JOIN auction_bids on auction_bids.auction_id = created_auction.auction_id)INNER JOIN  auction ON auction.auction_id = created_auction.auction_id) INNER JOIN makes on makes.auction_id = created_auction.auction_id)   where makes.email=?";
			 PreparedStatement pst = con.prepareStatement(query); 
			//PreparedStatement pst = con.prepareStatement("select item.type as type, item.item_name as name,  auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id where auction.auction_id");
			pst.setString(1, email);
			System.out.println(pst);
			ResultSet rs = pst.executeQuery();
			out.println("<table>");
			out.println( "<tr> <th>Item Type</th> <th> Item Name </th> <th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>Millege</th> <th> Current Price </th> <th> Last Bid By </th><th> End Date </th><th> Status</th><th>Winner</th></tr>"); 
			
			while (rs.next())
			{
				
				if(rs.getDate("end_date").compareTo(timeNow) < 1 )
				{
					if(rs.getDouble("high")< rs.getDouble("currentprice"))
					{
						out.println("<tr><td>"+rs.getString("type")+"</td>"+"<td>"+rs.getString("name")+"<td>"+rs.getString("manufacturer")+"</td>"+"<td>"+rs.getString("color")+"</td>"+"<td>"+rs.getString("fuel_type")+"</td>"+"<td>"+rs.getInt("passengers")+"</td>"+"<td>"+rs.getDouble("mileage")+"</td>"+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td><td>"+rs.getString("email1")+"</td><td>"+rs.getDate("end_date")+"</td><td>"+ "Closed"+"</td><td>"+rs.getString("email1")+" </td></tr>");
					}
					else
					{
						out.println("<tr><td>"+rs.getString("type")+"</td>"+"<td>"+rs.getString("name")+"<td>"+rs.getString("manufacturer")+"</td>"+"<td>"+rs.getString("color")+"</td>"+"<td>"+rs.getString("fuel_type")+"</td>"+"<td>"+rs.getInt("passengers")+"</td>"+"<td>"+rs.getDouble("mileage")+"</td>"+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td><td>"+(rs.getString("email1") == null ? "-" : rs.getString("email1"))+"</td><td>"+rs.getDate("end_date")+"</td><td>"+ "Closed"+"</td><td>"+"N/A"+" </td></tr>");
					}
					 
				}
				else
				{
					out.println("<tr><td>"+rs.getString("type")+"</td>"+"<td>"+rs.getString("name")+"</td>"+"<td>"+rs.getString("manufacturer")+"</td>"+"<td>"+rs.getString("color")+"</td>"+"<td>"+rs.getString("fuel_type")+"</td>"+"<td>"+rs.getInt("passengers")+"</td>"+"<td>"+rs.getDouble("mileage")+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td><td>"+(rs.getString("email1") == null ? "-" : rs.getString("email1"))+"</td><td>"+rs.getDate("end_date")+"</td><td>"+ "Open"+"</td><td>"+"Unsold"+"</td></tr>"); 
				}
				
			}
			 out.println("</table>");
		%>
		</tr>
    </table>
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