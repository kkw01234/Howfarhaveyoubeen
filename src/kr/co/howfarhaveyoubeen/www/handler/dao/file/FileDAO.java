package kr.co.howfarhaveyoubeen.www.handler.dao.file;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
public class FileDAO {
	public static FileDAO it;
	
	public static FileDAO getInstance() {
		if(it == null)
			it = new FileDAO();
		return it;
	}

	public boolean deleteFile(String fileurl, HttpServletRequest request) {  // 부적절하거나 취소를 누를경우 파일을 삭제시키는 코드
		String filename;
		String path = request.getServletContext().getRealPath("/image/ticket");
		int index = fileurl.lastIndexOf("/");
		if(index==-1) {
			filename = fileurl;
		}else
			filename = fileurl.substring(index+1);
		System.out.println(filename);
		try {
			File deletefile = new File(path,filename);
			deletefile.delete();
			return true;
		}catch(Exception e){
			e.printStackTrace();
			
		}
		return false;
	}
}
