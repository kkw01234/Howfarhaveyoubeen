package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.*;

public class LoginPageAction implements Action{//loginpage.do

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String result;
		
		result = "RequestDispatcher:jsp/main/loginpage.jsp";
			
		return result;
	}

}
