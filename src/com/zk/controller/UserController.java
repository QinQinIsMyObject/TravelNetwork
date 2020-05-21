/**
 * 
 */
package com.zk.controller;

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
}
