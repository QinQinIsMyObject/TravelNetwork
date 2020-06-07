/**
 * 业务层
 */
package com.zk.service;

import com.zk.entity.Route;

import java.util.List;

/**
 * @author Shieh
 * @Date 2020-05-20 22:11:54
 * @Description
 */
public interface RouteService {

    List<Route> selectRouteByCidOrRname(Integer cid, String rname);

    Route selectByRid(Integer rid);
}
