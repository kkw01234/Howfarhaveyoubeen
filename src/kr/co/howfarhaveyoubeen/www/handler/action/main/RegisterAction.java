package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.*;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.*;
import kr.co.howfarhaveyoubeen.www.handler.sendemail.RandomCode;
import kr.co.howfarhaveyoubeen.www.handler.sendemail.SendEmailAction;
import kr.co.howfarhaveyoubeen.www.handler.vo.Userdbbean;

public class RegisterAction implements Action{//register.do

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		Userdbbean user = new Userdbbean();
		UserDAO dao = new UserDAO();
		RandomCode code = new RandomCode();
		SHA256 sha = new SHA256();
		
		String result=null;
		String userID=null;
		String userPassword = null;
		String userName=null;
		String userEmail=null;
		String randomCode=null;
		boolean userEmailCheck=false;
		
		if(request.getParameter("userID") != null) {
			userID = (String) request.getParameter("userID");
			user.setUserID(userID);
		}
		if(request.getParameter("userPassword") != null) {
			userPassword = (String) request.getParameter("userPassword");
			userPassword = sha.encryptSHA256(userPassword);
			user.setPassword(userPassword);
		}
		if(request.getParameter("userName") != null) {
			userName = (String) request.getParameter("userName");
			user.setUserName(userName);
		}
		if(request.getParameter("userEmail") != null) {
			userEmail = (String) request.getParameter("userEmail");
			user.setUserEmail(userEmail);
		}
		
		//랜덤 코드 생성
		randomCode = code.Code();
		user.setEmailCode(randomCode);
		
		//이메일이 이미 등록되어 있는 경우
		if(dao.usedEmailCheck(userEmail)) {
			System.out.println("이미 등록되어있는 이메일입니다.");
			result = "RequestDispatcher:jsp/main/register.jsp";
			return result;
		}
		
		
		int db_result = dao.join(user); //DB에 가입정보 추가 
		System.out.println(userID + userPassword + userName + userEmail + randomCode);
		
		
		
		if(db_result == 1) { // 회원가입 성공시 이메일 전송 페이지 이동
			System.out.println("가입성공");
			SendEmailAction send = new SendEmailAction();
			int email_result = send.SendEmail(userID, randomCode, request); //이메일 전송
			if(email_result==1) {
				System.out.println("이메일 전송 완료");
			}else if(email_result==0) {
				System.out.println("이미 인증된 회원입니다.");
			}else
				System.out.println("오류가 발생했습니다.");
			
			result = "RequestDispatcher:jsp/main/loginpage.jsp";

		}else {
			result = "RequestDispatcher:jsp/main/register.jsp";
			System.out.println("가입실패");
		}
		
		return result;
	}

}
