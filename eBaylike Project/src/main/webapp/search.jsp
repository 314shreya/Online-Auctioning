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
<%@ page import="java.sql.Date" %>
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
	  text-align: center;
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
  <a class="is_act" href="search.jsp" id="search">Search</a>
  <a href="q&a.jsp" id="q&a">Q&A</a>
  <a href="create_alerts.jsp" id="create_alerts">Create Alerts</a>
  <a href="reports.jsp" id="reports" style="display: none">Reports</a>
  <a href="customer_representative.jsp" id="customer_representative" style="display: none">Customer Representative</a>
  <a href="account_management.jsp" id="account_management" style="display: none">Account Management</a>
  <a href="auction_management.jsp" id="auction_management" style="display: none">Auction Management</a>
  <a href="bid_management.jsp" id="bid_management" style="display: none">Bid Management</a>
  <a class = "log_out" href="logout">Sign Out</a>
</div>


<div style="margin-top:20px; margin-bottom:20px;">
	<form method = "post" action="SpecificAuctionhist">
		<label for="auction_data">History for any specific auction: </label>
	    <select name="auction_data" id="item_type" style="width: 70%;">
	    <%
		    String email = (String)session.getAttribute("email");
			Connection con = null;
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			PreparedStatement pst = con.prepareStatement("select distinct item.type as type, item.item_name as name, item.manufacturer as manufacturer, item.color as color, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, created_auction.auction_id as auction_id  from item INNER JOIN created_auction ON created_auction.item_id = item.item_id ");
			ResultSet rs = pst.executeQuery();
			while (rs.next())
			{
				out.println("<option>" +rs.getString("auction_id")+" : "+ rs.getString("type")+" : " + rs.getString("name") +" : " + rs.getString("manufacturer")+" : " + rs.getString("color")+" : " + rs.getString("fuel_type") + "</option>");
			}
		%>
	    </select>
	    <input type="submit" value="Search" style="width: 10%;"/>
	   </form>
</div>

<div style="margin-top:20px; margin-bottom:20px;">
	   <form method = "post" action="Buyuserhist">
	   	<label for="auction_data">List of auctions specific buyer has participated in: </label>
	    <select name="buyer_details" id="item_type" style="width: 60%;">
	    <%
		   
			
			/* PreparedStatement pst = con.prepareStatement("select distinct item.type as type, item.item_name as name, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id "); */
			pst = con.prepareStatement("select distinct email from bid_logs where email  not in (\""+email+"\") ");
			System.out.println(pst);
			rs = pst.executeQuery();
			/*out.println("<table>");
			out.println( "<tr> <th>Item Type</th> <th> Item Name </th> <th> Current Price </th> <th> Lower Bid </th></tr>"); */
			while (rs.next())
			{
				/* out.println("<tr><td>"+rs.getString("type")+"</td>"+"<td>"+rs.getString("name")+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td>"+"<td>"+rs.getDouble("nextbid")+"</td></tr>"); */
				out.println("<option>" +rs.getString("email")+"</option>");
			}
			/* out.println("</table>"); */
		%>
	    </select>
	    <input type="submit" value="Search" style="width: 10%;"/>
	   </form>
</div>

<div style="margin-top:20px; margin-bottom:20px;">
	   <form method = "post" action="Selluserhist">
	   	<label for="auction_data">List of auctions specific seller has participated in: </label>
	    <select name="seller_data" id="item_type" style="width: 60%;">
	    <%
			
			/* PreparedStatement pst = con.prepareStatement("select distinct item.type as type, item.item_name as name, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id "); */
			pst = con.prepareStatement("select distinct email from makes where email  not in (\""+email+"\") ");
			System.out.println(pst);
			rs = pst.executeQuery();
			/*out.println("<table>");
			out.println( "<tr> <th>Item Type</th> <th> Item Name </th> <th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th> <th> Current Price </th> <th> Lower Bid </th></tr>"); */
			while (rs.next())
			{
				/* out.println("<tr><td>"+rs.getString("type")+"</td>"+"<td>"+rs.getString("name")+"</td>" + "<td>"+rs.getString("manufacturer")+"</td>"+"<td>"+rs.getString("color")+"</td>"+"<td>"+rs.getString("fuel_type")+"</td>"+"<td>"+rs.getInt("passengers")+"</td>"+"<td>"+rs.getDouble("mileage")+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td>"+"<td>"+rs.getDouble("nextbid")+"</td></tr>"); */
				out.println("<option>" +rs.getString("email")+"</option>");
			}
			/* out.println("</table>"); */
		%>
	    </select>
	    <input type="submit" value="Search" style="width: 10%;"/>
	   </form>
