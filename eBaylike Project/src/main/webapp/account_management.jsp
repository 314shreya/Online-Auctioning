<%
if(session.getAttribute("name") == null){
	response.sendRedirect("login.jsp");
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.credentials.*" %>
<%@ page import="javax.script.*" %>

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
	table, th, td {
	border: 1px solid black;
	}
	table {
	width: 100%;
	}
	</style>
</head>

<body class = "bd_index" onload="check_admin()">
<div class="nav_bar">
  <a href="index.jsp">Home</a>
  <a href="auctionbids.jsp" id="buy">Buy</a>
  <a href="auction.jsp" id="sell">Sell</a>
  <a href="created_auction.jsp" id="created_auction">Created Auction</a>
  <a href="search.jsp" id="search">Search</a>
  <a href="q&a.jsp" id="q&a">Q&A</a>
  <a href="create_alerts.jsp" id="create_alerts">Create Alerts</a>
  <a href="reports.jsp" id="reports" style="display: none">Reports</a>
  <a href="customer_representative.jsp" id="customer_representative" style="display: none">Customer Representative</a>
  <a class="is_act" href="account_management.jsp" id="account_management" style="display: none">Account Management</a>
  <a href="auction_management.jsp" id="auction_management" style="display: none">Auction Management</a>
  <a href="bid_management.jsp" id="bid_management" style="display: none">Bid Management</a>
  <a class = "log_out" href="logout">Sign Out</a>
</div>
<div>
	<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
	<table>
	    <tr>
	    	<th>Username</th>
	    	<th>Password</th>
	    	<th>Email</th>
	    	<th>Phone</th>
	    	<th>Address</th>
	    	<th>Update</th>
	    </tr>
	    <%
	    try {
	    	String email = (String)session.getAttribute("email");
		    Connection con = null;
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			String sql = "SELECT name as name, password as password, email as email, phone as phone, address as address from users where is_admin=0";
			PreparedStatement pst1 = con.prepareStatement(sql);
			ResultSet rs = pst1.executeQuery();
			while (rs.next())
			{
				out.println("<tr><td>"+rs.getString("name")+"</td>"+"<td>"+rs.getString("password")+"</td>"+"<td>"+rs.getString("email")+"</td>"+"<td>"+rs.getString("phone")+"<td>"+rs.getString("address")+"</td>"+"<td><form method = \"post\" action=\"AccountManagementServlet\"><input type=\"hidden\" name= \"uemail\" value="+rs.getString("email")+"><button type=\"submit\" name=\"submit_btn\" value=\"update\">Update</button><button type=\"submit\" name=\"submit_btn\" value=\"delete\">Delete</button></form></td></tr>");
			}
	    }
	    catch (Exception e)
	    {
	    	e.printStackTrace();
	    }
	    %>
	</table>
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
	var status = document.getElementById("status").value;
	if(status == "failed"){
		alert("Customer representative role is not assigned!!!");
	}
	if(status == "success"){
		alert("Customer representative role is assigned!!!");
	}
</script>
</body>
</html>