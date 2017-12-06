package com.chinazhoufan.admin.modules.express.entity;


import java.io.Serializable;
import java.util.List;

import com.google.common.collect.Lists;


/**
 * 顺丰物流信息返回entity
 * @author liuxiaodong
 * @date 2017-11-04
 */
public class RouteResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    private String mailno;
    private List<Route> routeList = Lists.newArrayList();


    public RouteResponse() {
        super();
    }

    public RouteResponse(String mailno) {
        this.mailno = mailno;
    }

    public String getMailno() {
        return mailno;
    }

    public void setMailno(String mailno) {
        this.mailno = mailno;
    }

    public List<Route> getRouteList() {
        return routeList;
    }

    public void setRouteList(List<Route> routeList) {
        this.routeList = routeList;
    }
}
