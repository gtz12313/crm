package com.gtz.service;

import com.gtz.domain.Activity;

import java.util.List;
import java.util.Map;

/**
 * @author 葛天助
 * @version 1.0
 */
public interface ActivityService {
    Integer saveCreateActivity(Activity activity);

    int queryCountActivityByMap(Map<String,Object> map);

    List<Activity> queryActivityByPage(Map<String,Object> map);

    int deleteActivityByIds(String[] ids);

    int updateActivity(Activity activity);

    Activity queryActivityById(String id);

    List<Activity> queryAllActivity();

    List<Activity> queryActivityByIds(String[] ids);

    int saveCreateActivityByList(List<Activity> activityList);
}
