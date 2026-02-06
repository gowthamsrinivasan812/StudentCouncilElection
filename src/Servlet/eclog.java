package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/eclog")
public class eclog extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public eclog() {
        super();
       
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name=request.getParameter("name");
		System.out.println("Username "+name);
		
		String psw=request.getParameter("pass");
		System.out.println("password "+psw);
		
		if(name.equals("admin@gmail.com") && psw.equals("admin")) {
			
			response.sendRedirect("ecmain.jsp");
			
		}
					
	    else{
	    	
	    	response.sendRedirect("eclogin.jsp?error=user_not_found");
	    }


	}
	}


