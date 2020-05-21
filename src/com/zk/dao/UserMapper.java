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
}
