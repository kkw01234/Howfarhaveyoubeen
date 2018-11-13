package kr.co.howfarhaveyoubeen.www.handler.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.co.howfarhaveyoubeen.www.common.sql.Config;
import kr.co.howfarhaveyoubeen.www.handler.vo.Diarydbbean;


public class DiaryDAO {
	public static DiaryDAO it;
	
	public static DiaryDAO getInstance(){
		if(it==null) {
			it = new DiaryDAO();
		}
		return it;
	}
	
	public String getUserDiary(String id) {
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String,Object>> map = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			map = queryRunner.query(conn, "Select * FROM diarydb WHERE userID=?",new MapListHandler(),id);
			//System.out.println(map);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		Gson gson = new Gson();
		
		return 	gson.toJson(map);
	}
}
