package kr.co.howfarhaveyoubeen.www.handler.action.main;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.co.howfarhaveyoubeen.www.common.controller.*;
import kr.co.howfarhaveyoubeen.www.handler.dao.googlevision.GoogleVisionDAO;
import kr.co.howfarhaveyoubeen.www.handler.dao.user.UserDAO;

public class LoginAction implements Action{//login.do


   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      LoginManager manager = LoginManager.getInstance();
      String id = request.getParameter("id");
      String password = request.getParameter("password_hash");
      //System.out.println(id+password);
    
      UserDAO dao = UserDAO.getInstance();
      dao.getUser(id);// Database test
     
      GoogleVisionDAO dao2 = GoogleVisionDAO.getInstance(); //Googlevision test
      String url = "C:\\Users\\gny32\\Desktop\\웹개발용\\KakaoTalk_20181105_171530972.jpg";
      dao2.detectText(url);
      
     /* UserDAO dao = UserDAO.getInstance();
      UserBean it = dao.getUser(id);
      HttpSession session = request.getSession();
      Gson gson = new Gson();
      if(it!=null) 
         if(it.password.equals(password)) {
            if(manager.isUsing(id)) {
               manager.removeSession(id);
            }
            manager.setSession(request.getSession(), id);
            UserTypeBean type = dao.getType(it.type);
            String path = "kr.ac.kyonggi.cs.handler.vo.user."+ type.class_type;
            Class<?> t = Class.forName(path);
            UserBean who = (UserBean)t.newInstance();
            if(who.getClass().getName().equals("kr.ac.kyonggi.cs.handler.vo.user.BigUser")) 
               copy2(who,it);
            else
               copy1(who, it);
            dao.whoIsLogIn(id);
            File log = new File(request.getServletContext().getRealPath("/WEB-INF"), "log.txt");
            BufferedWriter bufWriter = new BufferedWriter(new FileWriter(log, true));
            bufWriter.write(new Date().toString() + "] " + it.id + "(" + it.name + ")이 로그인하였습니다.\r\n");
            bufWriter.close();
            session.setAttribute("user", gson.toJson(who));
            session.setAttribute("type", gson.toJson(type));
            session.setAttribute("miss", 0);
            return "RequestDispatcher:jsp/main/main.jsp";
         }
      session.setAttribute("miss",(Integer)session.getAttribute("miss")+1);
      */
      return "RequestDispatcher:jsp/main/login.jsp";
      
   }


   /*void copy1(UserBean it, UserBean copy) {
      it.id = copy.id;
      it.name = copy.name;
      it.gender = copy.gender;
      it.birth = copy.birth;
      it.email = copy.email;
      it.phone = copy.phone;
      it.type = copy.type;
      it.reg_date = copy.reg_date;
      it.myhomeid = copy.myhomeid;
   }
   
   void copy2(UserBean who, UserBean it) {
      who.id = it.id;
      who.name = it.name;
      who.gender = it.gender;
      who.birth = it.birth;
      who.email = it.email;
      who.phone = it.phone;
      who.type = it.type;
      who.reg_date = it.reg_date;
      who.major = it.major; 
      who.per_id = it.per_id;
      who.grade = it.grade;
      who.state = it.state;
      who.myhomeid = it.myhomeid;

   }*/

}