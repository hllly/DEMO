package com.demo.pojo;

/**
 * Created by Administrator on 2017/7/30.
 */
public class Permission {
    private int p_id;
    private String p_name;

    public Permission() {
    }

    public Permission(int p_id, String p_name) {
        this.p_id = p_id;
        this.p_name = p_name;
    }

    public int getP_id() {
        return p_id;
    }

    public void setP_id(int p_id) {
        this.p_id = p_id;
    }

    public String getP_name() {
        return p_name;
    }

    public void setP_name(String p_name) {
        this.p_name = p_name;
    }
}
