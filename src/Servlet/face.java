

package Servlet;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.Base64;

import dbcon.dbconn;
import org.json.JSONObject;

@WebServlet("/face")
public class face extends HttpServlet {

    private static final long serialVersionUID = 1L;

    
    private String detectFaceToken(byte[] imageBytes) throws Exception {

        String apiKey = "ZvtwYjTMD4bUmTTR9lFrRcfCUNWQCySM";
        String apiSecret = "L_UnywqlpTNBlr0vSraVM98WyZlWezMC";

        String url = "https://api-us.faceplusplus.com/facepp/v3/detect";
        String boundary = "----DetectBoundaryFaceTokenXYZ";

        java.net.URL apiURL = new java.net.URL(url);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) apiURL.openConnection();

        conn.setDoOutput(true);
        conn.setUseCaches(false);
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
        out.writeBytes("Content-Disposition: form-data; name=\"image_file\"; filename=\"camera.jpg\"\r\n");
        out.writeBytes("Content-Type: application/octet-stream\r\n\r\n");
        out.write(imageBytes);
        out.writeBytes("\r\n");

        out.writeBytes("--" + boundary + "--\r\n");
        out.flush();
        out.close();

        
        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) sb.append(line);
        reader.close();

        JSONObject json = new JSONObject(sb.toString());

        if (json.has("faces") && json.getJSONArray("faces").length() > 0) {
            return json.getJSONArray("faces").getJSONObject(0).getString("face_token");
        }

        return null;
    }

   
    private double compareTokens(String storedToken, String detectedToken) throws Exception {

        String apiKey = "ZvtwYjTMD4bUmTTR9lFrRcfCUNWQCySM";
        String apiSecret = "L_UnywqlpTNBlr0vSraVM98WyZlWezMC";

        String url = "https://api-us.faceplusplus.com/facepp/v3/compare";

        java.net.URL apiURL = new java.net.URL(url);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) apiURL.openConnection();

        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String params =
                "api_key=" + apiKey +
                "&api_secret=" + apiSecret +
                "&face_token1=" + storedToken +
                "&face_token2=" + detectedToken;

        conn.getOutputStream().write(params.getBytes("UTF-8"));

       
        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) sb.append(line);
        reader.close();

        JSONObject json = new JSONObject(sb.toString());

        if (json.has("confidence")) {
            return json.getDouble("confidence");
        }

        return 0;
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            
            String email = request.getParameter("email");

            
            String base64Image = request.getParameter("capturedImage");

            if (base64Image == null || base64Image.length() < 100) {
                response.sendRedirect("faceauthentication.jsp?error=No image captured");
                return;
            }

            base64Image = base64Image.split(",")[1];
            byte[] cameraImageBytes = Base64.getDecoder().decode(base64Image);

           
            Connection con = dbconn.create();
            PreparedStatement ps = con.prepareStatement(
                "SELECT face_token FROM studentvoute.voteid WHERE studentmail = ?"
            );
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect("faceauthentication.jsp?error=User Not Found");
                return;
            }

            String storedToken = rs.getString("face_token");

            if (storedToken == null || storedToken.trim().equals("")) {
                response.sendRedirect("faceauthentication.jsp?error=No stored face token");
                return;
            }

           
            String detectedToken = detectFaceToken(cameraImageBytes);

            if (detectedToken == null) {
                response.sendRedirect("faceauthentication.jsp?error=Face not detected");
                return;
            }

            
            double confidence = compareTokens(storedToken, detectedToken);

            System.out.println("Face Match Confidence = " + confidence);

           
            double threshold = 75.0;

            if (confidence >= threshold) {
                response.sendRedirect("votehere.jsp?msg=Face Verified Successfully");
            } else {
                response.sendRedirect("faceauthentication.jsp?error=Face Mismatch. Score=" + confidence);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("faceauthentication.jsp?error=Error: " + ex.getMessage());
        }
    }
}
