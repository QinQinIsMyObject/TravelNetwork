/**
 *
 */
package com.zk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Shieh
 * @Date 2020-05-20 22:36:42
 * @Description
 *
 */
@Controller
public class CommonController {

    /**
     * 测试去首页
     *
     * @return
     */
    @RequestMapping("/indexPage.do")
    public String toIndexPage() {
        return "index";
    }

}
