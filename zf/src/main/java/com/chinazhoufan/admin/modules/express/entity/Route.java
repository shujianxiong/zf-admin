package com.chinazhoufan.admin.modules.express.entity;

import java.io.Serializable;

public class Route implements Serializable {

    private static final long serialVersionUID = 1L;

    private String acceptTime;
    private String acceptAddress;
    private String remark;
    private String opcode;

    public Route() {
        super();
    }

    public Route(String acceptTime, String acceptAddress, String remark, String opcode) {
        this.acceptTime = acceptTime;
        this.acceptAddress = acceptAddress;
        this.remark = remark;
        this.opcode = opcode;
    }

    public String getAcceptTime() {
        return acceptTime;
    }

    public void setAcceptTime(String acceptTime) {
        this.acceptTime = acceptTime;
    }

    public String getAcceptAddress() {
        return acceptAddress;
    }

    public void setAcceptAddress(String acceptAddress) {
        this.acceptAddress = acceptAddress;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getOpcode() {
        return opcode;
    }

    public void setOpcode(String opcode) {
        this.opcode = opcode;
    }
}
