package com.ebaylikeproject.auction;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

/**
 * Servlet implementation class AuctionManagementServlet
 */
@WebServlet("/AuctionManagementServlet")
public class AuctionManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuctionManagementServlet() {
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
		String auction_id = request.getParameter("auction_id");
		String buttonAction = request.getParameter("submit_btn");
		if (buttonAction.equals("delete"))
		{
			Connection con = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
	    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
	    		String stmtString = "update auction set is_active = ? where auction_id = ?";
	    		PreparedStatement pst = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
	    		pst.setInt(1, 0);
	    		pst.setString(2, auction_id);
	    		pst.executeUpdate();
	    		pst.close();
	    		RequestDispatcher dispatcher = null;
	    		request.setAttribute("status", "auction_manage");
	    		dispatcher = request.getRequestDispatcher("index.jsp");
	    		dispatcher.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
