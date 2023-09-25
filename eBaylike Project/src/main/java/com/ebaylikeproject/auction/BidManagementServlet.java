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
 * Servlet implementation class BidManagementServlet
 */
@WebServlet("/BidManagementServlet")
public class BidManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BidManagementServlet() {
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
		HttpSession session = request.getSession(false);
		String bid_id = request.getParameter("bid_id");
		String buttonAction = request.getParameter("submit_btn");
		PrintWriter out = response.getWriter();
		if (buttonAction.equals("delete"))
		{
			Connection con = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
	    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
	    		String stmtString = "delete from auction_bids where bid_id = ?";
	    		PreparedStatement pst = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
	    		pst.setString(1, bid_id);
	    		pst.executeUpdate();
	    		pst.close();
	    		RequestDispatcher dispatcher = null;
	    		request.setAttribute("status", "bid_manage");
	    		dispatcher = request.getRequestDispatcher("index.jsp");
	    		dispatcher.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
