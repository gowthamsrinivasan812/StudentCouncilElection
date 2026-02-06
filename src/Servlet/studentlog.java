package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import dbcon.dbconn;

/**
 * Servlet implementation class studentlog
 */
@WebServlet("/studentlog")
public class studentlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public studentlog() {
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

        String email = request.getParameter("email");
        String password = request.getParameter("password"); 

       
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("studentlogin.jsp?error=empty_fields");
            return;
        }

        Connection con=null;
        try {
            con=(Connection) dbconn.create();
        	String sql = "SELECT * FROM studentreg WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
              
                HttpSession session = request.getSession();
                session.setAttribute("studentName", rs.getString("name"));
                session.setAttribute("studentEmail", rs.getString("email"));
                session.setAttribute("mobile",rs.getString("mobile"));
                session.setAttribute("studentcourse", rs.getString("course"));
               
                
                response.sendRedirect("votermain.jsp"); 
            } else {
                
                response.sendRedirect("voterlogin.jsp?error=user_not_found");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("voterlogin.jsp?error=server_error");
        }
    }
}
