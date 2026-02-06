package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import dbcon.dbconn;

@WebServlet("/candidateapply")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class candidateapply extends HttpServlet {

    private static final long serialVersionUID = 1L;

   
    private static final String ACCESS_KEY = "AKIA4QF2TLLNZ4JWEZ66";
    private static final String SECRET_KEY = "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";
    private static final String BUCKET_NAME = "student-council-election-photos";
    private static final String REGION = "eu-north-1";

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
        InputStream fileInputStream = filePart.getInputStream();

        String fileName = UUID.randomUUID() + "_" + getFileName(filePart);

        try {
          
            BasicAWSCredentials creds =
                    new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);

            AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                    .withRegion(REGION)
                    .withCredentials(new AWSStaticCredentialsProvider(creds))
                    .build();

           
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(filePart.getSize());
            metadata.setContentType(filePart.getContentType());

            
            PutObjectRequest putReq = new PutObjectRequest(
                    BUCKET_NAME,
                    "candidate-id/" + fileName,
                    fileInputStream,
                    metadata
            );

            s3Client.putObject(putReq);

           
            String fileUrl = s3Client
                    .getUrl(BUCKET_NAME, "candidate-id/" + fileName)
                    .toString();

            
            try (java.sql.Connection con = dbconn.create()) {

                String sql = "INSERT INTO nominatecandidate "
                        + "(class_department, roll_number, email, mobile, student_id_photo_url, status) "
                        + "VALUES (?, ?, ?, ?, ?, ?)";

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, classDept);
                ps.setString(2, roll);
                ps.setString(3, email);
                ps.setString(4, mobile);
                ps.setString(5, fileUrl);
                ps.setString(6, "Pending");

                ps.executeUpdate();
                ps.close();

                request.setAttribute("successMessage", "Application submitted successfully!");
                request.getRequestDispatcher("candiateapply.jsp").forward(request, response);
;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Upload failed: " + e.getMessage());
            request.getRequestDispatcher("candiateapply.jsp").forward(request, response);
        }
    }

   
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1)
                        .trim()
                        .replace("\"", "");
            }
        }
        return "file";
    }
}
