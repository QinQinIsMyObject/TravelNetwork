/**
 * 控制层-调用业务层
 */
package com.zk.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zk.entity.User;
import com.zk.service.UserService;

/**
 * @author Shieh
 * @Date 2020-05-20 22:16:56
 * @Description
 *
 */
@Controller
public class UserController {

	@Autowired
	private UserService uService;

	/**
	 * 去测试页面---测试项目能否正常运行
	 * 
	 * @param uid
	 * @return
	 */
	@RequestMapping("/test.do")
	public ModelAndView toTestPage(Integer uid) {
		User user = uService.selectByUid(uid);
		if (user != null) {
			return new ModelAndView("test", "user", user);
		}
		return null;
	}

	/**
	 * 去注册页面
	 * 
	 * @return
	 */
	@RequestMapping("/toRegPage.do")
	public String toRegPage() {
		return "register";
	}

	/**
	 * 验证用户名是否重复
	 * 
	 * @param username
	 * @return
	 */
	@RequestMapping("/checkUname.do")
	public String checkUserName(String username) {
		boolean flag = uService.checkUname(username);
		if (!flag) {
			// 用户名重复，返回false
			return "false";
		} else {
			return "true";
		}
	}

	/**
	 * 注册功能
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping("/doReg.do")
	public ModelAndView doReg(User user) {
		ModelAndView mv = new ModelAndView();
		boolean flag = uService.registerUser(user);
		if (flag) {
			// 注册成功-去注册成功页面
			mv.setViewName("register_ok");
		} else {
			// 注册失败-重新回到注册页面
			mv.setViewName("register");
			mv.addObject("msg", "注册失败");
		}
		return mv;
	}

	/**
	 * 用户激活；激活成功-去登陆URL； 激活成功-给其提示信息（激活失败，请联系管理员）
	 * 
	 * @param code
	 * @param res
	 * @throws IOException
	 */
	@RequestMapping("/activeMail.do")
	private void activeUser(String code, HttpServletResponse res) throws IOException {
		boolean flag = uService.activeUser(code);
		// 提示信息
		String msg = null;
		if (flag) {
			msg = "<h3><a href='toLogin.do'>激活成功，点击登录。</a></h3>";
		} else {
			msg = "<h3>激活失败，请联系管理员！</h3>";
		}
		res.setContentType("text/html;charset=utf-8");
		res.getWriter().write(msg);
	}

	/**
	 * 去登录页面
	 * 
	 * @return
	 */
	@RequestMapping("/toLogin.do")
	public String toLoginPage() {
		return "login";
	}
}
