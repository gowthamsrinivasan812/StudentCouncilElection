/*package Servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;

import javax.crypto.SecretKey;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dbcon.dbconn;

@WebServlet("/nomination")
@MultipartConfig(
        maxFileSize = 16177215,
        maxRequestSize = 16177215 * 10
)
public class nomination extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cmail = request.getParameter("email");
        String dept = request.getParameter("add");
        String assembly = request.getParameter("doc");
        String mobile = request.getParameter("number");
        String candidateName = request.getParameter("type");


        String imageBytes = null;

        try {
            Connection con = dbconn.create();
            PreparedStatement psImg = con.prepareStatement(
                    "SELECT student_id_photo_url FROM studentvoute.nominatecandidate WHERE email=?"
            );
            psImg.setString(1, cmail);

            ResultSet rsImg = psImg.executeQuery();

            if (rsImg.next()) {
                imageBytes = rsImg.getString("student_id_photo_url");
            } else {
                response.sendRedirect("error.jsp?msg=no_image_found");
                return;
            }

            rsImg.close();
            psImg.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=image_fetch_error");
            return;
        }


        Part filePart = request.getPart("file");
        byte[] pdfBytes = null;

        if (filePart != null && filePart.getSize() > 0) {
            pdfBytes = inputStreamToBytes(filePart.getInputStream());
        }


        String encryptedImage = "";
        String encryptedPdf = "";
        String encryptedAESKey = "";

        try {
            SecretKey aesKey = AESUtility.generateKey();

            encryptedImage = AESUtility.encryptBytes(imageBytes, aesKey);

            if (pdfBytes != null) {
                encryptedPdf = AESUtility.encryptBytes(pdfBytes, aesKey);
            }

            RSAUtility rsa = new RSAUtility();
            byte[] rsaEncryptedKey = rsa.encrypt(aesKey.getEncoded());

            encryptedAESKey = java.util.Base64.getEncoder().encodeToString(rsaEncryptedKey);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=encryption_failed");
            return;
        }


        try {
            Connection con = dbconn.create();

            String sql = "INSERT INTO studentvoute.applicatin VALUES (?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, imageBytes);
            ps.setString(2, cmail);
            ps.setString(3, dept);
            ps.setString(4, mobile);
            ps.setString(5, candidateName);
            ps.setBytes(6, pdfBytes);

            ps.setString(7, encryptedImage);
            ps.setString(8, encryptedPdf);
            ps.setString(9, encryptedAESKey);
            ps.setString(10, "Upload");

            int res = ps.executeUpdate();

            if (res == 1) {

           
                Statement st = con.createStatement();
                st.executeUpdate("UPDATE studentvoute.nominatecandidate SET status='confirm' WHERE email='" + cmail + "'");

                response.sendRedirect("candidatemain.jsp");
            } else {
                response.sendRedirect("error.jsp?msg=db_insert_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=sql_exception");
        }
    }


    private byte[] inputStreamToBytes(InputStream input) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        byte[] temp = new byte[4096];
        int bytesRead;

        while ((bytesRead = input.read(temp)) != -1) {
            buffer.write(temp, 0, bytesRead);
        }
        return buffer.toByteArray();
    }
}*/


package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;

import javax.crypto.SecretKey;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;

import dbcon.dbconn;

@WebServlet("/nomination")
@MultipartConfig(maxFileSize = 16177215, maxRequestSize = 16177215 * 10)
public class nomination extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // 🔹 AWS S3 DETAILS
    private static final String BUCKET_NAME = "student-council-election-photos";
    private static final String REGION = "eu-north-1";

    private static final String ACCESS_KEY = "AKIA4QF2TLLNZ4JWEZ66";
    private static final String SECRET_KEY = "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";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cmail = request.getParameter("email");
        String dept = request.getParameter("add");
        String mobile = request.getParameter("number");
        String candidateName = request.getParameter("type");

        String imageUrl = null;

        // 🔹 Fetch candidate image URL
        try (Connection con = dbconn.create()) {

            PreparedStatement ps = con.prepareStatement(
                    "SELECT student_id_photo_url FROM nominatecandidate WHERE email=?");
            ps.setString(1, cmail);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                imageUrl = rs.getString("student_id_photo_url");
            } else {
                response.sendRedirect("error.jsp?msg=no_image_found");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=image_fetch_error");
            return;
        }

        // 📄 Upload PDF to AWS S3
        Part filePart = request.getPart("file");
        String pdfUrl = null;

        if (filePart != null && filePart.getSize() > 0) {

            try {
                AmazonS3 s3 = getS3Client();

                String fileName = "pdfs/" + System.currentTimeMillis() + "_"
                        + getFileName(filePart);

                ObjectMetadata metadata = new ObjectMetadata();
                metadata.setContentLength(filePart.getSize());
                metadata.setContentType("application/pdf");

                InputStream fileStream = filePart.getInputStream();

                s3.putObject(BUCKET_NAME, fileName, fileStream, metadata);

                pdfUrl = s3.getUrl(BUCKET_NAME, fileName).toString();

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp?msg=s3_upload_failed");
                return;
            }
        }

        // 🔐 Encryption logic
        String encryptedImage;
        String encryptedPdfUrl;
        String encryptedAESKey;

        try {
            SecretKey aesKey = AESUtility.generateKey();

            encryptedImage = AESUtility.encrypt(imageUrl, aesKey);
            encryptedPdfUrl = AESUtility.encrypt(pdfUrl, aesKey);

            RSAUtility rsa = new RSAUtility();
            byte[] rsaKey = rsa.encrypt(aesKey.getEncoded());
            encryptedAESKey = java.util.Base64.getEncoder().encodeToString(rsaKey);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=encryption_failed");
            return;
        }

        // 💾 Insert into AWS RDS
        try (Connection con = dbconn.create()) {

            String sql = "INSERT INTO applicatin "
                    + "(canimg_url, cemail, dept, cont, cname, doc_url, "
                    + "imgenc, pdfenc, aes, status) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?)";

            
          

            
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, imageUrl);
            ps.setString(2, cmail);
            ps.setString(3, dept);
            ps.setString(4, mobile);
            ps.setString(5, candidateName);
            ps.setString(6, pdfUrl);
            ps.setString(7, encryptedImage);
            ps.setString(8, encryptedPdfUrl);
            ps.setString(9, encryptedAESKey);
            ps.setString(10, "Upload");

            int res = ps.executeUpdate();

            if (res == 1) {
                Statement st = con.createStatement();
                st.executeUpdate(
                        "UPDATE nominatecandidate SET status='confirm' WHERE email='" + cmail + "'");
                request.setAttribute("successMessage", "Nomination filed successfully!");
                request.getRequestDispatcher("candidateapp.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp?msg=db_insert_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=sql_exception");
        }
    }

    // 🔹 Extract filename (Servlet 3.0 compatible)
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "file.pdf";
    }

    // 🔹 AWS S3 Client
    private AmazonS3 getS3Client() {
        BasicAWSCredentials creds =
                new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);

        return AmazonS3ClientBuilder.standard()
                .withRegion(REGION)
                .withCredentials(new AWSStaticCredentialsProvider(creds))
                .build();
    }
}
