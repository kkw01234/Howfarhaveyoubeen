package kr.co.howfarhaveyoubeen.www.handler.dao.diary;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
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
	
	public String getUserDiary(String id) { //각 유저마다 다이어리 받아옴
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
	
	public String insertDiary(JsonElement jsonelement) throws SQLException {//다이어리한테 추가
		String result=null;
		JsonObject obj= jsonelement.getAsJsonObject();
		System.out.println(obj);
		String diaryTitle =obj.get("diaryTitle").getAsString();
		String user = obj.get("user").getAsString();
		String date =obj.get("date").getAsString();
		String startpoint = obj.get("startpoint").getAsString();
		String endpoint =obj.get("endpoint").getAsString();
		String content = obj.get("content").getAsString();
		String startplat=obj.get("startplat").getAsString();
		String startplng=obj.get("startplng").getAsString();
		String endplat=obj.get("endplat").getAsString();
		String endplng=obj.get("endplng").getAsString();
		
		Connection conn = Config.getInstance().sqlLogin();
		
		try {
			QueryRunner queryRunner = new QueryRunner();
			queryRunner.update(conn, "INSERT INTO diarydb(userID,diaryTItle,diaryContent,diaryDate,startPoint,endPoint) VALUES (?,?,?,?,?,?)",user,diaryTitle,content,date,startpoint,endpoint);
			List<Integer> diaryID = queryRunner.query(conn, "SELECT diaryID FROM diarydb WHERE userID=?",new ColumnListHandler<Integer>(),user);
			int diaryid = diaryID.get(diaryID.size()-1);
			queryRunner.update(conn,"INSERT INTO coordinates(diaryID,userID,point,region,latitude,longitude) VALUES(?,?,?,?,?,?)",diaryid,user,"start",startpoint,startplat,startplng);//출발지 좌표저장
			queryRunner.update(conn,"INSERT INTO coordinates(diaryID,userID,point,region,latitude,longitude) VALUES(?,?,?,?,?,?)",diaryid,user,"end",endpoint,endplat,endplng);//도착지 좌표저장
			result ="success";
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			 DbUtils.close(conn);
		}
		return result;
	}
	
	public String getDiary(String id) { //다이어리 하나의 정보 받기
		Connection conn = Config.getInstance().sqlLogin();
		List<Map<String,Object>> map = null;
		try {
			QueryRunner queryRunner = new QueryRunner();
			map = queryRunner.query(conn, "Select * FROM diarydb WHERE diaryID=?",new MapListHandler(),id);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		Gson gson = new Gson();
		return 	gson.toJson(map.get(0));
	}
}
