package com.zk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zk.entity.Route;
import com.zk.entity.RouteImg;
import com.zk.entity.Seller;
import com.zk.service.RouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Author XieFucai
 * @Date 2020/6/5 23:50
 * @Description
 */
@Controller
public class RouteController {

    @Autowired
    private RouteService routeService;

    @RequestMapping("/routeList.do")
    public ModelAndView getRouteList(@RequestParam(name = "pno", required = true, defaultValue = "1") Integer pno,
                                     @RequestParam(name = "cid", required = true, defaultValue = "5") Integer cid,
                                     @RequestParam(name = "rname", required = true, defaultValue = "") String rname) {
        ModelAndView modelAndView = new ModelAndView();
        //开始分页
        PageHelper.startPage(pno, 10);
        List<Route> routeList = routeService.selectRouteByCidOrRname(cid, rname);
        //分好页的数据
        PageInfo<Route> pageInfo = new PageInfo<Route>(routeList);
        if (routeList != null) {
            modelAndView.addObject("rlist", routeList);
            modelAndView.addObject("rname", rname);
            //当前页码
            modelAndView.addObject("pno", pno);
            modelAndView.addObject("page", pageInfo);
            modelAndView.addObject("cid", cid);
            //逻辑视图名
            modelAndView.setViewName("route_list");
            return modelAndView;
        }
        return null;
    }

    /**
     * 根据线路id查询线路详情
     * @param rid
     * @return
     */
    @RequestMapping("/routeDetail.do")
    public ModelAndView routeDetail(@RequestParam(name = "rid", required = true, defaultValue = "") Integer rid) {
        ModelAndView modelAndView = new ModelAndView();
        Route route = routeService.selectByRid(rid);
        if (route != null) {
            List<RouteImg> imgList = route.getRouteImgList();
            Seller seller = route.getSeller();
            //线路对象
            modelAndView.addObject("rt", route);
            //图片集合
            modelAndView.addObject("imgList", imgList);
            //商家
            modelAndView.addObject("sl", seller);
            //去线路详情页面
            modelAndView.setViewName("route_detail");
            return modelAndView;
        }
        return null;
    }
}
