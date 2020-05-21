/**
 * 
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
}
