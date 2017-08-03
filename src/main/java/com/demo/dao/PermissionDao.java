package com.demo.dao;

import com.demo.pojo.Permission;

/**
 * Created by Administrator on 2017/7/30.
 */
public interface PermissionDao {
    public Permission selectPermissionByPid(int p_id);
}
