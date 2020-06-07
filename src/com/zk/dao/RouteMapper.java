/**
 *
 */
package com.zk.dao;

import com.zk.entity.Route;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Shieh
 * @Date 2020-05-20 22:06:01
 * @Description 线路Mmapper
 *
 */
public interface RouteMapper {

    /**
     * 查询
     * @param cid
     * @param rid
     * @return
     */
    List<Route> selectRouteByCidOrRname(@Param("cid") Integer cid, @Param("rname") String rname);

    /**
     * 根据线路id查询线路
     * @param rid
     * @return
     */
    Route selectByRid(Integer rid);
}