</div>

<div style="margin-top:20px; margin-bottom:20px;">
	<form action="" method="post" id="myForm" onsubmit="submit_status_select(event)">
	   	<label for="status_of_current_bid">Status of selected bidding: </label>
	    <select name="status_of_current_bid" id="status_of_current_bid" style="width: 70%;">
	    <%
			java.sql.Date timeNow = new Date(new java.util.Date().getTime());
	    	String query_ = "select distinct item.type as type, item.item_name as name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, created_auction.auction_id as auction_id, if("+ "auction.end_date > " + "\'" + timeNow + "\'" +", \"Open\", \"Closed\") as Status from item INNER JOIN created_auction ON created_auction.item_id = item.item_id join auction on auction.auction_id = created_auction.auction_id";
			PreparedStatement pst_n = con.prepareStatement(query_);
			ResultSet rs_n = pst_n.executeQuery();
			while (rs_n.next())
			{
				out.println("<option value = \""+ "Status for the selected bid with Auction ID - " +rs_n.getString("auction_id") + " is : " +rs_n.getString("Status") +"\">" + rs_n.getString("auction_id")+" : "+ rs_n.getString("type")+" : " + rs_n.getString("name") +" : " + rs_n.getString("manufacturer")+" : " + rs_n.getString("color")+" : " + rs_n.getString("fuel_type") + "</option>");
			}
		%>
	    </select>
	    <button type="submit" style="width: 10%;">Submit</button>
	    <input type="hidden" value = "" style="width: 70%" id="status_of_current_bid_inp" disabled/>
	</form>
</div>


<div style="margin-top:20px; margin-bottom:20px;">
	<form action="" method="get">
	   	<label for="sort_criteria">Sort by different criteria: </label>
	    <select name="sort_criteria" id="sort_criteria" style="width: 60%;">
	    	<option value="item_type">Item Type</option>
	   		<option value="item_name">Item Name</option>
			<option value="bid_price">Bid Price</option>
			<option value="auction_start_date">Auction Starting Date</option>
			<option value="auction_close_date">Auction Closing Date</option>
	    </select>
	    <input type="submit" value="Search" style="width: 10%;"/>
	   </form>
</div>

