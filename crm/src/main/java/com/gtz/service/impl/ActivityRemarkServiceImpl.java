package com.gtz.service.impl;

import com.gtz.dao.ActivityRemarkDao;
import com.gtz.domain.ActivityRemark;
import com.gtz.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 葛天助
 * @version 1.0
 */

@Service
public class ActivityRemarkServiceImpl implements ActivityRemarkService {
    @Autowired
    private ActivityRemarkDao activityRemarkDao;

    @Override
    public int saveCreateActivityRemark(ActivityRemark activityRemark) {
        return activityRemarkDao.insertActivityRemark(activityRemark);
    }

    @Override
    public ActivityRemark queryActivityRemarkById(String id) {
        return activityRemarkDao.selectActivityRemarkById(id);
    }

    @Override
    public int saveEditActivityRemark(ActivityRemark activityRemark) {
        return activityRemarkDao.updateActivityRemark(activityRemark);
    }

    @Override
    public List<ActivityRemark> queryActivityRemarkByActivityId(String id) {
        return activityRemarkDao.selectActivityRemarkByActivityId(id);
    }

    @Override
    public int deleteActivityRemarkById(String id) {
        return activityRemarkDao.deleteActivityRemarkById(id);
    }
}
