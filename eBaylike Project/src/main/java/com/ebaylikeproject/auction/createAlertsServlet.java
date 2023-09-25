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
 * Servlet implementation class createAlertsServlet
 */
@WebServlet("/createalerts")
public class createAlertsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createAlertsServlet() {
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
        System.out.println("hello there!!!");
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        String item_name = request.getParameter("item_name");
        String type = request.getParameter("type");
     
        Connection con = null;
        PreparedStatement pst = null;
        RequestDispatcher dispatcher = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
            
            Timestamp create_time = new Timestamp(System.currentTimeMillis());
            int alert_id = 0;
            String createsAlertString = "INSERT INTO creates_alert(create_time, user_email) VALUES (?,?)";
            PreparedStatement createsAlertStringStmt = con.prepareStatement(createsAlertString, Statement.RETURN_GENERATED_KEYS);
            System.out.println("reached here");
            
            createsAlertStringStmt.setTimestamp(1, create_time);
            createsAlertStringStmt.setString(2, email);
            createsAlertStringStmt.executeUpdate();
            
            // Retrieve the generated alert_id
            ResultSet rs = createsAlertStringStmt.getGeneratedKeys();
            System.out.println("reached here 1");
            if (rs.next()) {
                alert_id = rs.getInt(1);
            }
            else {
                throw new SQLException("Failed to retrieve auto-generated auction ID");
            }
            System.out.println("alert_id: "+alert_id);
            createsAlertStringStmt.close();
            
            // select query to fetch item_id based on item_name and/or type
            String selectQueryAlertsString = "select * from item";
            
            if(item_name != "") {
                selectQueryAlertsString += " where item_name=?";
            }
            if(type != "") {
                if(item_name != "") {
                    selectQueryAlertsString += " and type=?";
                } else {
                    selectQueryAlertsString += " where type=?";
                }
            }
            System.out.println("hello");
            System.out.println(item_name);
            System.out.println(type);
            System.out.println(selectQueryAlertsString);
            PreparedStatement selectQueryAlertsStringStmt = con.prepareStatement(selectQueryAlertsString);
            if(item_name != "" && type != "") {
                selectQueryAlertsStringStmt.setString(1, item_name);
                selectQueryAlertsStringStmt.setString(2, type);
            } else if(item_name != "") {
                selectQueryAlertsStringStmt.setString(1, item_name);
            } else if(type != "") {
                selectQueryAlertsStringStmt.setString(1, type);
            }
            
            ResultSet rsStmt = selectQueryAlertsStringStmt.executeQuery();
            int item_id = 0;
            if(rsStmt.next()) {
                item_id = rsStmt.getInt("item_id");
            }
            
            System.out.println("item_id: "+item_id);
            
    		// Insert into alert_created_on table using the retrieved alert_id
    		String alertCreatedOnString = "INSERT INTO alert_created_on(alert_id, item_id) VALUES (?,?)";
    		PreparedStatement alertCreatedOnStringStmt = con.prepareStatement(alertCreatedOnString);
    		
    		alertCreatedOnStringStmt.setInt(1, alert_id);
    		alertCreatedOnStringStmt.setInt(2, item_id);
    		alertCreatedOnStringStmt.executeUpdate();
    		alertCreatedOnStringStmt.close();
    		
    		dispatcher = request.getRequestDispatcher("index.jsp");
    		dispatcher.forward(request, response);
	        
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	        // output an error message
	        response.getWriter().println("Error submitting answer.");
	    } finally {
	        // close the database connection and statement
	        
	        if (con != null) {
	            try {
	                con.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}

}
