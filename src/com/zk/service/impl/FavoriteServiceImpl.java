package com.zk.service.impl;

import com.zk.dao.FavoriteMapper;
import com.zk.dao.RouteMapper;
import com.zk.entity.Favorite;
import com.zk.entity.Route;
import com.zk.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Author XieFucai
 * @Date 2020/6/7 23:57
 * @Description 收藏业务实现
 */
@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;

    @Autowired
    private RouteMapper routeMapper;

    @Transactional
    public boolean doCollect(Favorite favorite) {
        Favorite favorite1 = favoriteMapper.selectFtByRidAndUid(favorite.getRid(), favorite.getUid());
        if (favorite1 == null) {
            if (favoriteMapper.addCollect(favorite) > 0) {
                Route route = routeMapper.selectByRid(favorite.getRid());
                route.setCount(route.getCount() + 1);
                routeMapper.updateCount(route);
                return true;
            }
            return false;
        }
        return false;
    }
}
