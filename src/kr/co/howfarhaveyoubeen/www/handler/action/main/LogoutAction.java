package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.*;

public class LogoutAction implements Action{//logout.do

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("userID")== null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
		session.invalidate();
		response.sendRedirect("Index");
		
		return null;


	}
}
