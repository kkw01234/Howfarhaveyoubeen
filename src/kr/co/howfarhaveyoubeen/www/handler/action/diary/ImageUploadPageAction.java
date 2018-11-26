package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;

public class ImageUploadPageAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		return "RequestDispatcher:jsp/diary/imageupload.jsp";
	}
	
}
