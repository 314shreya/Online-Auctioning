package com.ebaylikeproject.auction;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
 * Servlet implementation class AccountUpdateServlet
 */
@WebServlet("/AccountUpdateServlet")
public class AccountUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountUpdateServlet() {
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
		HttpSession session = request.getSession(false);
		String uemail = request.getParameter("uemail");
		String user_name = request.getParameter("username");
		String user_pass = request.getParameter("userpass");
		String user_phone = request.getParameter("userphone");
		String user_addr = request.getParameter("useraddr");
		Connection con = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password); 
    		String stmtString = "update users set name = ?, password = ?, phone = ?, address = ?  where email = ?";
    		PreparedStatement stmt = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
    		stmt.setString(1, user_name);
            stmt.setString(2, user_pass);
            stmt.setString(3, user_phone);
            stmt.setString(4, user_addr);
            stmt.setString(5, uemail);
            
            stmt.executeUpdate();
            
            System.out.println("Updated user account information");
           
            stmt.close();
    		dispatcher = request.getRequestDispatcher("index.jsp");
    		dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
