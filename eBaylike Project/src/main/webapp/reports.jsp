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
	  border:1px solid black;
	}
	
	table{
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
  <a href="q&a.jsp">Q&A</a>
  <a href="create_alerts.jsp" id="create_alerts">Create Alerts</a>
  <a class="is_act"  href="reports.jsp" id="reports" style="visibility: hidden">Reports</a>
  <a href="customer_representative.jsp" id="customer_representative" style="visibility: hidden">Customer Representative</a>
  <a href="auction_management.jsp" id="auction_management" style="display: none">Auction Management</a>
  <a href="bid_management.jsp" id="bid_management" style="display: none">Bid Management</a>
  <a class = "log_out" href="logout">Sign Out</a>
</div>
<div style="margin-top:20px; margin-bottom:20px;">
	<form action="" method="get">
	<label for="report">Generate a report for:</label>
	    <select name="report" id="report_id" style="width: 70%;">
	   		<option value="total_earnings">Daily Total Earnings</option>
	   		<option value="by_item">Item Specific</option>
			<option value="by_item_type">Item Type</option>
			<option value="by_end_user">End User</option>
			<option value="best_selling_item">Best Selling Item</option>
			<option value="best_buyer">Best Buyer</option>
	    </select>
	    <button type="submit" style="width:10%">Submit</button>
	</form>
</div>

<div>
		<%
			String report_id = request.getParameter("report");
			String value = "";
			String query = "";
			Connection con = null;
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			java.sql.Date timeNow = new Date(new java.util.Date().getTime());
			if (report_id != null && report_id.equals("total_earnings"))
			{
				value = "Earnings Per Days";
				query = "select auction.end_date as auction_end, sum(if((auction_bids.bid_value > auction.highest_price) and (auction.end_date < ?), auction_bids.bid_value,0)) as total_earning from auction_bids join auction on auction_bids.auction_id = auction.auction_id join created_auction on created_auction.auction_id = auction_bids.auction_id join item on created_auction.item_id = item.item_id group by auction.end_date";
				out.println("Generated Report By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				pst1.setDate(1, timeNow);
				ResultSet rs = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Auction End Date</th><th>Total Earning</th></tr>");
				while (rs.next())
				{
					if(!rs.getString("total_earning").equals("0.0")){
						out.println("<tr><td>"+rs.getString("auction_end")+"</td><td>"+rs.getString("total_earning")+"</td></tr>");
					}
				}
				out.println("</table>");
			}
			else if (report_id != null && report_id.equals("by_item"))
			{
				value = "Earnings Per Item";
				query = "select item.item_name as item_name, sum(if((auction_bids.bid_value > auction.highest_price) and (auction.end_date < ?), auction_bids.bid_value,0)) as item_earnings from auction_bids join auction on auction_bids.auction_id = auction.auction_id join created_auction on created_auction.auction_id = auction_bids.auction_id join item on created_auction.item_id = item.item_id group by item.item_name";
				out.println("Generated Report By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				pst1.setDate(1, timeNow);
				ResultSet rs = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Name</th><th>Item Earning</th></tr>");
				while (rs.next())
				{
					if(!rs.getString("item_earnings").equals("0.0"))
					out.println("<tr><td>"+rs.getString("item_name")+"</td><td>"+rs.getString("item_earnings")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (report_id != null && report_id.equals("by_item_type"))
			{
				value = "Earnings Per Item Type";
				query = "select item.type as item_type, sum(if((auction_bids.bid_value > auction.highest_price) and (auction.end_date < ?), auction_bids.bid_value,0)) as total_earning from auction_bids join auction on auction_bids.auction_id = auction.auction_id join created_auction on created_auction.auction_id = auction_bids.auction_id join item on created_auction.item_id = item.item_id group by item.type";
				out.println("Generated Report By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				pst1.setDate(1, timeNow);
				ResultSet rs = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Type</th><th>Total Earning</th></tr>");
				while (rs.next())
				{
					if(!rs.getString("total_earning").equals("0.0"))
					out.println("<tr><td>"+rs.getString("item_type")+"</td><td>"+rs.getString("total_earning")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (report_id != null && report_id.equals("by_end_user"))
			{
				value = "Earnings Per Users";
				query = "select makes.email as email, sum(if((auction_bids.bid_value > auction.highest_price) and (auction.end_date < ?), auction_bids.bid_value,0)) as total_earning from auction_bids join auction on auction_bids.auction_id = auction.auction_id join created_auction on created_auction.auction_id = auction_bids.auction_id join item on created_auction.item_id = item.item_id join makes on makes.auction_id = auction.auction_id  group by makes.email";
				out.println("Generated Report By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				pst1.setDate(1, timeNow);
				ResultSet rs = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>User</th><th>Total Earning</th></tr>");
				while (rs.next())
				{
					if(!rs.getString("total_earning").equals("0.0"))
					out.println("<tr><td>"+rs.getString("email")+"</td><td>"+rs.getString("total_earning")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (report_id != null && report_id.equals("best_selling_item"))
			{
				value = "Best Selling Item";
				query = "select item.item_name as item_name, count(if((auction_bids.bid_value > auction.highest_price) and (auction.end_date < ?), auction_bids.bid_value,0)) as item_count from auction_bids join auction on auction_bids.auction_id = auction.auction_id join created_auction on created_auction.auction_id = auction_bids.auction_id join item on created_auction.item_id = item.item_id group by item.item_name order by item_count desc";
				out.println("Generated Report By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				pst1.setDate(1, timeNow);
				ResultSet rs = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Name</th><th> Item Selling Count</th></tr>");
				while (rs.next())
				{
					out.println("<tr><td>"+rs.getString("item_name")+"</td><td>"+rs.getString("item_count")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (report_id != null && report_id.equals("best_buyer"))
			{
				value = "best_buyer";
				query = "select auction_bids.email as item_name, sum(if((auction_bids.bid_value > auction.highest_price) and (auction.end_date < ?), auction_bids.bid_value,0)) as item_earnings from auction_bids join auction on auction_bids.auction_id = auction.auction_id join created_auction on created_auction.auction_id = auction_bids.auction_id join item on created_auction.item_id = item.item_id group by auction_bids.email order by item_earnings desc";
				out.println("Generated Report By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				pst1.setDate(1, timeNow);
				ResultSet rs = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Best Buyer Emails</th><th>Total Price of Items Bought</th></tr>");
				while (rs.next())
				{
					if(!rs.getString("item_earnings").equals("0.0")){
						out.println("<tr><td>"+rs.getString("item_name")+"</td><td>"+rs.getString("item_earnings")+"</td></tr>");
					}
				}
				out.println("</table>");
			}
			else
			{
				System.out.println("Report is not generated");
			}
			
			
		%>
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
			document.getElementById('reports').style.visibility = 'visible';
			document.getElementById('customer_representative').style.visibility = 'visible';
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
