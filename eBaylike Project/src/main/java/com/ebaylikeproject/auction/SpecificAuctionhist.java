package com.ebaylikeproject.auction;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

/**
 * Servlet implementation class SpecificAuctionhist
 */
@WebServlet("/SpecificAuctionhist")
public class SpecificAuctionhist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SpecificAuctionhist() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		String email = (String) session.getAttribute("email");
		PrintWriter out = response.getWriter();
		String auction_data = request.getParameter("auction_data");
		String auction_id = auction_data.split(" ")[0];
		Connection con = null;
		out.println("<html><head>"
				+ "<link rel=\"stylesheet\" href=\"style.css\">\n"
				+ "<style>"
				+ "body {\r\n"
				+ "	  margin: 0;\r\n"
				+ "	  font-family: Arial, Helvetica, sans-serif;\r\n"
				+ "	}\r\n"
				+ "	\r\n"
				+ "	.nav_bar {\r\n"
				+ "	  overflow: hidden;\r\n"
				+ "	  background-color: #333;\r\n"
				+ "	}\r\n"
				+ "	\r\n"
				+ "	.nav_bar a {\r\n"
				+ "	  float: left;\r\n"
				+ "	  color: #f2f2f2;\r\n"
				+ "	  text-align: center;\r\n"
				+ "	  padding: 14px 16px;\r\n"
				+ "	  text-decoration: none;\r\n"
				+ "	  font-size: 17px;\r\n"
				+ "	}\r\n"
				+ "	\r\n"
				+ "	.nav_bar a:hover {\r\n"
				+ "	  background-color: #ddd;\r\n"
				+ "	  color: black;\r\n"
				+ "	}\r\n"
				+ "	\r\n"
				+ "	.nav_bar a.is_act {\r\n"
				+ "	  background-color: #265df2;\r\n"
				+ "	  color: white;\r\n"
				+ "	}\r\n"
				+ "	.nav_bar a.log_out {\r\n"
				+ "	background-color: orange;\r\n"
				+ "	float: right;\r\n"
				+ "	color: white;\r\n"
				+ "	}\r\n"
				+ "\r\n"
				+ "	.index_body {\r\n"
				+ "		text-align: center;\r\n"
				+ "		padding-text: 10px;\r\n"
				+ "		padding-top: 100px;\r\n"
				+ "		padding-bottom: 100px;\r\n"
				+ "	}\r\n"
				+ "	.bd_index{\r\n"
				+ "		background-color: #265df2;\r\n"
				+ "		\r\n"
				+ "	}\r\n"
				+ "	.footer {\r\n"
				+ "	position: fixed;\r\n"
				+ "	left: 0;\r\n"
				+ "	bottom: 0;\r\n"
				+ "	padding-bottom: 1px;\r\n"
				+ "	width: 100%;\r\n"
				+ "	background-color: #333;\r\n"
				+ "	color: white;\r\n"
				+ "	line-height:2em;\r\n"
				+ "	text-align: center;\r\n"
				+ "	text-color: white;\r\n"
				+ "	}"
				+ "table, th, td {\n"
				+ "  border: 1px solid black;\n"
				+ " text-align: center;\n"
				+ "}"
				+ "td{"
				+ "padding:10px;}"
				+ "h3{"
				+ "display:inline;}"
				+ "table {\n"
				+ "  width: 100%;\n"
				+"}\n"
				+ "</style>\n"
				+ "</head>");
		out.println("<body style=\"background-color: #265df2\">"
				+ "<div class=\"nav_bar\">\r\n"
				+ "  <a  href=\"index.jsp\">Home</a>\r\n"
				+ "  <a href=\"auctionbids.jsp\">Buy</a>\r\n"
				+ "  <a href=\"auction.jsp\">Sell</a>\r\n"
				+ "  <a href=\"created_auction.jsp\">Created Auction</a>\r\n"
				+ "  <a class=\"is_act\"  href=\"search.jsp\">Search</a>\r\n"
				+ "  <a class = \"log_out\" href=\"logout\">Sign Out</a>\r\n"
				+ "</div>");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(Credentials.url, Credentials.username, Credentials.password); 
			 //System.out.println(dtf.format(now));
			int id = Integer.parseInt(auction_id);
			PreparedStatement pst = con.prepareStatement("select makes.email as email, end_date, type, item_name from item NATURAL JOIN auction NATURAL JOIN makes where auction_id = ?");
			pst.setInt(1, id);
			System.out.println("search pst " + pst);
			ResultSet rs = pst.executeQuery();
			//System.out.println(rs.getDate("end_date"));
			System.out.println( "IN");
			
			if(rs.next())
			{
				out.println("<h3> Created By: " + rs.getString("email")+"  </h3>");
				out.println("<h3> Item type: " + rs.getString("type")+"  </h3>" );
				out.println("<h3> Item name: " + rs.getString("item_name")+"  </h3>" );
				out.println("<h3> End Date: " + rs.getString("end_date")+"  </h3>" );
			}
			
			pst = con.prepareStatement("select email, bid_value from bid_logs where auction_id = ?");
			pst.setInt(1, Integer.parseInt(auction_id));
			System.out.println("New PST"+pst);
			rs = pst.executeQuery();
			
			
			
			out.println("<table>");
			out.println("<tr> <th>User</th> <th> bid_value </th> </tr>");
			while (rs.next())
			{
				out.println("<tr><td>"+rs.getString("email")+"</td>"+"<td>"+rs.getDouble("bid_value")+"</td>");
			}
			out.println("</table>");
			out.println("</body></html>");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
