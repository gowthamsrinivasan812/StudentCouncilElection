/*

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

        String apiKey = "9_QtANJEy3_sK1PYrHZfNsykf12RMSn8";
        String apiSecret = "PTDoJ9R2ytODF_ZGjHF21WHavpkW9e3x";

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

        String apiKey = "9_QtANJEy3_sK1PYrHZfNsykf12RMSn8";
        String apiSecret = "PTDoJ9R2ytODF_ZGjHF21WHavpkW9e3x";

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

*/
package Servlet;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

import dbcon.dbconn;

@WebServlet("/face")
public class face extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // 🔐 SAME Face++ credentials as voterapply
    private static final String FACE_API_KEY = "FkCyNm-q3lPSnnrq9CCoFe2UrlflUM_M";
    private static final String FACE_API_SECRET = "YsLwkRoAioXBXqrY5l81PWzEK2zT1u5L";

    // ✅ SAME REGION (US)
    private static final String DETECT_URL =
            "https://api-us.faceplusplus.com/facepp/v3/detect";
    private static final String COMPARE_URL =
            "https://api-us.faceplusplus.com/facepp/v3/compare";

    // =====================================================
    // FACE DETECT
    // =====================================================
    private String detectFaceToken(byte[] imageBytes) throws Exception {

        String boundary = "----FaceBoundaryXYZ";
        URL url = new URL(DETECT_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty(
                "Content-Type", "multipart/form-data; boundary=" + boundary
        );

        DataOutputStream out = new DataOutputStream(conn.getOutputStream());

        out.writeBytes("--" + boundary + "\r\n");
        out.writeBytes("Content-Disposition: form-data; name=\"api_key\"\r\n\r\n");
        out.writeBytes(FACE_API_KEY + "\r\n");

        out.writeBytes("--" + boundary + "\r\n");
        out.writeBytes("Content-Disposition: form-data; name=\"api_secret\"\r\n\r\n");
        out.writeBytes(FACE_API_SECRET + "\r\n");

        out.writeBytes("--" + boundary + "\r\n");
        out.writeBytes(
                "Content-Disposition: form-data; name=\"image_file\"; filename=\"photo.jpg\"\r\n"
        );
        out.writeBytes("Content-Type: application/octet-stream\r\n\r\n");
        out.write(imageBytes);
        out.writeBytes("\r\n--" + boundary + "--\r\n");

        out.flush();
        out.close();

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();

        JSONObject json = new JSONObject(sb.toString());
        JSONArray faces = json.optJSONArray("faces");

        if (faces != null && faces.length() > 0) {
            return faces.getJSONObject(0).getString("face_token");
        }
        return null;
    }

    // =====================================================
    // FACE COMPARE
    // =====================================================
    private synchronized double compareTokens(String token1, String token2)
            throws Exception {

        Thread.sleep(1200); // avoid rate-limit

        URL url = new URL(COMPARE_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty(
                "Content-Type", "application/x-www-form-urlencoded"
        );

        String params =
                "api_key=" + FACE_API_KEY +
                "&api_secret=" + FACE_API_SECRET +
                "&face_token1=" + URLEncoder.encode(token1, "UTF-8") +
                "&face_token2=" + URLEncoder.encode(token2, "UTF-8");

        conn.getOutputStream().write(params.getBytes("UTF-8"));

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);
        br.close();

        JSONObject json = new JSONObject(sb.toString());
        return json.optDouble("confidence", 0.0);
    }

    // =====================================================
    // POST
    // =====================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String email = request.getParameter("email");
            String base64Image = request.getParameter("capturedImage");

            if (base64Image == null || base64Image.length() < 100) {
                response.sendRedirect("faceauthentication.jsp?error=No image");
                return;
            }

            base64Image = base64Image.split(",")[1];
            byte[] cameraBytes = Base64.getDecoder().decode(base64Image);

            Connection con = dbconn.create();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT face_token FROM studentvoute.voteid WHERE studentmail=?"
            );
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                response.sendRedirect("faceauthentication.jsp?error=User not found");
                return;
            }

            String storedToken = rs.getString("face_token");
            rs.close();
            ps.close();
            con.close();

            String detectedToken = detectFaceToken(cameraBytes);
            if (detectedToken == null) {
                response.sendRedirect("faceauthentication.jsp?error=Face not detected");
                return;
            }

            double confidence = compareTokens(storedToken, detectedToken);

            if (confidence >= 75) {
                response.sendRedirect("votehere.jsp?msg=Face verified");
            } else {
                response.sendRedirect(
                        "faceauthentication.jsp?error=Face mismatch (" + confidence + ")"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(
                    "faceauthentication.jsp?error=Verification failed"
            );
        }
    }
}
