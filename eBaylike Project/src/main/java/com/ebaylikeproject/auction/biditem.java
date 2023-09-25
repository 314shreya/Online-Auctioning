package com.ebaylikeproject.auction;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

/**
 * Servlet implementation class biditem
 */
@WebServlet("/biditem")
public class biditem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public biditem() {
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
//		create table auction_bids(bid_id int not null auto_increment, bid_time timestamp, email varchar(50), auction_id int not null, PRIMARY KEY(bid_id),FOREIGN KEY(email) REFERENCES users(email), FOREIGN KEY(auction_id) REFERENCES auction(auction_id));
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("email");
		int auction_id = Integer.parseInt(request.getParameter("auction_id"));
		double bid_value = Double.parseDouble(request.getParameter("bid_value"));
		
		
		System.out.println("works till here1");
		
		// auto bid
		String autoBid = request.getParameter("auto_bid");
		double auto_bid_upper_bound = 0;
		double auto_bid_bid_increment = 0;

		if (autoBid != null && autoBid.equals("on")) {
			auto_bid_upper_bound = Double.parseDouble(request.getParameter("auto_bid_upper_limit"));
			auto_bid_bid_increment = Double.parseDouble(request.getParameter("auto_bid_bid_increment"));
		}

//		double auto_bid_upper_bound = Double.parseDouble(request.getParameter("auto_bid_upper_limit"));
//		double auto_bid_bid_increment = Double.parseDouble(request.getParameter("auto_bid_bid_increment"));
//		System.out.println(bid_value);

		Connection con = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
//    		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebay?useSSL=false", "root", "mysql");
//    		System.out.println("select item.item_name as name, item.type as type, auction.current_price as currentprice, auction.next_bid_lower_bound as nextbid from auction INNER JOIN created_auction ON auction.auction_id = created_auction.auction_id INNER JOIN item ON created_auction.item_id = item.item_id where item.item_id="+item_id+" and auction.auction_id="+auction_id);
    		Timestamp bid_time = new Timestamp(System.currentTimeMillis()); 
    		String stmtString = "update auction_bids set bid_time = ?, email = ?, bid_value = ?  where auction_id = ?";
    		PreparedStatement stmt = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
    		stmt.setTimestamp(1, bid_time);
            stmt.setString(2, email);
            stmt.setDouble(3,bid_value);
            stmt.setInt(4, auction_id);
            
            stmt.executeUpdate();
            
            System.out.println("Done with biding");
           
            stmt.close();
            
            // auto bid code
            if (autoBid != null && autoBid.equals("on")) {
	            String stmtString2 = "insert into auto_bids(email, auction_id, upper_bound, bid_increment) values (?,?,?,?)";
	    		PreparedStatement stmt2 = con.prepareStatement(stmtString2, Statement.RETURN_GENERATED_KEYS);
	    		stmt2.setString(1, email);
	            stmt2.setInt(2, auction_id);
	            stmt2.setDouble(3, auto_bid_upper_bound);
	            stmt2.setDouble(4, auto_bid_bid_increment);
	            
	            stmt2.executeUpdate();
            }
            // select 2nd highest auto_bid amount
            // apply the formula: current_price + seller_bid_increment*n <= second_highest_bid
            // n=2, 403, 403 + seller_bid_increment == 503
            
            PreparedStatement stmtString3 = con.prepareStatement("SELECT MAX(UPPER_BOUND) AS SECOND_HIGHEST_BID FROM AUTO_BIDS WHERE AUCTION_ID = ? AND UPPER_BOUND < (SELECT MAX(UPPER_BOUND) FROM AUTO_BIDS WHERE AUCTION_ID = ?);");
            stmtString3.setInt(1, auction_id);
            stmtString3.setInt(2, auction_id);
			ResultSet rs3 = stmtString3.executeQuery();
			double nDouble = 0;
			if(rs3.next()) {
				System.out.println("Second highest price");
				nDouble = rs3.getDouble("SECOND_HIGHEST_BID");
				System.out.println(nDouble);
			}
            
            System.out.println("Done with auto bid!");
            
            // extracting current price
            
            PreparedStatement stmtString4 = con.prepareStatement("select * from auction where auction_id=?");
            stmtString4.setInt(1, auction_id);
			ResultSet rs4 = stmtString4.executeQuery();
			double current_price = 0;
			double next_bid_lower_bound = 0;
			if(rs4.next()) {
				current_price = rs4.getDouble("current_price");
				next_bid_lower_bound = rs4.getDouble("next_bid_lower_bound");
				System.out.println("current_price & next_bid_lower_bound");
				System.out.println(current_price);
				System.out.println(next_bid_lower_bound);
			}
			
			
            PreparedStatement pst2 = con.prepareStatement("update auction set current_price=? where auction_id=?");
			
			pst2.setDouble(1, bid_value);
			current_price = bid_value;
			pst2.setInt(2, auction_id);
			int rowCount = pst2.executeUpdate();
			
    		pst2 = con.prepareStatement("insert into bid_logs(email, auction_id, bid_value) values (?,?,?)");
    		pst2.setString(1, email);
    		pst2.setInt(2, auction_id);
    		pst2.setDouble(3, bid_value);
    		pst2.executeUpdate();
    		pst2.close();	
    		System.out.println("Done with bid_logs");
						
            int n = 1+ (int) Math.floor((nDouble - current_price) / next_bid_lower_bound);
            System.out.println("n is: ");
            System.out.println(n);
            // item is sold at soldPrice
            double soldPrice = current_price +  next_bid_lower_bound * n;
            System.out.println("soldPrice");
            System.out.println(soldPrice);
            
           
            stmtString4.close();
            // auto bid code ends
            
         
    		dispatcher = request.getRequestDispatcher("index.jsp");
    		dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}