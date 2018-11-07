/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package kr.co.howfarhaveyoubeen.www.common.uploader;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;


//ckeditor 사용!!!
@WebServlet("/Uploader")
public class Uploader extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final int KEY_SIZE = 1024;

	public Uploader() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			response.setContentType("text/html;charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			if(session.getAttribute("user") != null)
			{
				String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/img/uploadimg/";
				String sFunc = request.getParameter("CKEditorFuncNum");

				String data = request.getServletContext().getRealPath("/");
				String url=data+"img/uploadimg";
				MultipartRequest multi = new MultipartRequest(request, url, Integer.MAX_VALUE, "UTF-8");
				String filename = multi.getOriginalFileName("upload");

				String check = filename.substring(filename.lastIndexOf(".")+1, filename.length());
				if(check.equals("jsp") || check.equals("php") || check.equals("js") || check.equals("css") || check.equals("xml")) {
					File deleteFile = new File(url, filename);
					deleteFile.delete();
					response.getWriter().println("<script type='text/javascript'>alert('올릴 수 없는 확장자입니다.');</script>");
					response.getWriter().flush(); 
					return;
				}
				SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				long currentTime = System.currentTimeMillis(); 
				String newFileName =  simDf.format(new Date(currentTime))+"-"+filename;
				File oldFile = new File(url, filename);
				// 실제 저장될 파일 객체 생성
				File newFile = new File(url, newFileName);
				// 파일명 rename
				FileInputStream fin = null;
				FileOutputStream fout = null;
				byte[] buf = new byte[1024];
				int read = 0;
				if(!oldFile.renameTo(newFile)){
					// rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
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
				response.getWriter().println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + sFunc + ", '"+ contextPath + newFileName + "', '완료');</script>");
				response.getWriter().flush(); 
			}
		} catch (Exception ex) {
			throw new ServletException(ex.getMessage(), ex);
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}
}