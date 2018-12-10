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

public class SendEmailAction {//login.do


   public int SendEmail(String userid, String code, HttpServletRequest request) {

		UserDAO userDAO = new UserDAO();
		String result = null;
		boolean emailChecked = userDAO.getUserEmailChecked(userid);


		if(emailChecked == true) {
			/*
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 인증 된 회원입니다.');");
			script.println("</script>");
			script.close();
			result = "RequestDispatcher:jsp/main/index.jsp";
			return result;
			*/
			return 0;
		}


		String host = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
		String from = "skdldlssk@gmail.com";
		String to = userDAO.getUserEmail(userid);
		String subject = "Howfarhaveyoubeen 페이지 이메일 인증 메일입니다.";
		String content = html1(host,code,userid);

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

			result = "RequestDispatcher:jsp/main/sendemail.jsp";
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
		    return -1;
		}


		return 1;
	}
		
   public String html1(String host, String code, String userid) { //추가코드 (CSS 적용) 이메일 html 양식
	   String html ="";
	   html +="\n" + 
	   		"<div style=\"font-family: 'Apple SD Gothic Neo', 'sans-serif' !important; width: 540px; height: 600px; border-top: 4px solid #4dbce9; margin: 100px auto; padding: 30px 0; box-sizing: border-box;\">\n" + 
	   		"	<h1 style=\"margin: 0; padding: 0 5px; font-size: 28px; font-weight: 400;\">\n" + 
	   		"		<span style=\"font-size: 15px; margin: 0 0 10px 3px;\">How for have you been</span><br />\n" + 
	   		"		<span style=\"color:#4dbce9;\">메일인증</span> 안내입니다.\n" + 
	   		"	</h1>\n" + 
	   		"	<p style=\"font-size: 16px; line-height: 26px; margin-top: 50px; padding: 0 5px;\">\n" + 
	   		"		안녕하세요.<br />\n" + 
	   		"		How far have you been에 가입해 주셔서 진심으로 감사드립니다.<br />\n" + 
	   		"		아래 <b style=\"color:#4dbce9;\">'메일 인증'</b> 버튼을 클릭하여 회원가입을 완료해 주세요.<br />\n" + 
	   		"		감사합니다.\n" + 
	   		"	</p>\n" + 
	   		"\n" + 
	   		"	<a style=\"color: #FFF; text-decoration: none; text-align: center;\" href=\""+host+"emailCheckAction.do?code="+code+"&userID="+userid+"\" target=\"_blank\"><p style=\"display: inline-block; width: 210px; height: 45px; margin: 30px 5px 40px; background: #4dbce9; line-height: 45px; vertical-align: middle; font-size: 16px;\">메일 인증</p></a>\n" + 
	   		"\n" + 
	   		"	<div style=\"border-top: 1px solid #DDD; padding: 5px;\">\n" + 
	   		"		<p style=\"font-size: 13px; line-height: 21px; color: #555;\">\n" + 
	   		"			만약 버튼이 정상적으로 클릭되지 않는다면, 아래 링크를 복사하여 접속해 주세요.<br />\n" + 
	   		"			"+host+"emailCheckAction.do?code="+code+"&userID="+userid+"\n" + 
	   		"		</p>\n" + 
	   		"	</div>\n" + 
	   		"</div>";
	   return html;
   }

}
