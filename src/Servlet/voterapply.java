package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dbcon.dbconn;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/voterapply")
@MultipartConfig(
        maxFileSize = 16177215,
        maxRequestSize = 16177215 * 10
)
public class voterapply extends HttpServlet {
    private static final long serialVersionUID = 1L;

   

    private String detectFaceToken(byte[] imageBytes) throws Exception {

        String apiKey = "ZvtwYjTMD4bUmTTR9lFrRcfCUNWQCySM";
        String apiSecret = "L_UnywqlpTNBlr0vSraVM98WyZlWezMC";

        String boundary = "----FacePlusBoundary123";
        URL url = new URL("https://api-us.faceplusplus.com/facepp/v3/detect");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

        DataOutputStream out = new DataOutputStream(conn.getOutputStream());

        out.writeBytes("--" + boundary + "\r\n");
        out.writeBytes("Content-Disposition: form-data; name=\"api_key\"\r\n\r\n");
        out.writeBytes(apiKey + "\r\n");

        out.writeBytes("--" + boundary + "\r\n");
        out.writeBytes("Content-Disposition: form-data; name=\"api_secret\"\r\n\r\n");
        out.writeBytes(apiSecret + "\r\n");

        out.writeBytes("--" + boundary + "\r\n");
        out.writeBytes("Content-Disposition: form-data; name=\"image_file\"; filename=\"photo.jpg\"\r\n");
        out.writeBytes("Content-Type: application/octet-stream\r\n\r\n");
        out.write(imageBytes);
        out.writeBytes("\r\n--" + boundary + "--\r\n");

        out.flush();
        out.close();

        InputStream is = (conn.getResponseCode() >= 400)
                ? conn.getErrorStream()
                : conn.getInputStream();

        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();

        JSONObject json = new JSONObject(sb.toString());
        JSONArray faces = json.optJSONArray("faces");

        if (faces != null && faces.length() > 0) {
            return faces.getJSONObject(0).getString("face_token");
        }
        return null; 
    }

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
       

        Part filePart = request.getPart("file");
        byte[] fileBytes = null;

        if (filePart != null && filePart.getSize() > 0) {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            InputStream is = filePart.getInputStream();
            byte[] buf = new byte[4096];
            int r;
            while ((r = is.read(buf)) != -1) {
                bos.write(buf, 0, r);
            }
            fileBytes = bos.toByteArray();
        }

        
        if (fileBytes == null) {
            response.sendRedirect("voterform.jsp?error=Please upload a photo");
            return;
        }

        String faceToken;

        try {
            faceToken = detectFaceToken(fileBytes);

           
            if (faceToken == null || faceToken.isEmpty()) {
                response.sendRedirect("voterform.jsp?error=Face not detected. Upload a clear face photo.");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("voterform.jsp?error=Face detection failed");
            return;
        }

       
        try (Connection con = dbconn.create()) {

            String sql =
                "INSERT INTO studentvoute.voteid " +
                "(studentname, studentmail, studentcourse, pic, status, votekey, Edate, face_token) " +
                "VALUES (?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, course);
           
            ps.setBytes(4, fileBytes);
            ps.setString(5, "Apply");
            ps.setString(6, "");
            ps.setString(7, "");
            ps.setString(8, faceToken); 

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("votermain.jsp?msg=Registration successful");
            } else {
                response.sendRedirect("voterform.jsp?error=Application failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("voterform.jsp?error=Database error");
        }
    }
}
