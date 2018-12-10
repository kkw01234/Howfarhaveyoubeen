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
		response.setCharacterEncoding("UTF-8");
		PrintWriter script = response.getWriter();
		Userdbbean user = new Userdbbean();
		UserDAO dao = new UserDAO();
		RandomCode code = new RandomCode();
		SHA256 sha = new SHA256();
		PasswordCheck pwcheck = new PasswordCheck();
		
		String result=null;
		String userID=null;
		String userPassword = null;
		String userPasswordCheck = null;
		String userName=null;
		String userEmail=null;
		String randomCode=null;
		String pwCheckResult = null;
		boolean userEmailCheck=false;
		
		if(request.getParameter("userID") != null) {
			userID = (String) request.getParameter("userID");
			user.setUserID(userID);
		}
		if(request.getParameter("userPassword") != null) {
			userPassword = (String) request.getParameter("userPassword");
		}
		if(request.getParameter("userPasswordCheck") != null) {
			userPasswordCheck = (String) request.getParameter("userPasswordCheck");
		}
		if(request.getParameter("userName") != null) {
			userName = (String) request.getParameter("userName");
			user.setUserName(userName);
		}
		if(request.getParameter("userEmail") != null) {
			userEmail = (String) request.getParameter("userEmail");
			user.setUserEmail(userEmail);
		}
		
		//비밀번호 확인
		if(!userPassword.equals(userPasswordCheck)) {
			System.out.println("비밀번호를 정확히 다시 입력해주세요");
			script.println("<script>");
			script.println("alert('비밀번호를 정확히 다시 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
		
		//비밀번호 정책 확인
		if(!pwcheck.passwordValidator(userPassword)) {
			System.out.println("취약한 비밀번호입니다. 알파벳,숫자,특수문자를 조합하여 8글자 이상으로 다시 설정해주세요");
			script.println("<script>");
			script.println("alert('취약한 비밀번호입니다. 알파벳,숫자,특수문자를 조합하여 8글자 이상으로 다시 설정해주세요')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
		
		//비밀번호 암호화
		userPassword = sha.encryptSHA256(userPassword);
		user.setPassword(userPassword);
		
		//랜덤 코드 생성
		randomCode = code.Code();
		user.setEmailCode(randomCode);
		
		//이메일이 이미 등록되어 있는 경우
		if(dao.usedEmailCheck(userEmail)) {
			System.out.println("이미 등록되어있는 이메일입니다.");
			script.println("<script>");
			script.println("alert('이미 등록되어있는 이메일입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
		
		
		
		
		if( dao.join(user)) { // 회원가입 성공시 이메일 전송 페이지 이동
			System.out.println("가입성공");
			SendEmailAction send = new SendEmailAction();
			int email_result = send.SendEmail(userID, randomCode, request); //이메일 전송
			if(email_result==1) {
				System.out.println("이메일 전송 완료");
			}else if(email_result==0) {
				System.out.println("이메일 전송에 실패했습니다.");
				dao.deleteUser(user); //오류났을때 삭제 코드 (추가)
				script.println("<script>");
				script.println("alert('이메일 전송에 실패했습니다. 다시 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
				return null;
			}else {
				System.out.println("오류가 발생했습니다.");
				dao.deleteUser(user);  //오류 났을 때 삭제 코드 (추가)
				script.println("<script>");
				script.println("alert('오류가 발생했습니다. 다시 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
				return null;
			}
			result = "RequestDispatcher:jsp/main/loginpage.jsp";

		}else {
			System.out.println("존재하는 아이디입니다.");
			script.println("<script>");
			script.println("alert('존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
		
		return result;
	}

}
