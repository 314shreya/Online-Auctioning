package com.ebaylikeproject.functionalities;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.credentials.Credentials;

/**
 * Servlet implementation class custRepQAns
 */
@WebServlet("/custRepQAns")
public class custRepQAns extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public custRepQAns() {
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
		int questionId = Integer.parseInt(request.getParameter("questionId"));
	    String answer = request.getParameter("answer");
	 // update the corresponding question in the database with the answer
	    Connection con = null;
	    PreparedStatement pst = null;
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	        con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password);
	        String query = "UPDATE question SET answer = ? WHERE question_id = ?";
	        pst = con.prepareStatement(query);
	        pst.setString(1, answer);
	        pst.setInt(2, questionId);
	        int rowsUpdated = pst.executeUpdate();
	        if (rowsUpdated > 0) {
	            // output a success message
	        	RequestDispatcher dispatcher = null;
				dispatcher = request.getRequestDispatcher("index.jsp");
				dispatcher.forward(request, response);
	        } else {
	            // output an error message
	            response.getWriter().println("Error submitting answer.");
	        }
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	        // output an error message
	        response.getWriter().println("Error submitting answer.");
	    } finally {
	        // close the database connection and statement
	        if (pst != null) {
	            try {
	                pst.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
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
