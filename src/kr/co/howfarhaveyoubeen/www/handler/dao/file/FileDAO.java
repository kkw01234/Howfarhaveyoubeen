package kr.co.howfarhaveyoubeen.www.handler.dao.file;

public class FileDAO {
	public static FileDAO it;
	
	public static FileDAO getInstance() {
		if(it == null)
			it = new FileDAO();
		return it;
	}
}
