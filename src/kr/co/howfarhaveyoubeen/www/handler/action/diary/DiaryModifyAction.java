package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;

public class DiaryModifyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
		String id = (String) session.getAttribute("userID");
		String diaryid = (String) request.getParameter("diaryID");
		System.out.println(diaryid);
		DiaryDAO dao = DiaryDAO.getInstance();
		request.setAttribute("diaryread", dao.getDiary(diaryid));
		request.setAttribute("coordinates",dao.getDiaryCoordinates(diaryid));
		request.setAttribute("diaryid", diaryid);
		return "RequestDispatcher:jsp/diary/modifydiary.jsp";
	}
	
}
