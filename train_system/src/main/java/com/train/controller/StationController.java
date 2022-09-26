package com.train.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.train.pojo.City;
import com.train.pojo.Station;
import com.train.service.IStationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class StationController {

    @Autowired
    private IStationService stationService;

    /**
     * 车站初始化
     */
    @RequestMapping("/queryAllStation")
    public String findAllStation(Model model,
                                 @RequestParam(required=true, defaultValue = "1")Integer page,
                                 @RequestParam(required=false,defaultValue="8")Integer pageSize) {
        PageHelper.startPage(page, pageSize);
        List<Station> stationList = stationService.findAllStation();
        List<City> cityNameList = stationService.findAllCityName();
        PageInfo<Station> pageInfo = new PageInfo<>(stationList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("page", page);
        model.addAttribute("stationList", stationList);
        model.addAttribute("cityNameList", cityNameList);
        return "back_station";
    }

    /**
     * 增加车站操作
     * @param station 车站信息
     * return
     */
    @RequestMapping("/addStation")
    @ResponseBody
    public int addStation(Station station){
        return stationService.addStation(station);
    }

    /**
     * 删除车站操作
     * @param id 列车车站编号
     * @return
     */
    @RequestMapping("/delStation")
    @ResponseBody
    public int delStation(int id){
        return stationService.delStation(id);
    }

    /**
     * 条件查找
     */
    @RequestMapping("/queryStationByCondition")
    public String queryStationByCondition(@RequestParam(required=false, defaultValue = "")String stationName,
                                          @RequestParam(required=false, defaultValue = "")String cityName,
                                          Model model,
                                          @RequestParam(required=true, defaultValue = "1")Integer page,
                                          @RequestParam(required=false,defaultValue="8")Integer pageSize) {
        PageHelper.startPage(page, pageSize);
        List<Station> stationList = stationService.findStationByCondition(stationName, cityName);
        model.addAttribute("stationList", stationList);
        PageInfo<Station> pageInfo = new PageInfo<>(stationList);
        System.out.println(stationName);
        System.out.println(cityName);
        model.addAttribute("stationName", stationName);
        model.addAttribute("cityName", cityName);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("page", page);
        return "back_station";
    }

}
