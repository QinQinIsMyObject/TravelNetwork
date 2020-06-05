package com.zk.controller;

import com.zk.entity.Category;
import com.zk.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author XieFucai
 * @Date 2020/6/4 11:23
 * @Description
 */
@Controller
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    /**
     * List可以返回普通的String，可以返回对象，也可以返回list集合包括map
     *
     * @return
     */
    @RequestMapping("/cgList.do")
    @ResponseBody
    public List<Category> getCategoryList() {
        List<Category> categoryList = categoryService.selectAllCategory();
        if (categoryList != null) {
            return categoryList;
        }
        return null;
    }

}
