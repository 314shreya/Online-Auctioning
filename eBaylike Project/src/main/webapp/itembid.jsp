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
  <a class = "log_out" href="logout">Sign Out</a>
</div>

<div class= "cont_div">
	<div class="forms_div">
            <div class="form signup">
                <span class="title">Item Bid</span>

                <form method = "post" action="BidItemAuction">
                	<label>Vehicle Type: </label>
                    <label><%= request.getAttribute("item_category") %></label><br>
                    <label>Vehicle Name: </label>
                    <label><%= request.getAttribute("item_name") %></label><br>
                    <label>Vehicle Manufacturer: </label>
                    <label><%= request.getAttribute("item_manufacturer") %></label><br>
                    <label>Vehicle Color: </label>
                    <label><%= request.getAttribute("item_color") %></label><br>
                    <label>Vehicle Fuel Type: </label>
                    <label><%= request.getAttribute("fuel_type") %></label><br>
                    <label>No. of passengers: </label>
                    <label><%= request.getAttribute("passengers") %></label><br>
					<label>Vehicle Mileage: </label>
                    <label><%= request.getAttribute("mileage") %></label><br>
                    <label>Current Price: </label>
                    <label><%= request.getAttribute("current_price") %></label><br>
                    <label>Minimum Lower Bid: </label>
                    <label><%= request.getAttribute("lowwer_bid") %></label><br>
                    <label for="bid_value">Bid Value: </label>
                    <input type="number" name ="bid_value" id="bid_value" min="<%= request.getAttribute("bid_start_price") %>" max="<%= request.getAttribute("max_bid") %>"><br>
                    <input type="hidden" name ="auction_id" id="auction_id" value="<%= request.getAttribute("auction_id") %>"><br>
					                    
                    <!-- change here auto bids -->
                    <label for="auto_bid">Auto Bid? :</label>
	                <label class="switch">
	                    <input type="checkbox" name="auto_bid" id="auto_bid">
	                    <span class="slider round"></span>
	                </label><br>
	                
	                <!-- secret upper limit and bid increment when the auto_bid toggle is selected -->
	                <div id="auto_bid_options" style="display: none;">
	                    <label for="auto_bid_upper_limit">Secret Upper Limit for Auto Bid:</label>
	                    <input type="number" name="auto_bid_upper_limit" id="auto_bid_upper_limit" min="<%= request.getAttribute("current_price") %>" max="<%= request.getAttribute("max_bid") %>"><br>
	
	                    <label for="auto_bid_bid_increment">Bid Increment for Auto Bid:</label>
	                    <input type="number" name="auto_bid_bid_increment" id="auto_bid_bid_increment" min="1" max="<%= request.getAttribute("max_bid") %>"><br>
                	</div>
	                
                    <button class="btn" type="submit" id="submit" >Submit</button>
                </form>
			                
                <script>
					const autoBidToggle = document.getElementById('auto_bid');
					const autoBidOptions = document.getElementById('auto_bid_options');
	
					autoBidToggle.addEventListener('change', () => {
						if (autoBidToggle.checked) {
							autoBidOptions.style.display = 'block';
						} else {
							autoBidOptions.style.display = 'none';
						}
					});
					</script>

                
            </div>
    </div>
</div>
            <div class= "footer">
	<p class="lead"> made by Shreya, Dwijesh, Kush, Manad &copy; 2023</p>
</div>
</body>
</html>