package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO;

public class WithdrawalAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("userID")== null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
		UserDAO dao = UserDAO.getInstance();
		String userID = (String)session.getAttribute("userID");
		dao.withdraw(userID);
		PrintWriter script = response.getWriter();
		script.println("<script> alert(\"회원탈퇴가 완료되었습니다.\")</script>");
		session.invalidate();
		response.sendRedirect("Index");
		
		return null;
	}

}
