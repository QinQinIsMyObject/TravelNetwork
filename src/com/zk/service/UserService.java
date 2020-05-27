/**
 * 业务层
 */
package com.zk.service;

import com.zk.entity.User;

/**
 * @author Shieh
 * @Date 2020-05-20 22:11:54
 * @Description
 *
 */
public interface UserService {

	User selectByUid(Integer uid);

	boolean checkUname(String username);

	/**
	 * 只是关心是否增加成功，不关心是如何增加的
	 * 
	 * @return
	 */
	boolean registerUser(User user);
}
