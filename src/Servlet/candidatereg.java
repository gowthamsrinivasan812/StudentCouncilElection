package Servlet;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.dbconn;

/**
 * Servlet implementation class candidatereg
 */
@WebServlet("/candidatereg")
public class candidatereg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public candidatereg() {
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
		doGet(request, response);

        String name = request.getParameter("name");
        String regno = request.getParameter("regno");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Empty check
        if (name == null || regno == null || mobile == null || email == null ||
            department == null || password == null || confirmPassword == null ||
            name.isEmpty() || regno.isEmpty() || mobile.isEmpty() || email.isEmpty() ||
            department.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("candidatereg.jsp").forward(request, response);
            return;
        }

        // Password match check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.getRequestDispatcher("candidatereg.jsp").forward(request, response);
            return;
        }

        try {
            java.sql.Connection con = dbconn.create();

            String sql = "INSERT INTO  candidatereg" +
                         "(sname,sregno, smobile, email, department, password, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, regno);
            ps.setString(3, mobile);
            ps.setString(4, email);
            ps.setString(5, department);
            ps.setString(6, password); 
            ps.setString(7, "PENDING");

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("candidatelog.jsp?msg=registered");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed. Try again.");
            request.getRequestDispatcher("candidatereg.jsp").forward(request, response);
        }
    
	}

}
