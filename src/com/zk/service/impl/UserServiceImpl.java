/**
 * 业务层-实现类
 */
package com.zk.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zk.dao.UserMapper;
import com.zk.entity.User;
import com.zk.service.UserService;
import com.zk.utils.MailUtils;
import com.zk.utils.UuidUtil;

/**
 * @author Shieh
 * @Date 2020-05-20 22:14:29
 * @Description
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper uMapper;

    @Override
    public User selectByUid(Integer uid) {
        return uMapper.selectByUid(uid);
    }

    @Override
    public boolean checkUname(String username) {
        User user = uMapper.selectByUname(username);
        if (user != null) {
            return false;
        } else {
            return true;
        }
    }

    @Transactional
    public boolean registerUser(User user) {
        // 生成随机的激活码
        user.setCode(UuidUtil.getUuid());
        // 设置用户激活状态为N-未激活
        user.setStatus("N");
        int num = uMapper.addUser(user);
        if (num > 0) {
            // 用户的信息已经保存到数据库中
            String context = "<a href='http://localhost:8080/TravelProject/activeMail.do?code=" + user.getCode()
                    + "'>点击激活旅游网</a>";
            // 发件人邮箱-发送的内容-发送的标题
            MailUtils.sendMail(user.getEmail(), context, "旅游网激活邮件");
            return true;
        }
        return false;
    }

    @Transactional
    public boolean activeUser(String code) {
        User user = uMapper.selectByCode(code);
        // 注册了也就是有这个用户存在-去激活-返回true
        if (user != null) {
            // 设置激活状态为Y
            user.setStatus("Y");
            // 更新激活状态为Y
            if (uMapper.updateUser(user) > 0) {
                return true;
            } else {
                return false;
            }
        }
        return false;
    }

    @Override
    public User login(String username, String password) {
        return uMapper.login(username, password);
    }

}
