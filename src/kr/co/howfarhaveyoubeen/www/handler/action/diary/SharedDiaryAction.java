package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.Diarydbbean;

public class SharedDiaryAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//String id = request.getParameter("id");//session으로 받아오는게 훨씬 좋네----회원가입쪽 만들어지면 Session쪽으로
		HttpSession session = request.getSession();
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
		String id=(String) session.getAttribute("userID");
		String sequence = (String) request.getParameter("seq");
		Gson gson = new Gson();
		DiaryDAO diarydao = DiaryDAO.getInstance();
		if(sequence.equals("1")) // 최신순
			request.setAttribute("diarylist", diarydao.getSharedUserDiaryForTime());
		else if(sequence.equals("2")) // 조회순
			request.setAttribute("diarylist", diarydao.getSharedUserDiaryForHits());
		
		request.setAttribute("seq",sequence);
		return "RequestDispatcher:jsp/diary/shareddiarylist.jsp";
	}

}
