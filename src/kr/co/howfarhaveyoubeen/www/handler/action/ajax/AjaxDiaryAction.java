package kr.co.howfarhaveyoubeen.www.handler.action.ajax;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;

public class AjaxDiaryAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Gson gson = new Gson();
		String req= request.getParameter("req");
		String data = request.getParameter("data");
		//HttpSession session = request.getSession();
		String result=null;
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(data);//String을 Jsonelement로
		switch(req) {
		case "writediary":
			result = DiaryDAO.getInstance().insertDiary(element);
			break;
		case "modifydiary":
			result = DiaryDAO.getInstance().modifyDiary(element);
		}
		return result;
	}

}
