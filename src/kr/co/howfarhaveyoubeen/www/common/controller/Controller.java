package kr.co.howfarhaveyoubeen.www.common.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Controller extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			String RequestURI=request.getRequestURI();
			String contextPath=request.getContextPath();
			String command=RequestURI.substring(contextPath.length());
			//System.out.println(command);
			Action action = null;
			String forward = null;

			ServletContext context = getServletContext();
			String fullPath = context.getRealPath("/WEB-INF/class.properties");
			Properties prop = new Properties();
			FileInputStream fis = new FileInputStream(fullPath);
			
			prop.load(fis);
			
			fis.close();
			
			String classPath = prop.getProperty(command);
			
			//System.out.println(command + " ------ " + fullPath);
			try{
				Class<?> url = Class.forName(classPath);
				
				action = (Action) url.newInstance();
				try {
					forward = action.execute(request, response);//실행..!!
				} catch (Exception e) {
					//세션 잃어버렸는데, 작업을 진행할때
				}
			}catch(ClassNotFoundException ex){
				ex.printStackTrace();
			}catch(InstantiationException ex){
				ex.printStackTrace();
			}catch(IllegalAccessException ex){
				ex.printStackTrace();
			}catch(NullPointerException ex)
			{
				//System.out.println("error class : " + command);
				ex.printStackTrace();
			}
			if(forward != null){
				
				if(forward.contains("RequestDispatcher:"))
				{
					String jspName = (forward.split(":")[1]);
					request.getRequestDispatcher("WEB-INF/" + forward.split(":")[1]).forward(request, response);
					//System.out.println("/" + jspName);
				}
				else {
					PrintWriter pr = response.getWriter();
					pr.print(forward);
					pr.flush();
					pr.close();
				}
			}
		} 	    
}
