package com.gtz.service.impl;

import com.gtz.dao.UserDao;
import com.gtz.domain.User;
import com.gtz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author 葛天助
 * @version 1.0
 */

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User queryUserByNameAndPwd(Map<String, Object> map) {
        User user = userDao.getUserByNameAndPwd(map);
        System.out.println("user = " + user);
        return user;
    }

    @Override
    public List<User> queryAllUser() {
        return userDao.getAllUser();
    }
}
