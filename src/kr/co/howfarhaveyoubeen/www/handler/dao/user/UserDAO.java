package kr.co.howfarhaveyoubeen.www.handler.dao.user;

import java.sql.*;
import java.util.*;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.sql.Config;
import kr.co.howfarhaveyoubeen.www.handler.vo.Userdbbean;

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
		
		public int login(String userID, String userPassword) {
			String SQL = "SELECT userPassword FROM USERDB WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(SQL); //SQL injection ����
				pstmt.setString(1,userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getString(1).equals(userPassword))
						return 1; //�α��� ����
					else
						return 0; // ��й�ȣ ����ġ
				}
				return -1; //���̵� ����
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -2; //DB ����
		}

		public boolean join(Userdbbean user) {
			String SQL = "INSERT INTO USERDB VALUES(?,?,?,?,false,?)";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  user.getUserID());
				pstmt.setString(2,  user.getUserPassword());
				pstmt.setString(3,  user.getUserName());
				pstmt.setString(4,  user.getUserEmail());
				pstmt.setString(5,  user.getEmailCode());
				pstmt.executeUpdate();
				return true;
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		
		
		public boolean getUserEmailChecked(String userID) {
			String SQL = "SELECT userEmailChecked FROM USERDB WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getBoolean(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false; //db오류
		}
		
		public boolean usedEmailCheck(String userEmail) {
			String SQL = "SELECT userEmail FROM USERDB WHERE userEmail=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  userEmail);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false; //db오류
		}
		
		
		public boolean setUserEmailChecked(String userID) {
			String SQL = "UPDATE USERDB SET userEmailChecked = true WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  userID);
				pstmt.executeUpdate();
				return true;
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false; //db오류
		}
		
		
		public String getUserEmail(String userID) {
			String SQL = "SELECT userEmail FROM USERDB WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return null; //db오류
		}
		
		public String getUserIDToEmail(String userEmail) {
			String SQL = "SELECT userID FROM USERDB WHERE userEmail=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  userEmail);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return null; //db오류
		}
		
		
		public boolean checkCode(String userID, String code) {
			String SQL = "SELECT emailCode FROM USERDB WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getString(1).equals(code))
						return true;
					else {
						return false;
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false; //db오류
		}
		
		public boolean resetPassword(String userID, String resetPassword) {
			String SQL = "UPDATE USERDB SET userPassword = ? WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  resetPassword);
				pstmt.setString(2,  userID);
				pstmt.executeUpdate();
				return true;
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false; //db오류
		}
		public void deleteUser(Userdbbean user) throws SQLException {  // 오류났을때 삭제해주는 코드
			String SQL = "DELETE FROM userdb WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getUserID());
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				DbUtils.close(conn);
			}
			
		}
		public String withdraw(String userID) throws SQLException { //회원 탈퇴
			String SQL = "DELETE FROM userdb WHERE userID=?";
		
			String SQL1 = "DELETE FROM diarydb WHERE userID=?";
			String SQL2 = "DELETE FROM coordinates WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement(SQL1);
				pstmt.setString(1, userID);
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement(SQL2);
				pstmt.setString(1, userID);
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				DbUtils.close(conn);
			}
			
			return userID+"님의 회원 탈퇴가 완료되었습니다";
		}
		public ArrayList<Userdbbean> AllUser() throws SQLException { //모든 유저를 받아오는곳 (Admin 계정)
			Connection conn =Config.getInstance().sqlLogin();
			List<Map<String,Object>> maplist = null;
			try {
				QueryRunner queryRunner = new QueryRunner();
				maplist = queryRunner.query(conn,"Select userID,userName,userEmail,userEmailChecked,emailCode FROM userdb",  new MapListHandler());
			}catch(SQLException se){
				se.printStackTrace();
			}finally {
				DbUtils.close(conn);
			}
			Gson gson = new Gson();
			ArrayList<Userdbbean> beanlist = new ArrayList<>();
			for(int i=0;i<maplist.size();i++) {
				Userdbbean bean = gson.fromJson(gson.toJson(maplist.get(i)), Userdbbean.class);
				if(!bean.getUserID().equals("admin"))
					beanlist.add(bean);
			}
			return beanlist;
		}
		public Boolean validateUserID(String userID) {
			String SQL = "SELECT userID FROM USERDB WHERE userID=?";
			Connection conn = Config.getInstance().sqlLogin();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,  userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false; //db오류
		}
}