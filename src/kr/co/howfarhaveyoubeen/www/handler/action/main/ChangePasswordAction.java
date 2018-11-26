package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.io.PrintWriter;
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

public class ChangePasswordAction implements Action{//changepassword.do

	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter script = response.getWriter();
		UserDAO dao = new UserDAO();
		SHA256 sha = new SHA256();
		
		String result;
		String userID=null;
		String userEmail=null;
		String formalPassword=null;
		String changePassword=null;
		int checkPasswordResult = 0;
		boolean changePasswordResult = false;

		if(request.getParameter("userID") != null) {
			userID = (String) request.getParameter("userID");
		}
		if(request.getParameter("formalPassword") != null) {
			formalPassword = (String) request.getParameter("formalPassword");
		}
		if(request.getParameter("changePassword") != null) {
			changePassword = (String) request.getParameter("changePassword");
		}

		//아이디에 비밀번호가 맞는지 확인
		checkPasswordResult = dao.login(userID, sha.encryptSHA256(formalPassword));
		
		//아이디와 비밀번호가 일치 결과
		if(checkPasswordResult==1) {
			changePasswordResult = dao.resetPassword(userID, sha.encryptSHA256(changePassword));
			
			//비밀번호 변경 결과
			if(changePasswordResult) {
				System.out.println("비밀번호가 정상적으로 변경되었습니다.");
				script.println("<script>");
				script.println("alert('비밀번호가 정상적으로 변경되었습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return null;
			}else {
				System.out.println("비밀번호 변경에 오류가 생겼습니다.");
				result = "RequestDispatcher:jsp/main/changepassword.jsp";
			}
		}else if(checkPasswordResult==0){
			System.out.println("현재 비밀번호가 맞지 않습니다.");
			script.println("<script>");
			script.println("alert('현재 비밀번호가 맞지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}else{
			System.out.println("DB오류입니다.");
			script.println("<script>");
			script.println("alert('DB오류입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
			
		return result;
	}

}
