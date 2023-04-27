package com.gtz.dao;

import com.gtz.domain.User;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * @author 葛天助
 * @version 1.0
 */
public interface UserDao {

    /**
     * 根据用户名和密码查询用户
     * @param map
     * @return
     */
    @Select("select * from t_user where login_act = #{loginAct} and login_pwd = md5(#{pwd})")
    User getUserByNameAndPwd(Map<String,Object> map);

    /**
     * 查询所有用户
     * @return
     */
    @Select("select * from t_user")
    List<User> getAllUser();

}
