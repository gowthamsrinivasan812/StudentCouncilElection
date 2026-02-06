package Servlet;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import dbcon.dbconn;

/**
 * Servlet implementation class studentreg
 */
@WebServlet("/studentreg")
public class studentreg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public studentreg() {
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
    	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    	        throws ServletException, IOException {

    	   
    	    String name = request.getParameter("name");
    	    String email = request.getParameter("email");
    	    String mobile = request.getParameter("mobile");
    	    String course = request.getParameter("course");
    	   
    	    String pass=request.getParameter("pass");

    	   
    	    if (name == null || name.isEmpty() ||
    	        email == null || email.isEmpty() ||
    	        mobile == null || mobile.isEmpty() ||
    	        course == null || course.isEmpty() ||
    	        
    	         pass== null || pass.isEmpty()) {

    	        request.setAttribute("message", "All fields are required!");
    	        request.getRequestDispatcher("voterreg.jsp").forward(request, response);
    	        return; 
    	    }

    	   
    	    try {
    	        java.sql.Connection con = dbconn.create();
    	        String sql = "INSERT INTO studentreg  VALUES (id, ?, ?, ?, ?, ?)";
    	        PreparedStatement statement = con.prepareStatement(sql);
    	        statement.setString(1, name);
    	        statement.setString(2, email);
    	        statement.setString(3, mobile);
    	        statement.setString(4, course);
    	        
    	        statement.setString(5, pass);

    	        int rows = statement.executeUpdate();
    	        statement.close();
    	        con.close();

    	        if (rows > 0) {
    	          
    	            response.sendRedirect("voterlogin.jsp?msg=registered");
    	        } else {
    	            
    	            request.setAttribute("message", "Registration failed! Please try again.");
    	            request.getRequestDispatcher("voterreg.jsp").forward(request, response);
    	        }

    	    } catch (Exception e) {
    	        e.printStackTrace();
    	        request.setAttribute("message", "Error: " + e.getMessage());
    	        request.getRequestDispatcher("voterreg.jsp").forward(request, response);
    	    }
    	}

}
