package kr.co.howfarhaveyoubeen.www.common.index;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Index")//index.jsp
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Index() {
        super();
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    	throws ServletException, IOException{
    	try {
    		request.setAttribute("index","index"); //추가파트
    		request.getRequestDispatcher("WEB-INF/jsp/main/index.jsp").forward(request, response);
    	} catch(Exception ex) {
    		throw new ServletException(ex.getMessage(), ex);
    	}
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
}
