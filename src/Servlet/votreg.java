package Servlet;

import imple.imple;
import inter.inter;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Bean.voterbean;


@WebServlet("/votreg")
public class votreg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public votreg() {
        super();
       
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String name = request.getParameter("name");
	    String email = request.getParameter("email");  
	    String mobile = request.getParameter("mobile");
	    String pass = request.getParameter("psw");
	    String cpass = request.getParameter("pswrepeat");
	    String dis = request.getParameter("district");
	    String ass = request.getParameter("assem");

	    voterbean v = new voterbean();
	    v.setName(name);
	    v.setEmail(email);
	    v.setMobile(mobile);
	    v.setPass(pass);
	    v.setCpass(cpass);
	    v.setDistrict(dis);
	    v.setAssem(ass);

	    inter n = new imple();

	    
	    if (((imple) n).checkEmailExists(email)) { 
	        response.sendRedirect("register.jsp?error=email_exists"); 
	    } else {
	        int b = n.vreg(v);
	        if (b == 1) {
	            response.sendRedirect("main.jsp");
	        } else {
	            response.sendRedirect("Error.jsp");
	        }
	    }
	}
}

