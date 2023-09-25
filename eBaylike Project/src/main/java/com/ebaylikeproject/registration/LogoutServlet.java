package com.ebaylikeproject.registration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
//		if(session!=null){
//			session.invalidate();
//			response.sendRedirect("login.jsp");
//		}
		
		String email = (String) session.getAttribute("email");

    	Connection con = null;
    	RequestDispatcher dispatcher = null;
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
//    		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebay?useSSL=false", "root", "mysql");


			PreparedStatement pst2 = con.prepareStatement("update users set logged_in=? where email=?");
			pst2.setString(1, "no");
			pst2.setString(2, email);
			int rowCount = pst2.executeUpdate();
			dispatcher = request.getRequestDispatcher("login.jsp");
			if(rowCount > 0) {
    			request.setAttribute("status", "logout");
    		}
			session.setAttribute("name", null);
    		dispatcher.forward(request, response);
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
	}
}

