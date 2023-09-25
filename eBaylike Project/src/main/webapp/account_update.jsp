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
<body class = "bd_index">
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

<div class= "cont_div">
	<div class="forms_div">
            <div class="form signup">
                <span class="title">User Account Update</span>

                <form method = "post" action="AccountUpdateServlet">
                	<label>User name: </label>
                	<input type="text" name="username" value="<%= request.getAttribute("name") %>"><br>
                    <label>User Password: </label>
                    <input type="text" name="userpass" value="<%= request.getAttribute("password") %>"><br>
                    <label>User Phone No.: </label>
                    <input type="text" name="userphone" value="<%= request.getAttribute("phone") %>" pattern="[0-9]{10}"><br>
                    <label>User Address: </label>
                    <input type="text" name="useraddr" value="<%= request.getAttribute("address") %>"><br>
                    <button class="btn" type="submit" id="submit" >Update Information</button>
                    <input type="hidden" name="uemail" value="<%= request.getAttribute("uemail") %>"><br>
                </form>
            </div>
    </div>
</div>
            <div class= "footer">
	<p class="lead"> made by Shreya, Dwijesh, Kush, Manad &copy; 2023</p>
</div>
</body>
</html>