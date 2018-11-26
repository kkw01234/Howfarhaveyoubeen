package kr.co.howfarhaveyoubeen.www.handler.dao.user;

import java.security.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PasswordCheck {
	public boolean passwordValidator(String password){
		 String passwordPolicy = "((?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,})";
		    Pattern pattern = Pattern.compile(passwordPolicy);
		    Matcher matcher = pattern.matcher(password);
		    return matcher.matches();
	}

}
