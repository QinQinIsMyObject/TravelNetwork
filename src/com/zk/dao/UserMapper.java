/**
 * 
 */
package com.zk.dao;

import org.apache.ibatis.annotations.Select;

import com.zk.entity.User;

/**
 * @author Shieh
 * @Date 2020-05-20 22:06:01
 * @Description 用户Mmapper
 *
 */
public interface UserMapper {

	/**
	 * 根据用户id查询用户
	 * 
	 * @param uid
	 * @return
	 */
	@Select("select * from tab_user where uid=#{uid}")
	User selectByUid(Integer uid);

	/**
	 * 根据用户名查询该用户
	 * 
	 * @param username
	 * @return
	 */
	@Select("select * from tab_user where username=#{username}")
	User selectByUname(String username);

	/**
	 * 增加用户-点击注册，增加数据到数据库中
	 * 
	 * @param user
	 * @return
	 */
	int addUser(User user);
}
