<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.credentials.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
		/* Style for Question and Answer section */
.cont_div {
  margin-top: 50px;
  display: flex;
  justify-content: center;
}

.forms_div {
  width: 50%;
}

.form {
  background-color: #f2f2f2;
  padding: 20px;
  border-radius: 5px;
}

.title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 20px;
  display: block;
  text-align: center;
}

.input_tag {
  margin-bottom: 20px;
  position: relative;
}

.input_tag input {
  width: 100%;
  padding: 10px 20px;
  font-size: 16px;
  border: none;
  border-bottom: 1px solid #ccc;
  outline: none;
}

.input_tag .icon {
  position: absolute;
  top: 50%;
  right: 0;
  transform: translateY(-50%);
  color: #aaa;
}

.btn {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 20px;
  width: 100%;
}

.btn:hover {
  background-color: #45a049;
}

/* Style for Questions and Answers table */
table {
  margin-top: 50px;
  border-collapse: collapse;
  width: 100%;
}

th {
  background-color: #4CAF50;
  color: white;
  font-size: 18px;
  font-weight: bold;
  text-align: left;
  padding: 8px;
}

td {
  font-size: 16px;
  padding: 8px;
  border-bottom: 1px solid #ddd;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

/* Style for search form */
form {
  margin-top: 50px;
  display: flex;
  align-items: center;
}

label {
  font-size: 18px;
  font-weight: bold;
  margin-right: 20px;
}
.input_tag {
display: flex;
width:2020px;
}
.input_tag input[type="text"] {
  padding: 10px;
  font-size: 16px;
  border: none;
  border-bottom: 1px solid #ccc;
  outline: none;
}

button[type="submit"] {
  background-color: #4CAF50;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-left:20%;
}

button[type="submit"]:hover {
  background-color: #45a049;
}

/* Style for customer rep section */
.customer_rep_div {
  margin-top: 50px;
}

.customer_rep_table {
  border-collapse: collapse;
  width: 100%;
}

.customer_rep_table th {
  background-color: #4CAF50;
  color: white;
  font-size: 18px;
  font-weight: bold;
  text-align: left;
  padding: 8px;
}

.customer_rep_table td {
  font-size: 16px;
  padding: 8px;
  border-bottom: 1px solid #ddd;
}

.customer_rep_table tr:nth-child(even) {
  background-color: #f2f2f2;
}

.customer_rep_table textarea {
  width: 90%;
  padding: 10px;
  font-size: 16px;
  border: 1px;
  border-bottom: 2px solid #ccc;
  outline: none;
	}
	</style>
</head>
<body onload="check_admin()">
<%
		// admin or customer rep or user functionality
		String email = (String)session.getAttribute("email");
		System.out.println("email: "+email);
		Connection con = null;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
		
		//String sqlIsAdmin = "SELECT is_admin from users where email = 'shreya@gmail.com'";
		String sqlIsAdmin = "SELECT is_admin FROM users WHERE email = ?";
		
		PreparedStatement pstIsAdmin = con.prepareStatement(sqlIsAdmin);
		pstIsAdmin.setString(1, email);
		System.out.println("admin func: " + pstIsAdmin);
		
		int is_admin = 0;
		ResultSet rsIsAdmin = pstIsAdmin.executeQuery();
		if(rsIsAdmin.next()) {
        	is_admin = rsIsAdmin.getInt("is_admin");
        	System.out.println("is_admin::: "+is_admin);
        }
		
		pstIsAdmin.close();
	%>
<div class="nav_bar">
  <a href="index.jsp">Home</a>
  <a href="auctionbids.jsp" id="buy">Buy</a>
  <a href="auction.jsp" id="sell">Sell</a>
  <a href="created_auction.jsp" id="created_auction">Created Auction</a>
  <a href="search.jsp" id="search">Search</a>
  <a class="is_act" href="q&a.jsp" id="q&a">Q&A</a>
  <a href="create_alerts.jsp" id="create_alerts">Create Alerts</a>
  <a href="reports.jsp" id="reports" style="display: none">Reports</a>
  <a href="customer_representative.jsp" id="customer_representative" style="display: none">Customer Representative</a>
  <a href="account_management.jsp" id="account_management" style="display: none">Account Management</a>
  <a href="auction_management.jsp" id="auction_management" style="display: none">Auction Management</a>
  <a href="bid_management.jsp" id="bid_management" style="display: none">Bid Management</a>
  <a class = "log_out" href="logout">Sign Out</a>
</div>


<% if(is_admin == 0) { %>
<div class= "cont_div">
	<div class="forms_div">
            <div class="form signup">
                <span class="title">Q&amp;A</span>
                <form method = "post" action="questionAns">
                    <div class="input_tag">
                        <input type="text" name= "question" placeholder="Type your question" required>
                        <i class="fa fa-circle icon"></i>
                    </div>
                    
                    <div>
                    	<button class="btn" type="submit" id="mybtn">Submit Question</button>
                    </div>
                </form>
		</div>
	</div>
</div>

<%-- you have to have the list of answered questions also --%>
<h2 style="margin-left:5%">Questions and Answers</h2>

<div style="margin-left:5%">
<form action="" method="GET">
    <label for="search">Search for keywords in question:</label>
    <input type="text" id="search" name="search">
    <button type="submit">Submit keyword</button>
</form>
<table>
    <tr>
        <% 
            String search = request.getParameter("search");
            String query = "select * from question where answer is not null";
            if(search != null && !search.isEmpty()){
                query += " and question_description like '%" + search + "%'";
            }
            PreparedStatement pst = con.prepareStatement(query); 
            ResultSet rs = pst.executeQuery();
            out.println("<table>");
            out.println("<br><br>");
            out.println("<tr> <th>Question</th> <th>Answer</th></tr>"); 
            while (rs.next()) {
                out.println("<tr><td>"+rs.getString("question_description")+"</td>"+"<td>"+rs.getString("answer")+"</td></tr>"); 
            }
            out.println("</table>");
        %>
    </tr>
</table>

</div>


<% } %>


<%-- customer rep answers questions --%>

<% if(is_admin == 1) { %>
<div>
    <table>
    	<tr>
    	<%
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			java.sql.Date timeNow = new Date(new java.util.Date().getTime());
			 System.out.println(timeNow);
			String query = "select * from question where answer is null";
			 PreparedStatement pst = con.prepareStatement(query); 
			
			System.out.println(pst);
			ResultSet rs = pst.executeQuery();
			out.println("<table>");
			out.println( "<tr> <th>Question</th><th> Asked By </th><th> Answer </th> </tr>"); 
			
			while (rs.next())
			{
				String questionId = rs.getString("question_id");
				out.println("<tr><td>"+rs.getString("question_description")+"</td><td>"+rs.getString("email")+"</td><td><form method='post' action='custRepQAns'><input type='hidden' name='questionId' value='" + questionId + "'><textarea name='answer' placeholder='Type your answer'></textarea><input type='submit' value='Submit Answer'></form></td></tr>");
			}
			 out.println("</table>");
		%>
		</tr>
    </table>
</div>
<% } %>

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