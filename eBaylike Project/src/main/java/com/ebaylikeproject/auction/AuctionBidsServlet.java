package com.ebaylikeproject.auction;

import java.io.IOException;
import java.sql.*;
import java.sql.Date;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

import java.util.*;


/**
 * Servlet implementation class AuctionBidsServlet
 */
@WebServlet("/AuctionBidsServlet")
public class AuctionBidsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuctionBidsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// create table item(item_id int not null auto_increment, item_name varchar(255), type varchar(255), is_active tinyint(1), create_time timestamp, primary key (item_id));
		// create table auction(auction_id int not null auto_increment, starting_cost double, next_bid_lower_bound double, create_time timestamp, current_price double, latest_time timestamp, is_active tinyint(1), primary key(auction_id));
		// create table created_auction(item_id int not null,auction_id int not null, primary key(item_id), FOREIGN KEY (item_id) REFERENCES item (item_id), FOREIGN KEY (auction_id) REFERENCES auction (auction_id));
//		HttpSession session = request.getSession(false);
////		if(session!=null){
////			session.invalidate();
////			response.sendRedirect("login.jsp");
////		}
//		
//		String email = (String) session.getAttribute("email");
//
//    	Connection con = null;
////    	RequestDispatcher dispatcher = null;
//    	try {
//    		Class.forName("com.mysql.jdbc.Driver");
//    		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebay?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "Dwijesh123$");
////    		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebay?useSSL=false", "root", "mysql");
//
//
//			PreparedStatement pst = con.prepareStatement("select item.type as type, item.item_name as name, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id ");
//			ResultSet rs = pst.executeQuery();
//			ArrayList<AuctionBids> AuctionBidsList = new ArrayList<AuctionBids>();
//			while (rs.next())
//			{
//				AuctionBidsList.add(new AuctionBids(rs.getString("type"),rs.getString("name"),rs.getDouble("currentprice"),rs.getDouble("nextbid")));
//			}
//			for (AuctionBids obj : AuctionBidsList) {
//	            System.out.println("Type: " + obj.getItemType() + " Name: " + obj.getItemName() + " CP: " + obj.getCurrentPrice() + " Min: " + obj.getMinLowwerBid());
//	        }
//			request.setAttribute("AuctionBids", AuctionBidsList);
//			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("auctionbids.jsp");
//			dispatcher.forward(request, response);
////			dispatcher = request.getRequestDispatcher("login.jsp");
////			if(rowCount > 0) {
////    			request.setAttribute("status", "logout");
////    		}
////			session.setAttribute("name", null);
////    		dispatcher.forward(request, response);
//    	} catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	finally {
//    		try {
//				con.close();
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//    	}
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("email");
		PrintWriter out = response.getWriter();
		String item_category = request.getParameter("item_type");
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
			 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
			 LocalDateTime now = LocalDateTime.now(); 
			 //System.out.println(dtf.format(now));
			 java.sql.Date timeNow = new Date(new java.util.Date().getTime());
			 System.out.println(timeNow);
			PreparedStatement pst = con.prepareStatement("select item.item_id as itemid, item.item_name as name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, auction.auction_id as auctionid, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid, auction.end_date as end_date from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id where auction.auction_id NOT IN (select auction_id from makes where email=?) and auction.is_active=1 and item.type="+"\'"+item_category+"\' and auction.end_date >"+"\'"+timeNow+"\'");
			pst.setString(1, email);
			ResultSet rs = pst.executeQuery();
			out.println("<html><head>\n"
					+ "<style>table, th, td {\n"
					+ "  border: 1px solid black;\n"
					+ " text-align: center;\n"
					+ "}\n"
					+ "table {\n"
					+ "  width: 100%;\n"
					+"}\n"
					+"</style>\n"
					+ "</head>");
			out.println("<body style=\"background-color: #265df2\">");
			out.println("<table>");
			out.println("<tr> <th>Item Type</th> <th> Item Name </th> <th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>Mileage</th> <th> Current Price </th> <th> Lower Bid </th> <th> End Date </th><th> Details </th></tr>");
			while (rs.next())
			{
				out.println("<tr><td>"+item_category+"</td>"+"<td>"+rs.getString("name")+"</td>"+"<td>"+rs.getString("manufacturer")+"</td>"+"<td>"+rs.getString("color")+"</td>"+"<td>"+rs.getString("fuel_type")+"</td>"+"<td>"+rs.getInt("passengers")+"</td>"+"<td>"+rs.getDouble("mileage")+"</td>"+"<td>"+rs.getDouble("currentprice")+"</td>"+"<td>"+rs.getDouble("nextbid")+"</td>"+"<td>"+rs.getDate("end_date") +"</td><td><form method = \"post\" action=\"BidItemForm\"><input type=\"hidden\" name= \"item_id\" value="+rs.getString("itemid")+"><input type=\"hidden\" name= \"auction_id\" value="+rs.getString("auctionid")+"><button type=\"submit\" style=\"width: 100%;\">Details</button></form></td></tr>");
			}
			out.println("</table>");
			out.println("</body></html>");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
