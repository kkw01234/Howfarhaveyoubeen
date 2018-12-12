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

public class AjaxRegisterAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String req= request.getParameter("req");
		String data = request.getParameter("data");
		String result=null;
		
		switch(req) {
		case "userID":
			Boolean b = UserDAO.getInstance().validateUserID(data);
			if(b) {
				result = "중복된 아이디가 있습니다.";
			}else
				result="";
			break;
		case "email" : 
			Boolean a =UserDAO.getInstance().usedEmailCheck(data);
			if(a) {
				result = "중복된 이메일이 있습니다.";
			}else
				result="";
			break;
		}
		return result;
	}

}
