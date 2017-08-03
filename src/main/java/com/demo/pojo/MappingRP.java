package com.demo.pojo;

/**
 * Created by Administrator on 2017/7/30.
 */
public class MappingRP {
    private int r_id;
    private int p_id;

    public MappingRP() {
    }

    public MappingRP(int r_id, int p_id) {
        this.r_id = r_id;
        this.p_id = p_id;
    }

    public int getR_id() {
        return r_id;
    }

    public void setR_id(int r_id) {
        this.r_id = r_id;
    }

    public int getP_id() {
        return p_id;
    }

    public void setP_id(int p_id) {
        this.p_id = p_id;
    }
}
