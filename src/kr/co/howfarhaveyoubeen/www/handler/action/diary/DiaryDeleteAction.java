package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;

public class DiaryDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter script = response.getWriter();
		DiaryDAO dao = DiaryDAO.getInstance();
		
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/404.jsp";
		}
		
		String result = null;
		String id = (String) session.getAttribute("userID");
		String diaryid = (String) request.getParameter("diaryID");
		System.out.println(diaryid + "번 다이어리가 삭제됩니다.");
		
		result = dao.deleteDiary(diaryid); //다이어리 DB에서 삭제
		
		//삭제 성공시 다이어리 리스트 페이지로 이동 실패시 back
		if(result.equals("Success")) {
			request.setAttribute("diarylist", dao.getUserDiary(id));
			return "RequestDispatcher:jsp/diary/diarylist.jsp";
		}else {
			script.println("<script>");
			script.println("alert('다이어리 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
			
	}
	
}
