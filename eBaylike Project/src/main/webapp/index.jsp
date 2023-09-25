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
		padding-top: 5px;
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
</head>

<body class = "bd_index" onload="check_admin()">
<div class="nav_bar">
  <a class="is_act"  href="index.jsp">Home</a>
  <a href="auctionbids.jsp" id="buy">Buy</a>
  <a href="auction.jsp" id="sell">Sell</a>
  <a href="created_auction.jsp" id="created_auction">Created Auction</a>
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
<div style="margin:5%;">

	<%
		String email = (String)session.getAttribute("email");	
		Connection con = null;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
		java.sql.Date timeNow = new Date(new java.util.Date().getTime());
		String sql = "select item.item_name, auction.auction_id as aucid FROM ((auction INNER JOIN (SELECT * FROM auction_bids where email = ?) as A on A.auction_id = auction.auction_id ) INNER JOIN created_auction ON  A.auction_id = created_auction.auction_id) INNER JOIN item on created_auction.item_id = item.item_id where highest_price < A.bid_value and auction.buyer_noti = 1 and auction.end_date < "+"\'"+timeNow+"\'";
		PreparedStatement pst1 = con.prepareStatement(sql);
		
		pst1.setString(1, email);
		List<Integer> buyer_details = new ArrayList<>();
		List<String> item_details = new ArrayList<>();
		ResultSet rs = pst1.executeQuery();
		
		System.out.println("pst1: "+pst1);
		int count = 0;
		while(rs.next())
		{
			count = 1;
			System.out.println("In Buyer");
			buyer_details.add(rs.getInt("aucid"));
			item_details.add(rs.getString("item_name"));
			
			sql = "UPDATE auction SET buyer_noti=0 where auction_id = " + rs.getInt("aucid"); 
			//sql = "SELECT  item.type as type,item.item_name as name , bid_value as currentprice ,end_date, auction_id as aucid FROM item NATURAL JOIN created_auction as C_A NATURAL JOIN auction_bids NATURAL JOIN (select distinct auction_id,end_date,highest_price from auction NATURAL JOIN makes where makes.email = ? and end_date <" +"\'"+timeNow+"\') as dum where highest_price < bid_value and auction.isactive = 1";
			pst1 = con.prepareStatement(sql);
			//System.out.println(pst1);
			pst1.executeUpdate();
			
		}
		
		System.out.println("now here ");
		sql = "SELECT  item.type as type,item.item_name as name , bid_value as currentprice ,end_date, auction_id as aucid FROM item NATURAL JOIN created_auction as C_A NATURAL JOIN auction_bids NATURAL JOIN (select distinct auction_id,end_date,highest_price from auction NATURAL JOIN makes where makes.email = ? and auction.seller_noti = 1 and end_date <" +"\'"+timeNow+"\') as dum where highest_price < bid_value ";
		pst1 = con.prepareStatement(sql);
		pst1.setString(1, email);
		rs = pst1.executeQuery();
		System.out.println("now here 1");
		List<String> seller_item = new ArrayList<>();
		int count1 = 0;
		while(rs.next())
		{
			count1 = 1;
			seller_item.add(rs.getString("name"));
			
			sql = "UPDATE auction SET seller_noti=0 where auction_id = " + rs.getInt("aucid"); 
			//sql = "SELECT  item.type as type,item.item_name as name , bid_value as currentprice ,end_date, auction_id as aucid FROM item NATURAL JOIN created_auction as C_A NATURAL JOIN auction_bids NATURAL JOIN (select distinct auction_id,end_date,highest_price from auction NATURAL JOIN makes where makes.email = ? and end_date <" +"\'"+timeNow+"\') as dum where highest_price < bid_value and auction.isactive = 1";
			pst1 = con.prepareStatement(sql);
			//System.out.println(pst1);
			pst1.executeUpdate();
			
		}
		System.out.println("now here 2");
		sql = "UPDATE auction SET is_active=0 where end_date <" +"\'"+timeNow+"\'"; 
		//sql = "SELECT  item.type as type,item.item_name as name , bid_value as currentprice ,end_date, auction_id as aucid FROM item NATURAL JOIN created_auction as C_A NATURAL JOIN auction_bids NATURAL JOIN (select distinct auction_id,end_date,highest_price from auction NATURAL JOIN makes where makes.email = ? and end_date <" +"\'"+timeNow+"\') as dum where highest_price < bid_value and auction.isactive = 1";
		pst1 = con.prepareStatement(sql);
		System.out.println(pst1);
		pst1.executeUpdate();
		pst1.close();
		System.out.println("now here 1 ");
	%>
	<form method = "post" action="AuctionBidsServlet">
		<h3>Find Item: </h3>
	    <select name="item_type" id="item_type">
	    <%
	    	
			
			/* PreparedStatement pst = con.prepareStatement("select distinct item.type as type, item.item_name as name, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id "); */
			PreparedStatement pst = con.prepareStatement("select distinct item.type as type from item INNER JOIN created_auction ON created_auction.item_id = item.item_id ");
			rs = pst.executeQuery();
			/*out.println("<table>");
			out.println( "<tr> <th>Item Type</th> <th> Item Name </th> <th> Current Price </th> <th> Lower Bid </th></tr>"); */
			while (rs.next())
			{
				/* out.println("<tr><td>"+rs.getString("type")+"</td>"+"<td>"+rs.getString("name")+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td>"+"<td>"+rs.getDouble("nextbid")+"</td></tr>"); */
				out.println("<option>" + rs.getString("type") + "</option>");
			}
			/* out.println("</table>"); */
		%>
	    </select>
	    <input type="submit" value="Search"/>
	   </form>
</div>

<div class = "index_body" >
	<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
	<h1 style="line-height:5em;">Welcome To EBay Website <%=session.getAttribute("name") %></h1>
	<p >Buy- Sell- Bid. Get the best deal for products.</p>
	<p>EBay is a site where you get the best deal for your products.</p>
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
	var count = '<%= count %>';
	var count1 = '<%= count1 %>';
	var item_details = '<%= item_details %>';
	var seller_item = '<%= seller_item %>';
	if(count == 1)
		{
			alert("Congratualtions!!! Your won the auction of " + item_details);
			
		}
	if(count1 == 1)
	{
		alert("Congratualtions!!! Your item "+ seller_item +" has been sold");
		
	}
	var status = document.getElementById("status").value;
	if(status == "bid_manage"){
		alert("Bid successfully removed!!!");
	}
	if(status == "auction_manage"){
		alert("Auction successfully removed!!!");
	}
	
</script>
</body>
</html>
