package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;

public class DiaryWriterAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//세션방지 1
		HttpSession session = request.getSession();
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/404.jsp";
		}
		
		String data = request.getParameter("data");
		if(data != null) {
			System.out.println(data);
			request.setAttribute("ocrdata", data);
			
		}
		if(session.getAttribute("ticket")!=null) {
			request.setAttribute("ticket", session.getAttribute("ticket"));
			session.setAttribute("ticket",null);
		}
		request.setAttribute("userID", session.getAttribute("userID"));
		return "RequestDispatcher:jsp/diary/writediary.jsp";
	}
	
}
