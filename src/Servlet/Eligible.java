/*package Servlet;

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

       String studentPhoto = "";

        try {
            con = dbconn.create();

         
            ps = con.prepareStatement(
                "SELECT * FROM studentvoute.nominatecandidate WHERE email=?"
            );
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                studentPhoto = rs.getString(6); 
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
            ps.setString(4, studentPhoto);
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
}*/


package Servlet;

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

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;

import dbcon.dbconn;

@WebServlet("/Eligible")
@MultipartConfig(maxFileSize = 16177215, maxRequestSize = 16177215 * 5)
public class Eligible extends HttpServlet {

    private static final long serialVersionUID = 1L;

    
    private static final String ACCESS_KEY = "AKIA4QF2TLLNZ4JWEZ66";
    private static final String SECRET_KEY = "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";
    private static final String BUCKET_NAME = "student-council-election-photos";
    private static final String REGION = "eu-north-1";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rollno = request.getParameter("rollno");
        String department = request.getParameter("department");
        String email = request.getParameter("email");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String studentImageUrl = null;
        String symbolUrl = null;

        try {
            con = dbconn.create();

           
            ps = con.prepareStatement(
                "SELECT student_id_photo_url FROM nominatecandidate WHERE email=?");
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                studentImageUrl = rs.getString("student_id_photo_url");
            } else {
                response.sendRedirect("error.jsp?msg=Student not found");
                return;
            }

            rs.close();
            ps.close();

            
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {

                AmazonS3 s3 = getS3Client();

                String fileName = "symbols/" + System.currentTimeMillis() + "_"
                        + getFileName(filePart);

                ObjectMetadata meta = new ObjectMetadata();
                meta.setContentLength(filePart.getSize());
                meta.setContentType(filePart.getContentType());

                InputStream fileStream = filePart.getInputStream();
                s3.putObject(BUCKET_NAME, fileName, fileStream, meta);

                symbolUrl = s3.getUrl(BUCKET_NAME, fileName).toString();
            }

           
            ps = con.prepareStatement(
                "INSERT INTO eligible (rollno, department, email, image_url, symbol_url, status) "
              + "VALUES (?,?,?,?,?,?)");

            ps.setString(1, rollno);
            ps.setString(2, department);
            ps.setString(3, email);
            ps.setString(4, studentImageUrl);
            ps.setString(5, symbolUrl);
            ps.setString(6, "Eligible");

            int inserted = ps.executeUpdate();
            ps.close();

            if (inserted > 0) {

               
                ps = con.prepareStatement(
                    "UPDATE nominatecandidate SET status='Eligible' WHERE email=?");
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

 
    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String value : header.split(";")) {
            if (value.trim().startsWith("filename")) {
                return value.substring(value.indexOf('=') + 2, value.length() - 1);
            }
        }
        return "file";
    }

 
    private AmazonS3 getS3Client() {
        BasicAWSCredentials creds =
                new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);

        return AmazonS3ClientBuilder.standard()
                .withRegion(REGION)
                .withCredentials(new AWSStaticCredentialsProvider(creds))
                .build();
    }
}

