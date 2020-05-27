package com.zk.utils;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * 发邮件工具类
 */
public final class MailUtils {
	// 发件人邮箱地址---一般为公司邮箱
	private static final String USER = " ";
	// 如果是qq邮箱可使用客户端授权码或登录密码，163邮箱的话就是开启客户端授权码
	private static final String PASSWORD = " ";

	/**
	 *
	 * @param to    收件人邮箱
	 * @param text  邮件正文
	 * @param title 标题
	 */
	/* 发送验证信息的邮件 */
	public static boolean sendMail(String to, String text, String title) {
		try {
			final Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.host", "smtp.qq.com");

			// 发件人的账号
			props.put("mail.user", USER);
			// 发件人的密码
			props.put("mail.password", PASSWORD);

			// 构建授权信息，用于进行SMTP进行身份验证
			Authenticator authenticator = new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					// 用户名、密码
					String userName = props.getProperty("mail.user");
					String password = props.getProperty("mail.password");
					return new PasswordAuthentication(userName, password);
				}
			};
			// 使用环境属性和授权信息，创建邮件会话
			Session mailSession = Session.getInstance(props, authenticator);
			// 创建邮件消息
			MimeMessage message = new MimeMessage(mailSession);
			// 设置发件人
			String username = props.getProperty("mail.user");
			InternetAddress form = new InternetAddress(username);
			message.setFrom(form);

			// 设置收件人
			InternetAddress toAddress = new InternetAddress(to);
			message.setRecipient(Message.RecipientType.TO, toAddress);

			// 设置邮件标题
			message.setSubject(title);

			// 设置邮件的内容体
			message.setContent(text, "text/html;charset=UTF-8");
			// 发送邮件
			Transport.send(message);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void main(String[] args) throws Exception { // 做测试用
		// 发件人邮箱-发送的内容-发送的标题
		MailUtils.sendMail("sun_wei.2416@163.com", "这是一封测试邮件，勿回复。", "测试邮件");
		System.out.println("send success!");
	}
}
