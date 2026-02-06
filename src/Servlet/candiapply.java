package Servlet;


import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.io.InputStream;

import java.sql.Connection;
import java.sql.PreparedStatement;


import javax.crypto.SecretKey;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbcon.dbconn;

import javax.servlet.http.Part;

@WebServlet("/candiapply")
@MultipartConfig(
        maxFileSize = 16177215, 
        maxRequestSize = 16177215 * 10
)
public class candiapply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public candiapply() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String District = request.getParameter("District");
        String Assembly = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");

        Part filePart = request.getPart("file");
        String fileName = null;
        InputStream fileContent = null;
        long fileSize = 0;

        if (filePart != null) {
            fileName = getFileName(filePart);
            fileContent = filePart.getInputStream();
            fileSize = filePart.getSize();
        }

        String status = "request";

     
        byte[] fileBytes = null;

        if (fileContent != null && fileSize > 0) {
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            byte[] temp = new byte[4096];
            int bytesRead;

            while ((bytesRead = fileContent.read(temp)) != -1) {
                buffer.write(temp, 0, bytesRead);
            }
            fileBytes = buffer.toByteArray();
        }

     
        SecretKey aesKey = null;
        String encryptedFileBase64 = "";
        String encryptedAESKeyBase64 = "";

        try {
            if (fileBytes != null) {
                aesKey = AESUtility.generateKey();

             
                encryptedFileBase64 = AESUtility.encryptBytes(fileBytes, aesKey);

               
                RSAUtility rsa = new RSAUtility();

                byte[] rsaEncryptedAESKey = rsa.encrypt(aesKey.getEncoded());
                encryptedAESKeyBase64 = java.util.Base64.getEncoder().encodeToString(rsaEncryptedAESKey);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("candiateapply.jsp?error=Encryption failed: " + e.getMessage());
            return;
        }

        try {
            Connection con = dbconn.create();

           
            String sql = "INSERT INTO `vote`.`candidateid` VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, District);
            ps.setString(2, Assembly);
            ps.setString(3, email);
            ps.setString(4, mobile);

            
            if (fileBytes != null) {
                ps.setBytes(5, fileBytes);
            } else {
                ps.setNull(5, java.sql.Types.BLOB);
            }

            ps.setString(6, "Apply");
         

           
            ps.setBytes(7, encryptedFileBase64.getBytes());

            
            ps.setString(8, encryptedAESKeyBase64);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("candidatemain.jsp?msg=Registration successful, waiting for approval");
            } else {
                response.sendRedirect("candiateapply.jsp?error=Already Candidate Applied For His Approval. Please Wait For Approvl.");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("canreg.jsp?error=Server error: " + e.getMessage());
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
		
		
		
		
		
}
