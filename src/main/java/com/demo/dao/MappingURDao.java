package com.demo.dao;

import com.demo.pojo.MappingUR;
import java.util.HashSet;

/**
 * Created by Administrator on 2017/7/30.
 */
public interface MappingURDao {
    public HashSet<MappingUR> selectURByUid(int u_id);
    public HashSet<MappingUR> selectURByRid(int r_id);
}
