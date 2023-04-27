package com.gtz.dao;

import com.gtz.domain.Activity;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * @author 葛天助
 * @version 1.0
 */
public interface ActivityDao {

    @Insert("insert into t_activity values(#{id},#{owner},#{name},#{startDate}," +
            "#{endDate},#{cost},#{description},#{createTime},#{createBy},#{editTime},#{editBy})")
    Integer insertActivity(Activity activity);

    int selectCountActivityByMap(Map<String,Object> map);

    List<Activity> selectActivityByPage(Map<String,Object> map);

    int deleteActivityByIds(String[] ids);

    @Update("update t_activity set owner = #{owner},name = #{name}," +
            "start_date = #{startDate},end_date = #{endDate},cost = #{cost}," +
            "description = #{description},edit_time = #{editTime},edit_by = #{editBy}" +
            " where id = #{id}")
    int updateActivity(Activity activity);


    Activity selectActivityById(String id);

    List<Activity> selectAllActivity();

    List<Activity> selectActivityByIds(String[] ids);

    int insertActivityByList(List<Activity> activityList);
}
