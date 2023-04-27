package com.gtz.service.impl;

import com.gtz.dao.ActivityDao;
import com.gtz.domain.Activity;
import com.gtz.service.ActivityService;
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
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private ActivityDao activityDao;

    @Override
    public Integer saveCreateActivity(Activity activity) {
        return activityDao.insertActivity(activity);
    }

    @Override
    public int queryCountActivityByMap(Map<String,Object> map) {
        return activityDao.selectCountActivityByMap(map);
    }

    @Override
    public List<Activity> queryActivityByPage(Map<String, Object> map) {
        return activityDao.selectActivityByPage(map);
    }

    @Override
    public int deleteActivityByIds(String[] ids) {
        return activityDao.deleteActivityByIds(ids);
    }

    @Override
    public int updateActivity(Activity activity) {
        return activityDao.updateActivity(activity);
    }

    @Override
    public Activity queryActivityById(String id) {
        return activityDao.selectActivityById(id);
    }

    @Override
    public List<Activity> queryAllActivity() {
        return activityDao.selectAllActivity();
    }

    @Override
    public List<Activity> queryActivityByIds(String[] ids) {
        return activityDao.selectActivityByIds(ids);
    }

    @Override
    public int saveCreateActivityByList(List<Activity> activityList) {
        return activityDao.insertActivityByList(activityList);
    }
}
