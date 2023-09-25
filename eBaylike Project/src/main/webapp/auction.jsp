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

	.forms_div {
		padding-top : 65%;
		overflow-y: scroll;
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
  <a class="is_act" href="auction.jsp" id="sell">Sell</a>
  <a href="created_auction.jsp" id="created_auction">Created Auction</a>
  <a href="search.jsp" id="search">Search</a>
  <a href="q&a.jsp" id="q&a">Q&A</a>
  <a href="create_alerts.jsp">Create Alerts</a>
  <a href="reports.jsp" id="reports" style="display: none">Reports</a>
  <a href="customer_representative.jsp" id="customer_representative" style="display: none">Customer Representative</a>
  <a href="account_management.jsp" id="account_management" style="display: none">Account Management</a>
  <a href="auction_management.jsp" id="auction_management" style="display: none">Auction Management</a>
  <a href="bid_management.jsp" id="bid_management" style="display: none">Bid Management</a>
  <a class = "log_out" href="logout">Sign Out</a>
</div>

<div class= "cont_div">
	<div class="forms_div">
            <div class="form signup">
                <span class="title">Auction</span>

                <form method = "post" action="createauction">
                    <div class="input_tag">
                        <input type="text" name= "type" placeholder="Enter the type" required>
                        <i class="fa fa-circle icon"></i>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "manufacturer" placeholder="Enter the manufacturer name" required>
                        <i class="fa fa-circle icon"></i>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "item_name" placeholder="Enter the item name" required>
                        <i class="fa fa-circle icon"></i>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "color" placeholder="Enter the color" required>
                        <i class="fa fa-circle icon"></i>
                    </div>
                    <div class="input_tag">
                    	<i class="fa fa-circle icon"></i>
                        <select name="fuel_type" id="fuel_type" style="margin-left:10%;margin-top:4%;" required>
						  <option value="" disabled selected>Select fuel type for vehicle</option>
						  <option value="electric">Electric</option>
						  <option value="gas">Gas</option>
						</select>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "passengers" placeholder="Enter the no. of passengers" required>
                        <i class="fa fa-circle icon"></i>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "mileage" placeholder="Enter the mileage (average)" required>
                        <i class="fa fa-circle icon"></i>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "starting_cost" id= "starting_cost" onkeyup='starting_costCheck();verify();'placeholder="Enter the start cost" required>
                        <i class="fa fa-dollar icon"></i>
                    </div>
                    <div><span id = "next_bid_lower_bound_msg"></span></div>
                    <div class="input_tag">
                        <input type="text" name= "next_bid_lower_bound" id="next_bid_lower_bound" onkeyup='next_bid_lower_boundCheck();verify();' placeholder="Enter the next bid lower bound" required>
                        <i class="fa fa-dollar icon"></i>
                    </div>
                    <div class="input_tag">
                        <input type="text" name= "highest_bound" id="highest_bound" placeholder="Enter the minimum price for item to sell" required>
                        <i class="fa fa-dollar icon"></i>
                    </div>
                    <div class ="input_tag" style="margin-bottom:0px;">
                    	<label>End Date</label>
                    </div>
                    <div class="input_tag" style="margin-top:0px;">
                    	
                        <input type="date" name= "end_date" id="end_date" required>
                        <i class="uil uil-clock icon"></i>
                    </div>
                    
					<div><span id = "msg"></span></div>

                    <div>
                    	<button class="btn" type="submit" id="mybtn" >Auction Item</button>
                    </div>
                </form>

                
            </div>
            </div>
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
<script type="text/javascript">
    
var status = document.getElementById("status").value;
if(status == "failed"){
	alert("Item has already been auctioned");
}
var starting_cost_flag = false, next_bid_lower_bound_flag = false,pwd_flag = false;

var starting_costCheck = function()
{
    var startingCostVar = document.getElementById('starting_cost').value;
    if(isNan(startingCostVar)){
        starting_cost_flag = false;
        document.getElementById('next_bid_lower_bound_msg').innerHTML = 'Invalid start cost';
    }
    else{
        starting_cost_flag = true;
        document.getElementById('next_bid_lower_bound_msg').innerHTML = '';
    }
		
}

var next_bid_lower_boundCheck = function()
{
	var nextBidLowerBoundVar = document.getElementById('next_bid_lower_bound').value;
	if(isNan(nextBidLowerBoundVar))
	{
		next_bid_lower_bound_flag = false;
        document.getElementById('msg').innerHTML = 'Invalid Next Bid Value';
		
	}
	else
	{
		next_bid_lower_bound_flag = false;
		document.getElementById('msg').innerHTML = '';
	}
		
}


var verify = function()
{
	
	if(!(starting_cost_flag &&  next_bid_lower_bound_flag))
	{
		document.getElementById('mybtn').disabled = true;
		document.getElementById('mybtn').style.background = 'red';
	}
	else
	{
		document.getElementById('mybtn').disabled = false;
		document.getElementById('mybtn').style.background = '#4070f4';
	}
	
}
    
    
</script>
</body>
</html>