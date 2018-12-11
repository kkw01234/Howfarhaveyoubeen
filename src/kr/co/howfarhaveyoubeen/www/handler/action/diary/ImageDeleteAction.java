package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.file.FileDAO;

public class ImageDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception { //에러났을때 지워주는 코드
		HttpSession session = request.getSession();
		if(session.getAttribute("userId")==null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
		String id = (String) session.getAttribute("userID");
		String userid = request.getParameter("name");
		String fileurl = request.getParameter("fileurl");
		
		if(!id.equals(userid)) {
			return "false";
		}
		
		FileDAO filedao = FileDAO.getInstance();
	
		boolean t = filedao.deleteFile(fileurl, request);
		if(t) {
			return "true";
		}else
			return "false";
	}

}
