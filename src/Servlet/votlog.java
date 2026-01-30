package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbcon.dbconn;



@WebServlet("/votlog")
public class votlog extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public votlog() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String assem = request.getParameter("assem");
        String district = request.getParameter("pass");

        HttpSession session = request.getSession();
        session.setAttribute("uname", email);
        session.setAttribute("ass", assem);
        session.setAttribute("dis", district);

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
        	con=dbconn.create();
            ps = con.prepareStatement("SELECT * FROM `vote`.`voterreg` WHERE email=? AND assem=? AND district=?");
            ps.setString(1, email);
            ps.setString(2, assem);
            ps.setString(3, district);

            rs = ps.executeQuery();

            if (rs.next()) {
                String mobile = rs.getString(3);
                session.setAttribute("mobile", mobile);
                response.sendRedirect("votermain.jsp");
            } else {
                response.sendRedirect("voterlogin.jsp?error=user_not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("voterlogin.jsp?error=database_error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
