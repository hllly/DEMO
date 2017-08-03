package com.demo.pojo;

/**
 * Created by Administrator on 2017/7/30.
 */
public class MappingUR {
    private int u_id;
    private int r_id;

    public MappingUR(int u_id, int r_id) {
        this.u_id = u_id;
        this.r_id = r_id;
    }

    public MappingUR() {
    }

    public int getU_id() {
        return u_id;
    }

    public void setU_id(int u_id) {
        this.u_id = u_id;
    }

    public int getR_id() {
        return r_id;
    }

    public void setR_id(int r_id) {
        this.r_id = r_id;
    }
}
