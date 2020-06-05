/**
 *
 */
package com.zk.dao;

import com.zk.entity.Category;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author Shieh
 * @Date 2020-05-20 22:06:01
 * @Description 分类Mmapper
 *
 */
public interface CategoryMapper {

    /**
     * 查询分类
     * @return
     */
    @Select("select cid,cname from tab_category")
    List<Category> selectAllCategory();

}
