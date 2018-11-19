package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.*;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.SHA256;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO;
import kr.co.howfarhaveyoubeen.www.handler.sendemail.RandomCode;
import kr.co.howfarhaveyoubeen.www.handler.sendemail.ResetSendEmailAction;
import kr.co.howfarhaveyoubeen.www.handler.vo.Userdbbean;

public class ChangePasswordPageAction implements Action{//changepasswordpage.do

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String result;
	
		result = "RequestDispatcher:jsp/main/changepassword.jsp";
		
		return result;
	}

}
