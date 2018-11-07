package kr.co.howfarhaveyoubeen.www.common.sql;

import java.sql.Connection;
import java.sql.DriverManager;

// Enum Singleton
public class Config {

	private Config() {}
	private static class Singleton {
		private static final Config instance = new Config();
	}
	
	public static Config getInstance() {
		return Singleton.instance;
	}
	// DB 커넥션 Variable
	private Connection conn = null;

	// DB 정보

	private final String tool = "jdbc:mysql://";
	private final String port = "3306";
	
	private final String domain = "localhost";
	private final String id = "root";
	private final String pw = "dnpqtjqltm";
	private final String dbname = "kgcs";
	//String URL= "jdbc:mysql://127.0.0.1:3306/db_example?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=CONVERT_TO_NULL&serverTimezone=GMT";
	private String url = tool + domain + ":" + port + "/" + dbname
			+ "?useUnicode=true&characterEncoding=UTF-8&serverTimezone=GMT&useSSL=false&validationQuery=select 1";

	public Connection sqlLogin() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("DB 연결 성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("DB 연결 실패");
		}
		return conn;
	}
}
