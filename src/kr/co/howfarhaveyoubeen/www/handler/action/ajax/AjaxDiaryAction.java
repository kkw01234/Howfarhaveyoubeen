package kr.co.howfarhaveyoubeen.www.handler.action.ajax;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;
import kr.co.howfarhaveyoubeen.www.handler.dao.file.FileDAO;
import kr.co.howfarhaveyoubeen.www.handler.dao.googlevision.GoogleVisionDAO;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.Userdbbean;

public class AjaxDiaryAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
		Gson gson = new Gson();
		String req= request.getParameter("req");
		String data = request.getParameter("data");
		//HttpSession session = request.getSession();
		String result=null;
		JsonParser parser = null;
		JsonElement element = null;
		if(data != null) {
			parser = new JsonParser();
			element = parser.parse(data);//String을 Jsonelement로
		}
		switch(req) {
		case "writediary":
			result = DiaryDAO.getInstance().insertDiary(element);
			break;
		case "modifydiary":
			result = DiaryDAO.getInstance().modifyDiary(element);
			break;
		case "deleteuser":
			String user = (String) request.getParameter("user");
			UserDAO.getInstance().withdraw(user);
			result="Success";
			break;
		}
		return result;
	}

}
