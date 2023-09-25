package com.ebaylikeproject.functionalities;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

/**
 * Servlet implementation class questionAns
 */
@WebServlet("/questionAns")
public class questionAns extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public questionAns() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String question = request.getParameter("question");
		String userEmail = (String) session.getAttribute("email");
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
    		con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
    		int question_id = 0;
    		String stmtString = "INSERT INTO question (question_description, email) "
    				+ "VALUES (?, ?)";
    		PreparedStatement stmt = con.prepareStatement(stmtString, Statement.RETURN_GENERATED_KEYS);
    		
    		stmt.setString(1, question);
            stmt.setString(2, userEmail);
            
            stmt.executeUpdate();
            ResultSet generatedKeysAuction = stmt.getGeneratedKeys();
            if (generatedKeysAuction.next()) {
            	question_id = generatedKeysAuction.getInt(1);
            	
            } else {
                throw new SQLException("Failed to retrieve auto-generated auction ID");
            }
            
            System.out.println("question_id: "+question_id);
            stmt.close();
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
        response.sendRedirect("q&a.jsp");
	}

}
