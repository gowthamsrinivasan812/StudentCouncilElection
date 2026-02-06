package Servlet;

import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import cli.System.Net.WebRequestMethods.Http;
import dbcon.dbconn;

/**
 * Servlet implementation class updateEdate
 */
@WebServlet("/updateEdate")
public class updateEdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateEdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String electionName = request.getParameter("election_name");
        String electionDate = request.getParameter("election_date");

        // Validation
        if (electionName == null || electionDate == null ||
            electionName.trim().isEmpty() || electionDate.trim().isEmpty()) {

            response.sendRedirect("createElection.jsp?msg=invalid");
            return;
        }

        java.sql.Connection con = null;
        PreparedStatement ps = null;

        try {
            con = dbconn.create();

            String sql = "INSERT INTO studentvote.election_date (ElectionDate, winner, Electionname) VALUES (?, ?, ?)";
            ps = con.prepareStatement(sql);

            ps.setString(1, electionDate);
            ps.setString(2, "Pending");
            ps.setString(3, electionName);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("createElection.jsp?msg=success");
                HttpSession session=request.getSession();
                session.setAttribute("Edate", electionDate);
            } else {
                response.sendRedirect("createElection.jsp?msg=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("createElection.jsp?msg=error");

        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
