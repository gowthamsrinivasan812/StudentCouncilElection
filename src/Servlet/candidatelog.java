package Servlet;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;

import dbcon.dbconn;

/**
 * Servlet implementation class candidatelog
 */
@WebServlet("/candidatelog")
public class candidatelog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public candidatelog() {
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

        String userInput = request.getParameter("userInput");
        String password = request.getParameter("password");

        if (userInput == null || password == null || userInput.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Register Number/Email and Password are required");
            request.getRequestDispatcher("candidatelog.jsp").forward(request, response);
            return;
        }

        try {
            
            java.sql.Connection con = dbconn.create();

            
            String sql = "SELECT * FROM candidatereg WHERE sregno=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userInput);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

         
                    HttpSession session = request.getSession();
                    session.setAttribute("candidateRegno", rs.getString("sregno"));
                    session.setAttribute("candidateName", rs.getString("sname"));
                    session.setAttribute("candidateEmail", rs.getString("email"));
                    session.setAttribute("smobile", rs.getString("smobile"));
                    session.setAttribute("dept", rs.getString("department"));
                    response.sendRedirect("candidatemain.jsp");

   
                    
                    

            } else {
                request.setAttribute("errorMessage", "Invalid Register Number / Email or Password");
                request.getRequestDispatcher("candidatelog.jsp").forward(request, response);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error. Try again later.");
            request.getRequestDispatcher("candidatelog.jsp").forward(request, response);
        }
    }

}
