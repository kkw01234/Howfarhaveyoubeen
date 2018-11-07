package kr.co.howfarhaveyoubeen.www.handler.dao.user;

import java.sql.Connection;
import java.util.*;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import kr.co.howfarhaveyoubeen.www.common.sql.Config;

public class UserDAO {
	public static UserDAO it;
	
	public static UserDAO getInstance() {//싱글톤!!
		if(it == null)
			it = new UserDAO();
		return it;
	}
		public void getUser(String id) {
			List<Map<String,Object>> listOfMaps = null;
			Connection conn = Config.getInstance().sqlLogin();
			try {
				QueryRunner queryRunner = new QueryRunner();
				listOfMaps = queryRunner.query(conn,"SELECT id, password from user Where id=?", new MapListHandler(), id);
				System.out.println(listOfMaps); //우선 id들어오면 확인해보는 PW 찾아볼려고 테스트!!!
			}catch(Exception e){
				e.printStackTrace();
			}
		}

		
}