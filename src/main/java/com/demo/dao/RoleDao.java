package com.demo.dao;

import com.demo.pojo.Role;

/**
 * Created by Administrator on 2017/7/30.
 */
public interface RoleDao {
    public Role selectRoleByRid(int r_id);
    public Role selectRoleByRname(String r_name);
}
