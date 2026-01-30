package Servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dbcon.dbconn;

@WebServlet("/Eligible")
@MultipartConfig(
    maxFileSize = 16177215,
    maxRequestSize = 16177215 * 5
)
public class Eligible extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       
        String rollno = request.getParameter("rollno");
        String department = request.getParameter("department");
        String email = request.getParameter("email");

       
        Part filePart = request.getPart("file");
        byte[] symbolBytes = null;

        if (filePart != null && filePart.getSize() > 0) {
            InputStream inputStream = filePart.getInputStream();
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();

            byte[] temp = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(temp)) != -1) {
                buffer.write(temp, 0, bytesRead);
            }
            symbolBytes = buffer.toByteArray();
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        byte[] studentPhoto = null;

        try {
            con = dbconn.create();

         
            ps = con.prepareStatement(
                "SELECT * FROM studentvoute.nominatecandidate WHERE email=?"
            );
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                studentPhoto = rs.getBytes(6); 
            } else {
                response.sendRedirect("error.jsp?msg=Student not found");
                return;
            }

            rs.close();
            ps.close();

           
            ps = con.prepareStatement(
                "INSERT INTO studentvoute.eligible (rollno, department, email, image, symbol, status) VALUES (?,?,?,?,?,?)"
            );

            ps.setString(1, rollno);
            ps.setString(2, department);
            ps.setString(3, email);
            ps.setBytes(4, studentPhoto);
            ps.setBytes(5, symbolBytes); 
            ps.setString(6, "Eligible");

            int inserted = ps.executeUpdate();
            ps.close();

            if (inserted > 0) {

                
                ps = con.prepareStatement(
                    "UPDATE studentvoute.nominatecandidate SET status='Eligible' WHERE email=?"
                );
                ps.setString(1, email);
                ps.executeUpdate();
                ps.close();

                response.sendRedirect("Nominationview.jsp?msg=Student approved successfully");
            } else {
                response.sendRedirect("error.jsp?msg=Approval failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Server error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
