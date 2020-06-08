package com.zk.service;

import com.zk.entity.Favorite;

/**
 * @Author XieFucai
 * @Date 2020/6/7 23:55
 * @Description
 */
public interface FavoriteService {
    /**
     * 收藏功能
     * @param favorite
     * @return
     */
    boolean doCollect(Favorite favorite);
}
