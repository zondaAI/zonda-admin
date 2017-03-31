package com.zonda.util.mail;

/**
 * 发送邮件需要使用的基本信息
 * 
 * @author FH QQ 313596790[青苔] 创建时间：2014年6月20日
 * @version 2.0
 */
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuthenticator extends Authenticator {

	String userName = null;

	String password = null;

	public MyAuthenticator() {
	}

	public MyAuthenticator(String username, String password) {
		this.userName = username;
		this.password = password;
	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(userName, password);
	}
}
