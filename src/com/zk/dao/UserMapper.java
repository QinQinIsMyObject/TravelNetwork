/**
 *
 */
package com.zk.dao;

import org.apache.ibatis.annotations.Param;
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

    /**
     * 根据激活码查询用户
     *
     * @param code
     * @return
     */
    @Select("select * from tab_user where code=#{code}")
    User selectByCode(String code);

    /**
     * 更新用户信息
     *
     * @param user
     * @return
     */
    int updateUser(User user);

    /**
     * 登录方法
     *
     * @param username
     * @param password
     * @return
     */
    @Select("select * from tab_user where username=#{username} and password=#{password}")
    User login(@Param("username") String username, @Param("password") String password);
}
