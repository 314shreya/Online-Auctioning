package com.ebaylikeproject.auction;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;
import com.ebaylikeproject.auction.AutoBidderInfo;

/**
 * Servlet implementation class BidItemAuction
 */
@WebServlet("/BidItemAuction")
public class BidItemAuction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BidItemAuction() {
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
//			create table auction_bids(bid_id int not null auto_increment, bid_time timestamp, email varchar(50), auction_id int not null, PRIMARY KEY(bid_id),FOREIGN KEY(email) REFERENCES users(email), FOREIGN KEY(auction_id) REFERENCES auction(auction_id));
			
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("email");
		int auction_id = Integer.parseInt(request.getParameter("auction_id"));
		double bid_value = Double.parseDouble(request.getParameter("bid_value"));
		System.out.println("auction id:  "+auction_id);
		// auto bid
		String autoBid = request.getParameter("auto_bid");
		double auto_bid_upper_bound = 0;
		double auto_bid_bid_increment = 0;
		
		
		

		if (autoBid != null && autoBid.equals("on")) {
			auto_bid_upper_bound = Double.parseDouble(request.getParameter("auto_bid_upper_limit"));
			auto_bid_bid_increment = Double.parseDouble(request.getParameter("auto_bid_bid_increment"));
		}


		Connection con = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);

    		Timestamp bid_time = new Timestamp(System.currentTimeMillis());
    		
    		
    		PreparedStatement pstUpdateAuctionTable = con.prepareStatement("UPDATE auction SET current_price = ?, latest_bid_by = ?, latest_time=? WHERE auction_id = ?");
    		pstUpdateAuctionTable.setDouble(1, bid_value);
    		pstUpdateAuctionTable.setString(2, email);
    		pstUpdateAuctionTable.setTimestamp(3, bid_time);
    		pstUpdateAuctionTable.setInt(4, auction_id);
    		
    		pstUpdateAuctionTable.executeUpdate();
        	
    		// 1. update the initial auction_bids table
    		// insert into bid_logs table
