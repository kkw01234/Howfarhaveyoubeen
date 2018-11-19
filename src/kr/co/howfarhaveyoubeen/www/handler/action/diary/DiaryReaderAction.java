package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;

public class DiaryReaderAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String id = request.getParameter("diaryID");
		System.out.println(id);
		Gson gson = new Gson();
		DiaryDAO diarydao = DiaryDAO.getInstance();
		request.setAttribute("diaryread", diarydao.getDiary(id));
		return "RequestDispatcher:jsp/diary/readdiary.jsp";
	}

}
