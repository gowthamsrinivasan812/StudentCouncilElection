package Servlet;

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


        byte[] imageBytes = null;

        try {
            Connection con = dbconn.create();
            PreparedStatement psImg = con.prepareStatement(
                    "SELECT student_id_photo FROM studentvoute.nominatecandidate WHERE email=?"
            );
            psImg.setString(1, cmail);

            ResultSet rsImg = psImg.executeQuery();

            if (rsImg.next()) {
                imageBytes = rsImg.getBytes("student_id_photo");
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

            ps.setBytes(1, imageBytes);
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
}