<div>
		<%
			String sort_criteria = request.getParameter("sort_criteria");
			String value = "";
			String query = "";
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			if (sort_criteria != null && sort_criteria.equals("item_type"))
			{
				value = "Item Type";
				query = "select item.type as item_type, item.item_name as item_name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, auction.starting_cost as auction_start_cost, auction.highest_price as auction_high_price, auction.create_time as auction_create_time, auction.end_date as auction_end_date, auction.is_active as auction_active, auction_bids.email as auction_bids_email, auction_bids.bid_value as auction_bid_value from item join created_auction on item.item_id = created_auction.item_id join auction on created_auction.auction_id = auction.auction_id join auction_bids on auction_bids.auction_id = auction.auction_id order by item_type asc";
				out.println("Sort By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				ResultSet rs_ = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Type</th><th>Item Name</th><th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th><th>Auction Start Cost</th><th>Auction Upper Limit</th><th>Auction Create Time</th><th>Auction End Date</th><th>Auction Status</th><th>Latest Bid User</th><th>Latest Bid Value</th></tr>");
				while (rs_.next())
				{
					out.println("<tr><td>"+rs_.getString("item_type")+"</td><td>"+rs_.getString("item_name")+ "</td><td>"+rs_.getString("manufacturer")+"</td>"+"<td>"+rs_.getString("color")+"</td>"+"<td>"+rs_.getString("fuel_type")+"</td>"+"<td>"+rs_.getInt("passengers")+"</td>"+"<td>"+rs_.getDouble("mileage")+"</td>"+"<td>"+rs_.getString("auction_start_cost")+"</td><td>"+rs_.getString("auction_high_price")+"</td><td>"+rs_.getString("auction_create_time")+"</td><td>"+rs_.getString("auction_end_date")+"</td><td>"+rs_.getString("auction_active")+"</td><td>"+rs_.getString("auction_bids_email")+"</td><td>"+rs_.getString("auction_bid_value")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (sort_criteria != null && sort_criteria.equals("item_name"))
			{
				value = "Item Name";
				query = "select item.type as item_type, item.item_name as item_name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, auction.starting_cost as auction_start_cost, auction.highest_price as auction_high_price, auction.create_time as auction_create_time, auction.end_date as auction_end_date, auction.is_active as auction_active, auction_bids.email as auction_bids_email, auction_bids.bid_value as auction_bid_value from item join created_auction on item.item_id = created_auction.item_id join auction on created_auction.auction_id = auction.auction_id join auction_bids on auction_bids.auction_id = auction.auction_id order by item_name asc";
				out.println("Sort By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				ResultSet rs_ = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Type</th><th>Item Name</th><th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th><th>Auction Start Cost</th><th>Auction Upper Limit</th><th>Auction Create Time</th><th>Auction End Date</th><th>Auction Status</th><th>Latest Bid User</th><th>Latest Bid Value</th></tr>");
				while (rs_.next())
				{
					out.println("<tr><td>"+rs_.getString("item_type")+"</td><td>"+rs_.getString("item_name")+"</td><td>"+rs_.getString("manufacturer")+"</td>"+"<td>"+rs_.getString("color")+"</td>"+"<td>"+rs_.getString("fuel_type")+"</td>"+"<td>"+rs_.getInt("passengers")+"</td>"+"<td>"+rs_.getDouble("mileage")+"</td>"+"<td>"+rs_.getString("auction_start_cost")+"</td><td>"+rs_.getString("auction_high_price")+"</td><td>"+rs_.getString("auction_create_time")+"</td><td>"+rs_.getString("auction_end_date")+"</td><td>"+rs_.getString("auction_active")+"</td><td>"+rs_.getString("auction_bids_email")+"</td><td>"+rs_.getString("auction_bid_value")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (sort_criteria != null && sort_criteria.equals("bid_price"))
			{
				value = "Bid Price";
				query = "select item.type as item_type, item.item_name as item_name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, auction.starting_cost as auction_start_cost, auction.highest_price as auction_high_price, auction.create_time as auction_create_time, auction.end_date as auction_end_date, auction.is_active as auction_active, auction_bids.email as auction_bids_email, auction_bids.bid_value as auction_bid_value from item join created_auction on item.item_id = created_auction.item_id join auction on created_auction.auction_id = auction.auction_id join auction_bids on auction_bids.auction_id = auction.auction_id order by auction_bid_value asc";
				out.println("Sort By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				ResultSet rs_ = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Type</th><th>Item Name</th><th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th><th>Auction Start Cost</th><th>Auction Upper Limit</th><th>Auction Create Time</th><th>Auction End Date</th><th>Auction Status</th><th>Latest Bid User</th><th>Latest Bid Value</th></tr>");
				while (rs_.next())
				{
					out.println("<tr><td>"+rs_.getString("item_type")+"</td><td>"+rs_.getString("item_name")+"</td><td>"+rs_.getString("manufacturer")+"</td>"+"<td>"+rs_.getString("color")+"</td>"+"<td>"+rs_.getString("fuel_type")+"</td>"+"<td>"+rs_.getInt("passengers")+"</td>"+"<td>"+rs_.getDouble("mileage")+"</td>"+"<td>"+rs_.getString("auction_start_cost")+"</td><td>"+rs_.getString("auction_high_price")+"</td><td>"+rs_.getString("auction_create_time")+"</td><td>"+rs_.getString("auction_end_date")+"</td><td>"+rs_.getString("auction_active")+"</td><td>"+rs_.getString("auction_bids_email")+"</td><td>"+rs_.getString("auction_bid_value")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (sort_criteria != null && sort_criteria.equals("auction_start_date"))
			{
				value = "Auction Start Date";
				query = "select item.type as item_type, item.item_name as item_name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, auction.starting_cost as auction_start_cost, auction.highest_price as auction_high_price, auction.create_time as auction_create_time, auction.end_date as auction_end_date, auction.is_active as auction_active, auction_bids.email as auction_bids_email, auction_bids.bid_value as auction_bid_value from item join created_auction on item.item_id = created_auction.item_id join auction on created_auction.auction_id = auction.auction_id join auction_bids on auction_bids.auction_id = auction.auction_id order by auction_create_time asc";
				out.println("Sort By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				ResultSet rs_ = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Type</th><th>Item Name</th><th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th><th>Auction Start Cost</th><th>Auction Upper Limit</th><th>Auction Create Time</th><th>Auction End Date</th><th>Auction Status</th><th>Latest Bid User</th><th>Latest Bid Value</th></tr>");
				while (rs_.next())
				{
					out.println("<tr><td>"+rs_.getString("item_type")+"</td><td>"+rs_.getString("item_name")+"</td><td>"+rs_.getString("manufacturer")+"</td>"+"<td>"+rs_.getString("color")+"</td>"+"<td>"+rs_.getString("fuel_type")+"</td>"+"<td>"+rs_.getInt("passengers")+"</td>"+"<td>"+rs_.getDouble("mileage")+"</td>"+"<td>"+rs_.getString("auction_start_cost")+"</td><td>"+rs_.getString("auction_high_price")+"</td><td>"+rs_.getString("auction_create_time")+"</td><td>"+rs_.getString("auction_end_date")+"</td><td>"+rs_.getString("auction_active")+"</td><td>"+rs_.getString("auction_bids_email")+"</td><td>"+rs_.getString("auction_bid_value")+"</td></tr>");
				}
				out.println("</table>");
			}
			else if (sort_criteria != null && sort_criteria.equals("auction_close_date"))
			{
				value = "Auction End Date";
				query = "select item.type as item_type, item.item_name as item_name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, auction.starting_cost as auction_start_cost, auction.highest_price as auction_high_price, auction.create_time as auction_create_time, auction.end_date as auction_end_date, auction.is_active as auction_active, auction_bids.email as auction_bids_email, auction_bids.bid_value as auction_bid_value from item join created_auction on item.item_id = created_auction.item_id join auction on created_auction.auction_id = auction.auction_id join auction_bids on auction_bids.auction_id = auction.auction_id order by auction_end_date asc";
				out.println("Sort By : " + value);
				PreparedStatement pst1 = con.prepareStatement(query);
				ResultSet rs_ = pst1.executeQuery();
				out.println("<table>");
				out.println("<tr><th>Item Type</th><th>Item Name</th><th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th><th>Auction Start Cost</th><th>Auction Upper Limit</th><th>Auction Create Time</th><th>Auction End Date</th><th>Auction Status</th><th>Latest Bid User</th><th>Latest Bid Value</th></tr>");
				while (rs_.next())
				{
					out.println("<tr><td>"+rs_.getString("item_type")+"</td><td>"+rs_.getString("item_name")+"</td><td>"+rs_.getString("manufacturer")+"</td>"+"<td>"+rs_.getString("color")+"</td>"+"<td>"+rs_.getString("fuel_type")+"</td>"+"<td>"+rs_.getInt("passengers")+"</td>"+"<td>"+rs_.getDouble("mileage")+"</td>"+"<td>"+rs_.getString("auction_start_cost")+"</td><td>"+rs_.getString("auction_high_price")+"</td><td>"+rs_.getString("auction_create_time")+"</td><td>"+rs_.getString("auction_end_date")+"</td><td>"+rs_.getString("auction_active")+"</td><td>"+rs_.getString("auction_bids_email")+"</td><td>"+rs_.getString("auction_bid_value")+"</td></tr>");
				}
				out.println("</table>");
			}
			else
			{
				System.out.println("Report is not generated");
			}
			
			
		%>
</div>

<%-- additional functionality of "similar"/ type items on auctions in the preceding month, auction info abt them! --%>
<div style="margin-top:20px; margin-bottom:20px;">
	<form action="" method="get">
	   	<label for="similar_items">List of "similar" items on auctions in the preceding month: </label>
	    <select name="similar_items" id="similar_items" style="width: 60%;">
	    <%
			
			/* PreparedStatement pst = con.prepareStatement("select distinct item.type as type, item.item_name as name, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id "); */
			pst = con.prepareStatement("select distinct type from item");
			System.out.println(pst);
			rs = pst.executeQuery();
			/*out.println("<table>");
			out.println( "<tr> <th>Item Type</th> <th> Item Name </th> <th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th> <th> Current Price </th> <th> Lower Bid </th></tr>"); */
			while (rs.next())
			{
				/* out.println("<tr><td>"+rs.getString("type")+"</td>"+"<td>"+rs.getString("name")+"</td>" + "<td>"+rs.getString("manufacturer")+"</td>"+"<td>"+rs.getString("color")+"</td>"+"<td>"+rs.getString("fuel_type")+"</td>"+"<td>"+rs.getInt("passengers")+"</td>"+"<td>"+rs.getDouble("mileage")+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td>"+"<td>"+rs.getDouble("nextbid")+"</td></tr>"); */
				out.println("<option>" +rs.getString("type")+"</option>");
			}
			/* out.println("</table>"); */
		%>
	    </select>
	    <input type="submit" value="Search Similar Items" style="width: 10%;"/>
	   </form>
</div>
<div>
		<%
			String type = request.getParameter("similar_items");
			String query1 = "";
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			java.sql.Date timeNow2 = new Date(new java.util.Date().getTime());
			System.out.println("In");
			query1 = "SELECT a.end_date as end_date, i.type as item_type ,i.item_name as item_name, i.manufacturer as manufacturer, i.color as color, i.fuel_type as fuel_type, i.passengers as passengers, i.mileage as mileage  FROM item i INNER JOIN created_auction ca ON i.item_id = ca.item_id INNER JOIN auction a ON ca.auction_id = a.auction_id WHERE i.type = ? AND a.end_date BETWEEN DATE_SUB("+"\'"+timeNow2+"\'"+", INTERVAL 1 MONTH) AND"+"\'"+timeNow2+"\'";
			PreparedStatement pst1 = con.prepareStatement(query);
			pst1.setString(1, type);
			System.out.println(pst1);
			ResultSet rs_ = pst1.executeQuery();
			out.println("<table>");
			out.println("<tr><th>Item Type</th><th>Item Name</th><th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>mileage</th><th>Auction Start Cost</th><th>Auction Create Time</th><th>Auction End Date</th><th>Auction Status</th><th>Latest Bid User</th><th>Latest Bid Value</th></tr>");
			while (rs_.next())
			{
				out.println("<tr><td>"+rs_.getString("item_type")+"</td><td>"+rs_.getString("item_name")+ "</td><td>"+rs_.getString("manufacturer")+"</td>"+"<td>"+rs_.getString("color")+"</td>"+"<td>"+rs_.getString("fuel_type")+"</td>"+"<td>"+rs_.getInt("passengers")+"</td>"+"<td>"+rs_.getDouble("mileage")+"</td>"+"<td>"+rs_.getString("start_cost")+"</td><td>"+"</td><td>"+rs_.getString("create_time")+"</td><td>"+rs_.getString("end_date")+"</td><td>"+rs_.getString("is_active")+"</td><td>"+rs_.getString("latest_bid_by")+"</td><td>"+rs_.getString("current_price")+"</td><td></tr>");
			}
			out.println("</table>");

		%>
</div>

<div class= "footer">
	<p class="lead"> made by Shreya, Dwijesh, Kush, Manad &copy; 2023</p>
</div>

<script>
function submit_status_select(event)
{
	event.preventDefault();
	var temp = document.getElementById("status_of_current_bid").value;
	alert(temp);
}
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
