package com.gtz.service;

import com.gtz.domain.User;

import java.util.List;
import java.util.Map;

/**
 * @author 葛天助
 * @version 1.0
 */
public interface UserService {

    User queryUserByNameAndPwd(Map<String,Object> map);

    List<User> queryAllUser();
}
