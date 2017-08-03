package com.demo.dao;

import com.demo.pojo.MappingRP;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by Administrator on 2017/7/30.
 */
public interface MappingRPDao {
    public HashSet<MappingRP> selectRPByRid(int r_id);
    public HashSet<MappingRP> selectRPByPid(int p_id);
}
