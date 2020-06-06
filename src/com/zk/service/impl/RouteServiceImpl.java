/**
 * 业务层-实现类
 */
package com.zk.service.impl;

import com.zk.dao.RouteMapper;
import com.zk.entity.Route;
import com.zk.service.RouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Shieh
 * @Date 2020-05-20 22:14:29
 * @Description
 */
@Service
public class RouteServiceImpl implements RouteService {

    @Autowired
    private RouteMapper routeMapper;

    @Override
    public List<Route> selectRouteByCidOrRname(Integer cid, String rname) {
        return routeMapper.selectRouteByCidOrRname(cid, rname);
    }
}
