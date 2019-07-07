package kr.co.howfarhaveyoubeen.www.handler.sendemail;

import javax.mail.Authenticator;

import javax.mail.PasswordAuthentication;



public class Gmail extends Authenticator {



    @Override

    protected PasswordAuthentication getPasswordAuthentication() {

        return new PasswordAuthentication("skdldlssk","//비밀번호");
        //비밀번호
    }

    

}
