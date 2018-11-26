package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
//import kr.co.howfarhaveyoubeen.www.handler.dao.file.FileDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.filedbbean;

public class ImageUploadAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter script = response.getWriter();
		
		filedbbean filebean = new filedbbean();
		//FileDAO filedao = new FileDAO();
		
		int diaryID;
	    String userID;
		String fileName;
		String fileRealName;
		int size = 100*1024*1024;
		int maxSize = 10*1024*1024;
		int bbsID = 0;
		long fileSize = 0;
		File fileObj = null;
		String fileInput = null;
		String uploadPath = "D:/hi_upload"; //저장 경로
		
		try {
		
		//파일 정보 불러오기
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		fileInput = (String)files.nextElement();
		fileObj = multi.getFile(fileInput);
		fileRealName = multi.getFilesystemName(fileInput);
		fileName = multi.getOriginalFileName(fileInput);
		
		if(fileName != null){//파일 저장
			File file = new File(uploadPath + "/" + fileRealName);
			fileSize = fileObj.length(); //파일 크기
			
			//확장자 확인
			if(!fileName.endsWith(".bmp") && !fileName.endsWith(".gif") && !fileName.endsWith(".jpg") && !fileName.endsWith(".png") ){
				file.delete();
				script.println("<script>");
				script.println("alert('업로드 할 수 없는 확장자입니다.')");
				script.println("history.back()");
				script.println("</script>");
				return null;
			}
			//파일 크기 확인
			else if(maxSize < fileSize){
				file.delete();
				script.println("<script>");
				script.println("alert('파일 용량이 10MB 이상입니다.')");
				script.println("history.back()");
				script.println("</script>");
				return null;
			}else {
				//DB에 업로드 하기
			}
		}
		}catch(IOException e){
				e.printStackTrace();
				script.println("<script>");
				script.println("alert('예외 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return null;
			}
		
		
		
		return "RequestDispatcher:jsp/diary/imageupload.jsp";
	}
	
}







