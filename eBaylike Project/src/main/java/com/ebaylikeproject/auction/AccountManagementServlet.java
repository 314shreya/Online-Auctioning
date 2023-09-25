package com.ebaylikeproject.auction;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AccountManagementServlet
 */
@WebServlet("/AccountManagementServlet")
public class AccountManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountManagementServlet() {
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
		String uemail = request.getParameter("uemail");
		String buttonAction = request.getParameter("submit_btn");
		if (buttonAction.equals("update"))
		{
			Connection con = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
	    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
	    		PreparedStatement pst = con.prepareStatement("SELECT name as name, password as password, phone as phone, address as address from users where email=?");
	    		pst.setString(1, uemail);
	    		
	    		ResultSet rs = pst.executeQuery();
	    		if(rs.next()) {
	    			request.setAttribute("name", rs.getString("name"));
	    			request.setAttribute("uemail", uemail);
		    		request.setAttribute("password", rs.getString("password"));
					request.setAttribute("phone", rs.getString("phone"));
					request.setAttribute("address", rs.getString("address"));
					RequestDispatcher dispatcher = null;
					dispatcher = request.getRequestDispatcher("account_update.jsp");
					dispatcher.forward(request, response);
	    		}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		else
		{
			Connection con = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
	    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
	    		PreparedStatement pst = con.prepareStatement("DELETE from users where email=?");
	    		pst.setString(1, uemail);
	    		
	    		pst.executeUpdate();
	    		pst.close();
	    		RequestDispatcher dispatcher = null;
	    		dispatcher = request.getRequestDispatcher("index.jsp");
	    		dispatcher.forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
