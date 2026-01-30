package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dbcon.dbconn;

@WebServlet("/applyforvote")

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,         // 5MB
    maxRequestSize = 1024 * 1024 * 5
)
public class applyforvote extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("voterlogin.jsp");
            return;
        }

        // Fetch student details from session
        String name = (String) session.getAttribute("studentName");
        String email = (String) session.getAttribute("studentEmail");
        String course = (String) session.getAttribute("studentcourse");
        String subject = (String) session.getAttribute("studentsubject");

        // Fetch uploaded photo
        Part filePart = request.getPart("photo");
        InputStream inputStream = null;

        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        String sql = "INSERT INTO voteid " +
                     "(studentname, studentmail, student_course, student_sub, pic,votekey, status, Edate) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = dbconn.create();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, course);
            ps.setString(4, subject);

            if (inputStream != null) {
                ps.setBinaryStream(5, inputStream, (int) filePart.getSize());
            } else {
                ps.setBinaryStream(5, inputStream);
            }

            ps.setString(6," "); // votekey
            ps.setString(7, "Pending");
            ps.setString(8, " ");    // Edate

            ps.executeUpdate();

            response.sendRedirect("applysuccessfully.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Application Failed!");
            request.getRequestDispatcher("studentapplyvote.jsp").forward(request, response);
        }
    }
}
