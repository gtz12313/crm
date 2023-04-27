package com.gtz.service;

import com.gtz.domain.ActivityRemark;

import java.util.List;

/**
 * @author 葛天助
 * @version 1.0
 */
public interface ActivityRemarkService {
    int saveCreateActivityRemark(ActivityRemark activityRemark);

    ActivityRemark queryActivityRemarkById(String id);

    int saveEditActivityRemark(ActivityRemark activityRemark);

    List<ActivityRemark> queryActivityRemarkByActivityId(String id);

    int deleteActivityRemarkById(String id);
}
