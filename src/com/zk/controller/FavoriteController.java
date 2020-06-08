package com.zk.controller;

import com.zk.entity.Favorite;
import com.zk.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author XieFucai
 * @Date 2020/6/8 0:04
 * @Description
 */
@Controller
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    /**
     * 收藏
     *
     * @param favorite
     * @return
     */
    @RequestMapping("/doCollect.do")
    @ResponseBody
    public String doCollect(Favorite favorite) {
        boolean flag = favoriteService.doCollect(favorite);
        if (flag) {
            return "true";
        }
        return "false";
    }
}
