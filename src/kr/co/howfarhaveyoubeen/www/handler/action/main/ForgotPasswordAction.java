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

public class ForgotPasswordAction implements Action{//forgotpassword.do

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		UserDAO dao = new UserDAO();
		RandomCode code = new RandomCode();
		SHA256 sha = new SHA256();
		ResetSendEmailAction resetSend = new ResetSendEmailAction();
		
		String result;
		String userID=null;
		String userEmail=null;
		String resetPassword=null;
		String encryPassword=null;
		boolean sendResult = false;
		boolean changePasswordResult = false;

		if(request.getParameter("userEmail") != null) {
			userEmail = (String) request.getParameter("userEmail");
		}

		//초기 비밀번호 생성
		resetPassword = code.Code();
		
		//이메일로 ID찾기
		userID = dao.getUserIDToEmail(userEmail); 
		System.out.println(userEmail+ userID);
		
		if(userID == null) {
			System.out.println("존재하지 않는 이메일입니다.");
			result = "RequestDispatcher:jsp/main/forgot-password.jsp";
		}else {
			//초기화 비밀번호로 변경
			encryPassword = sha.encryptSHA256(resetPassword);
			changePasswordResult = dao.resetPassword(userID, encryPassword); //비밀번호 초기화
			sendResult = resetSend.resetSendEmail(userID, resetPassword, userEmail,request); //초기화 계정 메일 전송
			
			if(sendResult==true && changePasswordResult==true) {
				System.out.println("초기화 메일이 성공적으로 보내졌습니다.");
				result = "RequestDispatcher:jsp/main/loginpage.jsp";
			}else {
				System.out.println("메일 전송에 오류가 있습니다.");
				result = "RequestDispatcher:jsp/main/forgot-password.jsp";
			}
			
		}
		
		
		return result;
	}

}
