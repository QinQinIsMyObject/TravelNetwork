/**
 * 业务层-实现类
 */
package com.zk.service.impl;

import com.zk.dao.CategoryMapper;
import com.zk.entity.Category;
import com.zk.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Shieh
 * @Date 2020-05-20 22:14:29
 * @Description
 */
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper cMapper;

    @Override
    public List<Category> selectAllCategory() {
        return cMapper.selectAllCategory();
    }

}
