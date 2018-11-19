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
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


//ckeditor 사용!!!
@WebServlet("/Uploader")
public class Uploader extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final int KEY_SIZE = 1024;
	private int maxRequestSize = 1024 * 1024 * 50;
	


	public Uploader() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path = "image/uploadimage"; // 개발자 지정 폴더
		String real_save_path = request.getServletContext().getRealPath(path);
		MultipartRequest multi = new MultipartRequest(request, real_save_path, maxRequestSize, "UTF-8", new DefaultFileRenamePolicy());
		String fileName = multi.getOriginalFileName("upload"); // ckeditor5 static const
		JsonObject outData = new JsonObject();
		outData.addProperty("uploaded", true);
		outData.addProperty("url", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+"/howfarhaveyoubeen2/" + path + "/" + fileName);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		System.out.println(outData.toString());
		response.getWriter().print(outData.toString());


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