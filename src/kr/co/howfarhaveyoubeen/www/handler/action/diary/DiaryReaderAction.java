package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;

public class DiaryReaderAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String diaryid = request.getParameter("diaryID");
		HttpSession session = request.getSession();
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/404.jsp";
		}
		Gson gson = new Gson();
		DiaryDAO diarydao = DiaryDAO.getInstance();
		String result=null;
		result = diarydao.updateReadCount(diaryid);//
		request.setAttribute("diaryread", diarydao.getDiary(diaryid));
		request.setAttribute("coordinates", diarydao.getDiaryCoordinates(diaryid));
		request.setAttribute("diaryID", diaryid);
		request.setAttribute("userID", diarydao.findUserID(diaryid));
		return "RequestDispatcher:jsp/diary/readdiary.jsp";
	}

}
