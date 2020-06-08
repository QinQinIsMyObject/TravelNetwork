package com.zk.dao;

import com.zk.entity.Favorite;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * @Author XieFucai
 * @Date 2020/6/7 23:45
 * @Description 收藏Mapper
 */
public interface FavoriteMapper {
    /**
     * 根据线路id和用户id查询是否有收藏信息
     *
     * @param rid
     * @param uid
     * @return
     */
    @Select("select * from tab_favorite where rid=#{rid} and uid=#{uid}")
    Favorite selectFtByRidAndUid(@Param("rid") Integer rid, @Param("uid") Integer uid);

    /**
     * @param ft
     * @return
     */
    @Insert("insert into tab_favorite(rid, date, uid) values (#{rid},now(),#{uid})")
    int addCollect(Favorite ft);
}
