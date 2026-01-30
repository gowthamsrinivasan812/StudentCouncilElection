package Servlet;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.itextpdf.text.pdf.codec.Base64.InputStream;
import com.mysql.jdbc.Connection;

import dbcon.dbconn;

/**
 * Servlet implementation class candidateapply
 */
@WebServlet("/candidateapply")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,   // 1MB
	    maxFileSize = 5 * 1024 * 1024,      // 5MB
	    maxRequestSize = 10 * 1024 * 1024   // 10MB
	)
public class candidateapply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public candidateapply() {
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

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("candidateEmail") == null) {
            response.sendRedirect("studentlogin.jsp");
            return;
        }

        String classDept = request.getParameter("Class");
        String roll = request.getParameter("roll");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");

        Part filePart = request.getPart("file");
        java.io.InputStream inputStream = filePart.getInputStream();
        int fileSize = (int) filePart.getSize();


        try (java.sql.Connection con = dbconn.create()) {

            String sql = "INSERT INTO nominatecandidate"
                       + "(class_department, roll_number, email, mobile, student_id_photo, status) "
                       + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, classDept);
            ps.setString(2, roll);
            ps.setString(3, email);
            ps.setString(4, mobile);
            ps.setBinaryStream(5, inputStream, fileSize);            
            ps.setString(6, "Pending");
            int row = ps.executeUpdate();

            ps.close();

            if (row > 0) {
                response.sendRedirect("candiateapply.jsp");
            } else {
                request.setAttribute("errorMessage", "Application failed. Try again.");
                request.getRequestDispatcher("candiateapply.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server Error: " + e.getMessage());
            request.getRequestDispatcher("candiateapply.jsp").forward(request, response);
        }
    }

}
