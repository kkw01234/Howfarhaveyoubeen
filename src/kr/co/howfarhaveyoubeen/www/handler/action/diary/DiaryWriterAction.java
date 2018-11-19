package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;

public class DiaryWriterAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//세션방지 1
		
		
		return "RequestDispatcher:jsp/diary/writediary.jsp";
	}
	
}
