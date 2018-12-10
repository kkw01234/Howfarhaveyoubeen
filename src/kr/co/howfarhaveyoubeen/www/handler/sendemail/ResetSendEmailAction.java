package kr.co.howfarhaveyoubeen.www.handler.sendemail;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.*;
import kr.co.howfarhaveyoubeen.www.handler.dao.googlevision.GoogleVisionDAO;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.SHA256;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO;
import kr.co.howfarhaveyoubeen.www.handler.vo.Userdbbean;

public class ResetSendEmailAction{//login.do


   public boolean resetSendEmail(String userid, String resetPassword, String userEmail, HttpServletRequest request) {
	   	
	    //메일 정보 입력
		String host = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
		String from = "skdldlssk@gmail.com";
		String to = userEmail;
		String subject = "Howfarhaveyoubeen 페이지 계정 초기화 메일입니다.";
		String content = html1(userid,resetPassword,host);
		
		// SMTP에 접속하기 위한 정보를 기입합니다.
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		try{
		    Authenticator auth = new Gmail();
		    Session ses = Session.getInstance(p, auth);
		    ses.setDebug(true);
		    MimeMessage msg = new MimeMessage(ses); 
		    msg.setSubject(subject);
		    Address fromAddr = new InternetAddress(from);
		    msg.setFrom(fromAddr);
		    Address toAddr = new InternetAddress(to);
		    msg.addRecipient(Message.RecipientType.TO, toAddr);
		    msg.setContent(content, "text/html;charset=UTF-8");
		    Transport.send(msg);
		} catch(Exception e){
		    e.printStackTrace();
		    
		    /*
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류가 발생했습니다..');");
			script.println("history.back();");
			script.println("</script>");
			script.close();	
			*/
		    return false;
		}
	
		
		return true;
	}
   
   
   public String html1(String id, String password, String host) { //추가코드 (CSS 적용) 이메일 html 양식
	   
	   String html = "";
	   html +="<div style=\"font-family: 'Apple SD Gothic Neo', 'sans-serif' !important; width: 540px; height: 600px; border-top: 4px solid {$point_color}; margin: 100px auto; padding: 30px 0; box-sizing: border-box;\">\n" + 
	   		"	<h1 style=\"margin: 0; padding: 0 5px; font-size: 28px; font-weight: 400;\">\n" + 
	   		"		<span style=\"font-size: 15px; margin: 0 0 10px 3px;\">How for have you been 에서 보낸 메일 입니다.</span><br />\n" + 
	   		"		<span style=\"color: #4dbce9;\">임시 비밀번호</span> 안내입니다.\n" + 
	   		"	</h1>\n" + 
	   		"	<p style=\"font-size: 16px; line-height: 26px; margin-top: 50px; padding: 0 5px;\">\n" + 
	   		"		안녕하세요.<br />\n" + 
	   		"		요청하신 임시 비밀번호가 생성되었습니다.<br />\n" + 
	   		"		아래 <b style=\"color: #4dbce9;\">'생성 확인'</b> 버튼을 클릭한 뒤, 임시 비밀번호로 로그인하세요.<br />\n" + 
	   		"		감사합니다.\n" + 
	   		"	</p>\n" + 
	   		"	<p style=\"font-size: 16px; margin: 40px 5px 20px; line-height: 28px;\">\n" + 
	   		"\n" + 
	   		"		아이디: <br />\n" + 
	   		"		<span style=\"font-size: 24px;\">"+id+"</span>\n" + 
	   		"	</p>\n" + 
	   		"	<p style=\"font-size: 16px; margin: 40px 5px 20px; line-height: 28px;\">\n" + 
	   		"\n" + 
	   		"		임시 비밀번호: <br />\n" + 
	   		"		<span style=\"font-size: 24px;\">"+password+"</span>\n" + 
	   		"	</p>\n" + 
	   		"</div>\n"+"<div></div>";
	   html +="<a style=\"color: #FFF; text-decoration: none; text-align: center;\" href=\""+host+"\" target=\"_blank\"><p style=\"display: inline-block; width: 210px; height: 45px; margin: 30px 5px 40px; background: {$point_color}; line-height: 45px; vertical-align: middle; font-size: 16px;\">페이지로 가기</p></a>";
	   
	   return html;
	   
   }

}