//    		String stmtString = "insert into auction_bids (bid_time, email, bid_value, auction_id) values (?, ?, ?, ?)";
//    		PreparedStatement stmt = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
//    		stmt.setTimestamp(1, bid_time);
//            stmt.setString(2, email);
//            stmt.setDouble(3,bid_value);
//            stmt.setInt(4, auction_id);
//            
//            stmt.executeUpdate();
            
            PreparedStatement pstAuctionBids1 = con.prepareStatement("UPDATE auction_bids SET bid_time=?, email=?, bid_value=? where auction_id=?");
            pstAuctionBids1.setTimestamp(1, bid_time);
            pstAuctionBids1.setString(2, email);
            pstAuctionBids1.setDouble(3, bid_value);
            pstAuctionBids1.setInt(4, auction_id);
            pstAuctionBids1.executeUpdate();
            pstAuctionBids1.close();
			
			PreparedStatement pstBidLogs1 = con.prepareStatement("INSERT INTO bid_logs (email, auction_id, bid_value) VALUES (?, ?, ?)");
			pstBidLogs1.setString(1, email);
			pstBidLogs1.setInt(2, auction_id);
			pstBidLogs1.setDouble(3, bid_value);
			pstBidLogs1.executeUpdate();
			pstBidLogs1.close();
			
            System.out.println("Done with initial auction_bids table updating");
           
            
            
            
            // 2. set up person with auto bid value with upper limit
            if (autoBid != null && autoBid.equals("on")) {
	            String stmtString2 = "insert into auto_bids(email, auction_id, upper_bound, bid_increment) values (?,?,?,?)";
	    		PreparedStatement stmt2 = con.prepareStatement(stmtString2, Statement.RETURN_GENERATED_KEYS);
	    		stmt2.setString(1, email);
	            stmt2.setInt(2, auction_id);
	            stmt2.setDouble(3, auto_bid_upper_bound);
	            stmt2.setDouble(4, auto_bid_bid_increment);
	            
	            stmt2.executeUpdate();
	            
	            
	            
	            // all this happens only if the user has opted for the auto_bid feature!
	            // 3. get list of people who bid on the item whose upper_limit >= current_price + bid_increment
	            PreparedStatement pstAllRecords = con.prepareStatement("select * from users u join auto_bids ab on u.email = ab.email join auction a on ab.auction_id = a.auction_id where ab.upper_bound >= (a.current_price + a.next_bid_lower_bound) and a.auction_id=?;");
	            pstAllRecords.setInt(1, auction_id);
	    		
	    		ResultSet rsAllRecords = pstAllRecords.executeQuery();
	    		
	    		List<AutoBidderInfo> bidders = new ArrayList<>();
	    		while (rsAllRecords.next()) {
	    			AutoBidderInfo bidder = new AutoBidderInfo();
	    			bidder.setEmail(rsAllRecords.getString("name"));
	    			bidder.setEmail(rsAllRecords.getString("email"));
	    		    bidder.setAuctionId(rsAllRecords.getInt("auction_id"));
	    		    bidder.setStartingCost(rsAllRecords.getDouble("starting_cost"));
	    		    bidder.setCurrentPrice(rsAllRecords.getDouble("current_price"));
	    		    bidder.setLatestBidBy(rsAllRecords.getString("latest_bid_by"));
	    		    bidder.setUpperBound(rsAllRecords.getDouble("upper_bound"));
	    		    bidder.setBidIncrement(rsAllRecords.getDouble("bid_increment"));
	    		    bidder.setNextBidLowerBound(rsAllRecords.getDouble("next_bid_lower_bound"));
	    		    bidders.add(bidder);
	    		}
	    		System.out.println(bidders);
	    		
	    		// run this loop till there are atleast 2 people bidding on the item!
	    		// once there is just one person bidding on the item, you get the winner and the current_price!
	    		while(bidders.size() > 1) {
	    			// one iteration through the bidding loop set up. so A B C D will bid in this order!
	    			for(int i=0;i<bidders.size();i++) {
	    				// check the upper_bound of the auto_bid set up
	    				// write a select query here, silly!
	    				
	    				
	    				PreparedStatement selectQueryForCurrentPrice = con.prepareStatement("select * from auction where auction_id=?");
	    				selectQueryForCurrentPrice.setInt(1, auction_id);
	    				ResultSet rs4 = selectQueryForCurrentPrice.executeQuery();
	    				double nowCurrentPrice = 0;
	    				if(rs4.next()) {
	    					nowCurrentPrice = rs4.getDouble("current_price");
	    				}
	    				
	    				
	    				
	    				
	    				double newCurrentPrice = nowCurrentPrice + bidders.get(i).getBidIncrement();
	    				if(bidders.get(i).getUpperBound() >= newCurrentPrice) {
	    					// update current_price (auction table) and latest_bid_by (auction table)
	    					PreparedStatement pstAutoBid = con.prepareStatement("UPDATE auction SET current_price = ?, latest_bid_by = ?, latest_time=? WHERE auction_id = ?");
	    					pstAutoBid.setDouble(1,  newCurrentPrice);
	    					pstAutoBid.setString(2, bidders.get(i).getLatestBidBy());
	    					pstAutoBid.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
	    					pstAutoBid.setInt(4, auction_id);
	    					
	    					pstAutoBid.executeUpdate();
	    					
	    					// also update the auction_bids table!
	    					// insert into bid_logs table
	    					PreparedStatement pstAuctionBids = con.prepareStatement("UPDATE auction_bids SET bid_time=?, email=?, bid_value=? where auction_id=?");
	    					pstAuctionBids.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
	    					pstAuctionBids.setString(2, bidders.get(i).getEmail());
	    					pstAuctionBids.setDouble(3, newCurrentPrice);
	    					pstAuctionBids.setInt(4, auction_id);
	    					pstAuctionBids.executeUpdate();
	    					
	    					
	    					PreparedStatement pstBidLogs = con.prepareStatement("INSERT INTO bid_logs (email, auction_id, bid_value) VALUES (?, ?, ?)");
	    					pstBidLogs.setString(1, bidders.get(i).getEmail());
	    					pstBidLogs.setInt(2, auction_id);
	    					pstBidLogs.setDouble(3, newCurrentPrice);
	    					pstBidLogs.executeUpdate();

	    				}
	    				
	    				else {
	    					// remove entry from list because person is not biding for the item anymore!
	    					bidders.remove(i);
	    				}
	    			}
	    		}
	    		// bidders currently only has the winner
	            System.out.println(bidders);
	            System.out.println("Done!!!!!");
            }
            
            
            
         
    		dispatcher = request.getRequestDispatcher("index.jsp");
    		dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
