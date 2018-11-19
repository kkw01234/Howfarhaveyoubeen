package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.Diarydbbean;

public class DiaryListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//String id = request.getParameter("id");//session으로 받아오는게 훨씬 좋네----회원가입쪽 만들어지면 Session쪽으로
		String id="test";
		Gson gson = new Gson();
		DiaryDAO diarydao = DiaryDAO.getInstance();
		//String aaa =  gson.toJson(diarydao.getUserDiary(id));
		//System.out.println(aaa);
		request.setAttribute("diarylist", diarydao.getUserDiary(id));
		return "RequestDispatcher:jsp/diary/diarylist.jsp";
	}

}
