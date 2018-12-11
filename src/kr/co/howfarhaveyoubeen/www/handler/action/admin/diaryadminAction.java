package kr.co.howfarhaveyoubeen.www.handler.action.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.diary.DiaryDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.Diarydbbean;

public class diaryadminAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userID");
		if(!id.equals("admin")) {
			return "RequestDispatcher:jsp/admin/404.jsp";
		}
		DiaryDAO dao = DiaryDAO.getInstance();;
		Gson gson = new Gson();
		ArrayList<Diarydbbean> beanlist = dao.Alldiary();
		request.setAttribute("diarylist",gson.toJson(beanlist));
		return  "RequestDispatcher:jsp/admin/diaryadmin.jsp";
	}

}
