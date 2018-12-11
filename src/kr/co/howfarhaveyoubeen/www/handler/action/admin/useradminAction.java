package kr.co.howfarhaveyoubeen.www.handler.action.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.Userdbbean;

public class useradminAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userID");
		if(!id.equals("admin")) {
			return "RequestDispatcher:jsp/admin/404.jsp";
		}
		UserDAO dao = UserDAO.getInstance();
		ArrayList<Userdbbean>userList = dao.AllUser();
		Gson gson = new Gson();
		request.setAttribute("userlist",gson.toJson(userList));
		
		return "RequestDispatcher:jsp/admin/useradmin.jsp";
	}

}
