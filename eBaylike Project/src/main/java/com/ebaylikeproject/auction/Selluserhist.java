package com.ebaylikeproject.auction;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.credentials.Credentials;

/**
 * Servlet implementation class Selluserhist
 */
@WebServlet("/Selluserhist")
public class Selluserhist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Selluserhist() {
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
		String email = (String) session.getAttribute("email");
		PrintWriter out = response.getWriter();
		String seller_data = request.getParameter("seller_data");
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
				+ "  border: 1px solid black;\n text-align: center;\n"
				+ "}"
				+ "table {\n"
				+	"width: 100%;\n"
				+"}\n"
				+ "td{"
				+ "padding:10px;}"
				+ "h3{"
				+ "display:inline;}"
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
			PreparedStatement pst = con.prepareStatement("select item.type as type, item_name, item.color as color, item.manufacturer as manufacturer, item.fuel_type as fuel_type, item.passengers as passengers, item.mileage as mileage, end_date as date, auction_id from item NATURAL JOIN auction NATURAL JOIN makes where email = ?");
			pst.setString(1, seller_data);
			System.out.println("New PST"+pst);
			ResultSet rs = pst.executeQuery();
			
			
			out.println("<h2> History of Email: "+ seller_data +"</h2>");
			out.println("<table >");
			out.println("<tr> <th>Auction_id</th> <th> Item Name </th> <th> Item Type </th> <th> Manufacturer </th> <th>Color</th> <th>Fuel Type</th> <th>No. of passengers</th> <th>Mileage</th> <th> End Date </th> </tr>");
			while (rs.next())
			{
				out.println("<tr><td>"+rs.getString("auction_id")+"</td>"+"<td>"+rs.getString("item_name")+"</td><td>"+rs.getString("type")+"</td><td>"+rs.getString("manufacturer")+"</td>"+"<td>"+rs.getString("color")+"</td>"+"<td>"+rs.getString("fuel_type")+"</td>"+"<td>"+rs.getInt("passengers")+"</td>"+"<td>"+rs.getDouble("mileage")+"</td><td>"+rs.getString("date")+"</td></tr>");
			}
			out.println("</table>");
			out.println("</body></html>");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
