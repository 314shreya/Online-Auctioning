package com.ebaylikeproject.registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.credentials.Credentials;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
//    	create table users(name varchar(50), password varchar(50),email varchar(50), phone varchar(10), address varchar(50), logged_in varchar(5), is_active varchar(5), PRIMARY KEY(email));
    	String uname = request.getParameter("name");
    	String upwd = request.getParameter("password");
    	String uemail = request.getParameter("email");
    	String uphone = request.getParameter("phone");
    	String uaddr = request.getParameter("address");
    	Connection con = null;
    	RequestDispatcher dispatcher = null;
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
//    		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebay?useSSL=false", "root", "mysql");
    		PreparedStatement pst = con.prepareStatement("select * from users where email=?");
    		pst.setString(1,uemail);
    		
    		ResultSet rs = pst.executeQuery();
    		if (rs.next())
    		{
    			dispatcher = request.getRequestDispatcher("registration.jsp");
    			request.setAttribute("status", "failed");
    		}
    		else
    		{
    			PreparedStatement pst2 = con.prepareStatement("insert into users(name, password, email, phone, address, logged_in, is_active) values (?,?,?,?,?,?,?)");
        		pst2.setString(1, uname);
        		pst2.setString(2, upwd);
        		pst2.setString(3, uemail);
        		pst2.setString(4, uphone);
        		pst2.setString(5, uaddr);
				pst2.setString(6, "no");
				pst2.setString(7, "yes");
        		int rowCount = pst2.executeUpdate();
        		dispatcher = request.getRequestDispatcher("login.jsp");
        		if(rowCount > 0) {
        			request.setAttribute("status", "success");
        		}
        		else {
        			request.setAttribute("status", "failed");
        		}
    		}
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
