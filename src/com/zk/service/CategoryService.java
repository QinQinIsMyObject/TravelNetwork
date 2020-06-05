/**
 * 业务层
 */
package com.zk.service;

import com.zk.entity.Category;

import java.util.List;

/**
 * @author Shieh
 * @Date 2020-05-20 22:11:54
 * @Description
 */
public interface CategoryService {

    List<Category> selectAllCategory();
}
