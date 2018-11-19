<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userID");
	String code = request.getParameter("code");
	UserDAO dao = new UserDAO();

	boolean emailCheckResult = dao.checkCode(userID, code);
	
	
	if(emailCheckResult == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 코드입니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		
	}else{
		dao.setUserEmailChecked(userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		
		
	}
%>