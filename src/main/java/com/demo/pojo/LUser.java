package com.demo.pojo;

/**
 * com.demo.pojo LUser, used by user login
 */
public class LUser {
    private int u_id;
    private String u_nick;
    private String u_pwd;

    public LUser() { }

    public LUser(int u_id, String u_nick, String u_pwd) {
        this.u_id = u_id;
        this.u_nick = u_nick;
        this.u_pwd = u_pwd;
    }

    public LUser(String u_nick, String u_pwd) {
        this.u_nick = u_nick;
        this.u_pwd = u_pwd;
    }

    public int getU_id() {
        return u_id;
    }

    public void setU_id(int u_id) {
        this.u_id = u_id;
    }

    public String getU_nick() {
        return u_nick;
    }

    public void setU_nick(String u_nick) {
        this.u_nick = u_nick;
    }

    public String getU_pwd() {
        return u_pwd;
    }

    public void setU_pwd(String u_pwd) {
        this.u_pwd = u_pwd;
    }
}
