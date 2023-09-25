package com.ebaylikeproject.auction;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;  
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

/**
 * Servlet implementation class AuctionServlet
 */
@WebServlet("/createauction")
public class AuctionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
		// create table item(item_id int not null auto_increment, item_name varchar(255), type varchar(255), is_active tinyint(1), create_time timestamp, primary key (item_id));
		// create table auction(auction_id int not null auto_increment, starting_cost double, next_bid_lower_bound double, create_time timestamp, current_price double, latest_time timestamp, is_active tinyint(1), primary key(auction_id));
		// create table created_auction(item_id int not null,auction_id int not null, primary key(item_id,auction_id), FOREIGN KEY (item_id) REFERENCES item (item_id), FOREIGN KEY (auction_id) REFERENCES auction (auction_id));
		// create table makes(email varchar(50), auction_id int not null, primary key(auction_id), FOREIGN KEY (auction_id) REFERENCES auction(auction_id), FOREIGN KEY (email) REFERENCES users (email));
		
		System.out.println("here");
		HttpSession session = request.getSession(false);
		String item_name = request.getParameter("item_name");
		String type = request.getParameter("type");
		String color = request.getParameter("color");
		String manufacturer = request.getParameter("manufacturer");
		String fuel_type = request.getParameter("fuel_type");
		int passengers = Integer.parseInt(request.getParameter("passengers"));
		double mileage = Double.parseDouble(request.getParameter("mileage"));
		Timestamp create_time = new Timestamp(System.currentTimeMillis()); 
		Timestamp latest_time = create_time;
	    boolean is_active = true;
	    System.out.println("here1");
    	double starting_cost = Double.parseDouble(request.getParameter("starting_cost"));
    	double next_bid_lower_bound = Double.parseDouble(request.getParameter("next_bid_lower_bound"));
    	double highest_price = Double.parseDouble(request.getParameter("highest_bound"));
    	double current_price = starting_cost;
    	String end_date = request.getParameter("end_date");
    	//System.out.println(end_date);
    	Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(end_date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("End date " + date + " 	New " + request.getParameter("end_date") );
    	String email = (String) session.getAttribute("email");
    	java.sql.Date sqlDate = new java.sql.Date(date.getTime());
    	Connection con = null;
    	RequestDispatcher dispatcher = null;
    	System.out.println("here2");
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
//    		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebay?useSSL=false", "root", "mysql");
    		
    		int auction_id = 0;
    		String stmtString = "INSERT INTO auction (starting_cost, next_bid_lower_bound,highest_price, end_date, create_time, current_price, latest_time, is_active) "
    				+ "VALUES (?, ?, ?,?,?, ?, ?, ?)";
    		PreparedStatement stmt = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
    		
            stmt.setDouble(1, starting_cost);
            stmt.setDouble(2, next_bid_lower_bound);
            stmt.setDouble(3, highest_price);
            stmt.setDate(4, sqlDate);
            stmt.setTimestamp(5, create_time);
            stmt.setDouble(6, current_price);
            stmt.setTimestamp(7, latest_time);
            stmt.setBoolean(8, is_active);
            stmt.executeUpdate();
            
            ResultSet generatedKeysAuction = stmt.getGeneratedKeys();
            if (generatedKeysAuction.next()) {
                auction_id = generatedKeysAuction.getInt(1);
            	
            } else {
                throw new SQLException("Failed to retrieve auto-generated auction ID");
            }
            
            System.out.println("auction id: "+auction_id);
            stmt.close();
            
            String makes_string = "INSERT INTO makes (email, auction_id) "
        			+ "VALUES (?, ?)";
        	PreparedStatement makepst = con.prepareStatement(makes_string, Statement.RETURN_GENERATED_KEYS);
        	makepst.setString(1, email);
        	makepst.setInt(2, auction_id);
        	makepst.executeUpdate();
        	makepst.close();
            
            
            
        // check if item already exists in the db, if not- insert item into db
        PreparedStatement select1 = con.prepareStatement("SELECT item_id from item where item_name=? and type=?");
        select1.setString(1, item_name);
        select1.setString(2, type);
        int item_id = 0;
        System.out.println("momo1");
        ResultSet rs = select1.executeQuery();
        
        if(rs.next()) {
        	// item exists in db
        	// just get the item_id of the item to update in the created_auction table
        	item_id = rs.getInt("item_id");
        	System.out.println("item id1: "+item_id);
        }
        else {
        	// insert item into db
        	String stmt1String = "INSERT INTO item (item_name, type, color, manufacturer, fuel_type, passengers, mileage, is_active, create_time) "
        			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        	PreparedStatement stmt1 = con.prepareStatement(stmt1String, Statement.RETURN_GENERATED_KEYS);
            
        	
            
            stmt1.setString(1, item_name);
            stmt1.setString(2, type);
            stmt1.setString(3, color);
            stmt1.setString(4, manufacturer);
            stmt1.setString(5, fuel_type);
            stmt1.setInt(6, passengers);
            stmt1.setDouble(7, mileage);
            stmt1.setBoolean(8, is_active);
            stmt1.setTimestamp(9, create_time);
            stmt1.executeUpdate();
            ResultSet generatedKeysItem = stmt1.getGeneratedKeys();
            if (generatedKeysItem.next()) {
                item_id = generatedKeysItem.getInt(1);
                System.out.println("item id: "+item_id);
            } else {
                throw new SQLException("Failed to retrieve auto-generated item ID");
            }
            stmt1.close();
        }
        
        rs.close();
        select1.close();
        
         // Insert mapping between item and auction into the "created_auction" table
        PreparedStatement stmt2 = con.prepareStatement("INSERT INTO created_auction(item_id, auction_id) VALUES (?, ?)");
        stmt2.setInt(1, item_id);
        stmt2.setInt(2, auction_id);
        stmt2.executeUpdate();
        stmt2.close();
        
        System.out.println("Done with created_auction");
        
        stmt2 = con.prepareStatement("INSERT INTO auction_bids(bid_time, email, auction_id,bid_value) VALUES (?, ?,?,?)");
        stmt2.setTimestamp(1, latest_time);
        stmt2.setString(2, null);
        stmt2.setInt(3,auction_id);
        stmt2.setDouble(4, current_price);
        stmt2.executeUpdate();
        stmt2.close();
        
        System.out.println("Done with auction_bids in AucntionServelt");
        
            
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	finally {
    		try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	// Returning a success response to the client
        response.sendRedirect("index.jsp");
        //response.getWriter().println("Auction created successfully");
	}

}
