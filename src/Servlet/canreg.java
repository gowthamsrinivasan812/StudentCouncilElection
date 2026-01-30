package Servlet;

import imple.imple;
import inter.inter;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.candidatebean;


@WebServlet("/canreg")
public class canreg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public canreg() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String name = request.getParameter("name");
	    String email = request.getParameter("email");
	    String mobile = request.getParameter("mobile");

	    candidatebean v = new candidatebean();
	    v.setName(name);
	    v.setEmail(email);
	    v.setMobile(mobile);

	    inter n = new imple();
	    int b = n.creg(v);

	    if (b == 1) {
	        response.sendRedirect("candidatelog.jsp"); 
	    } else {
	        request.setAttribute("errorMessage", "E-mail Already Registerd. Please Use Different Email.");
	        request.getRequestDispatcher("cadidatereg.jsp").forward(request, response); 
	    }
	}

	}


