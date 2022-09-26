package com.train.controller;

import com.train.pojo.Train;
import com.train.service.ITrainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@Controller
public class TrainController {

    @Autowired
    private ITrainService trainService;

    private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

    //列车信息管理
    @RequestMapping("/trainList")
    public String trainList(Model model) {
        List<Train> trainList = trainService.findAllTrains();
        model.addAttribute("trainList", trainList);
        System.out.println(trainList);
        return "back_train";
    }

    @GetMapping ("/toUpdateTrain/{trainId}")
    @ResponseBody
    public Train updateTrain(@PathVariable String trainId) {
        Train train = trainService.findTrainById(trainId);
        System.out.println(train);
        return train;
    }

    @RequestMapping("/updateTrain")
    public String updateTrain(String bt, String et, String tim, Train train) throws ParseException {

        Date beginTime = sdf.parse(bt);//转换字符串为Date类型
        train.setBeginTime(beginTime);//最后赋值到对应对象内
        Date endTime = sdf.parse(et);
        train.setEndTime(endTime);
        Date times = sdf.parse(tim);
        train.setTimes(times);

        System.out.println(train);
        trainService.updateTrain(train);
        return "redirect:/trainList";
    }

    @RequestMapping("/addTrain")
    public String addTrain(String bt, String et, String tim, Train train) throws ParseException {


        Date beginTime = sdf.parse(bt);
        train.setBeginTime(beginTime);
        Date endTime = sdf.parse(et);
        train.setEndTime(endTime);
        Date times = sdf.parse(tim);
        train.setTimes(times);

        System.out.println(train);
        trainService.addTrain(train);
        return "redirect:/trainList";
    }

    @RequestMapping("/delete/{trainId}")
    public String delete(@PathVariable String trainId) {
        try {
            trainService.deleteTrainById(trainId);
        } catch (Exception e) {
            e.printStackTrace();

        }
        return "redirect:/trainList";
    }


}
