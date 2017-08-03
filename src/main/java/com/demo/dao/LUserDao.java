package com.demo.dao;

import com.demo.pojo.LUser;
import org.springframework.stereotype.Repository;

/**
 * LUserDao
 */
@Repository
public interface LUserDao {
    public LUser selectUserByNick(String nick);
    public LUser selectUserByUid(int u_id);
    public void addUser(String nick,String pwd);
}
