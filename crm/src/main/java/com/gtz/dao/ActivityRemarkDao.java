package com.gtz.dao;

import com.gtz.domain.ActivityRemark;

import java.util.List;

/**
 * @author 葛天助
 * @version 1.0
 */
public interface ActivityRemarkDao {

    List<ActivityRemark> selectActivityRemarkByActivityId(String id);

    int insertActivityRemark(ActivityRemark activityRemark);

    ActivityRemark selectActivityRemarkById(String id);

    int updateActivityRemark(ActivityRemark activityRemark);

    int deleteActivityRemarkById(String id);
}
