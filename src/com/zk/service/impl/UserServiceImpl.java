/**
 * 
 */
package com.zk.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zk.dao.UserMapper;
import com.zk.entity.User;
import com.zk.service.UserService;

/**
 * @author Shieh
 * @Date 2020-05-20 22:14:29
 * @Description
 *
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper uMapper;

	@Override
	public User selectByUid(Integer uid) {
		return uMapper.selectByUid(uid);
	}

}
