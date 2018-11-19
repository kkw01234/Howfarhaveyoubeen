package kr.co.howfarhaveyoubeen.www.handler.sendemail;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.*;

public class CodeCheckPage implements Action{//emailCheckAction.do

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String result = null;
	
		result = "RequestDispatcher:jsp/main/emailCheckAction.jsp";
		
		return result;
	}

}
