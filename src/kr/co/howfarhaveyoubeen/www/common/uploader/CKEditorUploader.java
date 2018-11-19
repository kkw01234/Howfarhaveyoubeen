package kr.co.howfarhaveyoubeen.www.common.uploader;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.howfarhaveyoubeen.www.common.controller.Action;

public class CKEditorUploader implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			response.setContentType("text/html;charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			
			if(true) //세션 생긴후는 변경부탁
			{
				String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/image/uploadimage/";
				//String sFunc = request.getParameter("data");
				
				//System.out.println(contextPath);
				//System.out.println(sFunc);
				String data = request.getServletContext().getRealPath("/");
				String url=data+"image/uploadimage";
				MultipartRequest multi = new MultipartRequest(request, url, Integer.MAX_VALUE, "UTF-8", new DefaultFileRenamePolicy());
				String filename = multi.getOriginalFileName("upload");
				String check = filename.substring(filename.lastIndexOf(".")+1, filename.length());
				if(check.equals("jsp") || check.equals("php") || check.equals("js") || check.equals("css") || check.equals("xml")) {
					File deleteFile = new File(url, filename);
					deleteFile.delete();
					response.getWriter().println("<script type='text/javascript'>alert('올릴 수 없는 확장자입니다.');</script>");
					response.getWriter().flush(); 
					return "ERROR";
				}
				SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				long currentTime = System.currentTimeMillis(); 
				String newFileName =  simDf.format(new Date(currentTime))+"-"+filename;
				System.out.println(newFileName);
				File oldFile = new File(url, filename);
				// 실제 저장될 파일 객체 생성
				File newFile = new File(url, newFileName);
				// 파일명 rename
				FileInputStream fin = null;
				FileOutputStream fout = null;
				byte[] buf = new byte[1024];
				int read = 0;
				boolean ace;
				if(ace=!oldFile.renameTo(newFile)){
					// rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
					System.out.println(ace);
					buf = new byte[1024];
					fin = new FileInputStream(oldFile);
					fout = new FileOutputStream(newFile);
					read = 0;
					while((read=fin.read(buf,0,buf.length))!=-1){
						fout.write(buf, 0, read);
					}
					fin.close();
					fout.close();
					oldFile.delete();
				} 
				
				//response.getWriter().println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction('"+ contextPath + newFileName + "', '완료');</script>");
				//response.getWriter().flush(); 
				//String json = "{\"uploaded\":true, \"url\":\"http://localhost:8080"+request.getContextPath()+"/image/uploadimage/"+FileNmae+"\"}";
				JsonObject outData = new JsonObject();
				outData.addProperty("uploaded", true);
				outData.addProperty("url",request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/image/uploadimage/"+newFileName);
				System.out.println(outData.toString());
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(outData.toString());
				return null;
				


			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage(), ex);
		}
		return "error";
	}

}
