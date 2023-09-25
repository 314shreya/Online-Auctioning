package com.ebaylikeproject.auction;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

/**
 * Servlet implementation class BidItemForm
 */
@WebServlet("/BidItemForm")
public class BidItemForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BidItemForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// create table item(item_id int not null auto_increment, item_name varchar(255), type varchar(255), is_active tinyint(1), create_time timestamp, primary key (item_id));
		// create table auction(auction_id int not null auto_increment, starting_cost double, next_bid_lower_bound double, create_time timestamp, current_price double, latest_time timestamp, is_active tinyint(1), primary key(auction_id));
		// create table created_auction(item_id int not null,auction_id int not null, primary key(item_id,auction_id), FOREIGN KEY (item_id) REFERENCES item (item_id), FOREIGN KEY (auction_id) REFERENCES auction (auction_id));
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("email");
		String item_id = (String) request.getParameter("item_id");
		String auction_id = (String) request.getParameter("auction_id");
		System.out.println(item_id + " "+ auction_id);
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
//    		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebay?useSSL=false", "root", "mysql");
//    		System.out.println("select item.item_name as name, item.type as type, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id where item.item_id="+item_id+" and auction.auction_id="+auction_id);
    		PreparedStatement pst = con.prepareStatement("select item.item_name as name, item.type as type, item.manufacturer as manufacturer, item.color as color, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id where item.item_id=? and auction.auction_id=?");
    		pst.setString(1, item_id);
    		pst.setString(2, auction_id);
//    		System.out.println(pst);
    		
    		ResultSet rs = pst.executeQuery();
    		if(rs.next()) {
    			System.out.println(rs.getString("name"));
    			request.setAttribute("auction_id", auction_id);
	    		request.setAttribute("item_category", rs.getString("type"));
	    		request.setAttribute("item_name", rs.getString("name"));
	    		request.setAttribute("item_manufacturer", rs.getString("manufacturer"));
	    		request.setAttribute("item_color", rs.getString("color"));
	    		request.setAttribute("fuel_type", rs.getString("fuel_type"));
	    		request.setAttribute("passengers", rs.getInt("passengers"));
	    		request.setAttribute("mileage", rs.getDouble("mileage"));
				request.setAttribute("current_price", rs.getDouble("currentprice"));
				request.setAttribute("lowwer_bid", rs.getDouble("nextbid"));
				request.setAttribute("bid_start_price", rs.getDouble("currentprice") + rs.getDouble("nextbid"));
				request.setAttribute("max_bid", 100000000);
				RequestDispatcher dispatcher = null;
				dispatcher = request.getRequestDispatcher("itembid.jsp");
				RequestDispatcher dispatcher2 = null;
				dispatcher2 = request.getRequestDispatcher("biditem.java");
				dispatcher.forward(request, response);
				dispatcher2.forward(request, response);
    		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
