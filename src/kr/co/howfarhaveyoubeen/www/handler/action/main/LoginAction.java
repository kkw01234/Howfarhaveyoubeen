package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.*;
import kr.co.howfarhaveyoubeen.www.handler.dao.googlevision.GoogleVisionDAO;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.SHA256;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.Userdbbean;

public class LoginAction implements Action{//login.do


   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
	    HttpSession session = request.getSession();
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html; charset=UTF-8");
	    PrintWriter script = response.getWriter();
	    
		UserDAO dao = new UserDAO();
		SHA256 sha = new SHA256();
		String userID = null;
		String userPassword = null;
		String result = null;
		boolean emailCheck=false;
		
		if(request.getParameter("userID") != null) {
			userID = (String) request.getParameter("userID");
		}
		if(request.getParameter("userPassword") != null) {
			userPassword = (String) request.getParameter("userPassword");
			userPassword = sha.encryptSHA256(userPassword); // 비밀번호 암호화
		}
		
		int db_result = dao.login(userID, userPassword); //DB에 로그인 검사
		emailCheck = dao.getUserEmailChecked(userID);
		
		if(db_result == 1) {
			if(emailCheck) {
				result = "RequestDispatcher:jsp/main/index.jsp"; //로그인 성공 후 메인페이지 이동
				session.setAttribute("userID", userID); //세션 생성
				session.setMaxInactiveInterval(15*60); //세션 유효기간 10분
				System.out.println("로그인 성공");
				/*
				script.println("<script>");
				script.println("alert('로그인 되었습니다.')");
				script.println("</script>");
				script.println("location.href = 'Index' ");
				script.flush();
				return null;
				*/
			}else {
				result = "RequestDispatcher:jsp/main/loginpage.jsp";
				System.out.println("이메일 인증을 해주세요");
			}
				
		}else if(db_result == 0) {
			result = "RequestDispatcher:jsp/main/loginpage.jsp"; //비밀번호 오류로 로그인페이지 이동
			System.out.println("비밀번호가 잘못되었습니다.");
			/*
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
			*/
		}else if(db_result == -1){
			result = "RequestDispatcher:jsp/main/loginpage.jsp";//존재하지 않는 아이디
			System.out.println("아이디가 존재하지 않습니다.");
			/*
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
			*/
		}else {
			System.out.println("데이터 베이스 오류입니다."); // DB오류
			/*
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			*/
		}
		//script.flush();
		return result;
	}

}