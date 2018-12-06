package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;

public class DiaryListMapAction implements Action{//Map에 다이어리 읽을수 있게

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id= (String) session.getAttribute("userID");
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
	
		DiaryDAO dao = DiaryDAO.getInstance();
		
		request.setAttribute("Allcoordinates", dao.getUserCoordinates(id));
		request.setAttribute("diarylist",dao.getUserDiary(id));
		return "RequestDispatcher:jsp/diary/diarylistmap.jsp";
	}

}
