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

/**
 * Servlet implementation class CustomerRepresentativeServlet
 */
@WebServlet("/CustomerRepresentativeServlet")
public class CustomerRepresentativeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerRepresentativeServlet() {
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
		String uemail = (String) request.getParameter("uemail");
		System.out.println("user email : "+ uemail);
		Connection con = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
    		String stmtString = "update users set is_admin=1 where email=?";
    		PreparedStatement stmt = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
    		stmt.setString(1, uemail);
    		stmt.executeUpdate();
    		stmt.close();
			dispatcher = request.getRequestDispatcher("customer_representative.jsp");
			request.setAttribute("status", "success");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			request.setAttribute("status", "failed");
			e.printStackTrace();
		}
	}

}
