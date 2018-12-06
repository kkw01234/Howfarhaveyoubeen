package kr.co.howfarhaveyoubeen.www.handler.action.diary;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;
import kr.co.howfarhaveyoubeen.www.handler.dao.file.FileDAO;
import kr.co.howfarhaveyoubeen.www.handler.dao.googlevision.GoogleVisionDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.filedbbean;

public class ImageUploadAction implements Action{//1206수정

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		long starttime=System.currentTimeMillis();
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter script = response.getWriter();
		HttpSession session = request.getSession();
		if(session.getAttribute("userID")==null) {
			return "RequestDispatcher:jsp/error/notloginerror.jsp";
		}
		filedbbean filebean = new filedbbean();
		FileDAO filedao = FileDAO.getInstance();
		
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
		String data = request.getServletContext().getRealPath("/");
		String uploadPath =  data + "image/ticket";//저장 경로
		
		try {
		
		//파일 정보 불러오기
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		System.out.println(multi);
		SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		long currentTime = System.currentTimeMillis(); 
		Enumeration files = multi.getFileNames();
		System.out.println(files);
		fileInput = (String)files.nextElement();
		System.out.println(fileInput);
		
		fileObj = multi.getFile(fileInput);
		fileRealName = multi.getFilesystemName(fileInput);
		if(fileRealName == null) {
			return "RequestDispatcher:jsp/diary/imageupload.jsp";
		}	
		fileName = multi.getOriginalFileName(fileInput);
		String newfileName = simDf.format(new Date(currentTime))+"-"+fileName;
		
		if(!fileName.endsWith(".bmp") && !fileName.endsWith(".gif") && !fileName.endsWith(".jpg") && !fileName.endsWith(".png") ){
			
			script.println("<script>");
			script.println("alert('업로드 할 수 없는 확장자입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
		//파일 크기 확인
		else if(maxSize < fileSize){
			
			script.println("<script>");
			script.println("alert('파일 용량이 10MB 이상입니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
		File oldFile = new File(uploadPath,fileName);
		File newFile = new File(uploadPath,newfileName);
		
		boolean ace;
		if(ace=!oldFile.renameTo(newFile)){// rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
			byte[] buf = new byte[1024];
			FileInputStream fin = new FileInputStream(oldFile);
			FileOutputStream fout = new FileOutputStream(newFile);
			int read = 0;
			while((read=fin.read(buf,0,buf.length))!=-1){
				fout.write(buf, 0, read);
			}
			fin.close();
			fout.close();
			oldFile.delete();
		}
		Gson gson = new Gson();
		JsonObject outData = new JsonObject();
		String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/image/ticket/"+newfileName;
		
		outData.addProperty("ticket",url);
		request.setAttribute("ticket", gson.toJson(outData)); // 있어야하는 코든
		//ArrayList<String> list = googlevisiondao.detectText(uploadPath+"/"+newfileName); //ArrayList
		//OCR 코드
		GoogleVisionDAO googlevisiondao = GoogleVisionDAO.getInstance(); 
		
		String list = googlevisiondao.detectText2(uploadPath+"/"+newfileName);
		if(list.equals("")) {
			script.println("<script>");
			script.println("alert('인식이 되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
			return null;
		}
		ArrayList<String> start = googlevisiondao.fromArray(list);
		ArrayList<String> end = googlevisiondao.toArray(list);
		
		request.setAttribute("start",gson.toJson(start));
		request.setAttribute("end",gson.toJson(end));
		
		}catch(IOException e){
				e.printStackTrace();
				script.println("<script>");
				script.println("alert('예외 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
				return null;
			}
		
		
		long endtime = System.currentTimeMillis();
		System.out.println("실행 시간 : "+ (endtime - starttime)/1000.0);
		return "RequestDispatcher:jsp/diary/realizeocr.jsp";
	}
	
}







