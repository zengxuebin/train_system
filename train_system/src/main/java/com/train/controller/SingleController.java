package com.train.controller;

import com.train.pojo.Train;
import com.train.service.ISingleService;
import com.train.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author:曾雪斌
 * @Description:单程查询
 * @History:
 */
@Controller
public class SingleController {

    @Autowired
    private ISingleService singleService;

    @RequestMapping("/searchSingle")
    public String searchSingle(String fromStation,
                               String toStation,
                               @DateTimeFormat(pattern = "yyyy-MM-dd")
                                           Date goDate,
                               Model model) {
        model.addAttribute("fromStation", fromStation);
        model.addAttribute("toStation", toStation);
        model.addAttribute("goDate", goDate);
        //存放查询结果
        List<Train> singleTrainList = new ArrayList<>();

        List<String> stations = singleService.findAllFromStations(fromStation);
        model.addAttribute("stations", stations);

        //起点-终点
        List<Train> startAndEndList = singleService.findSingleByStartAndEnd(fromStation, toStation);
        for (Train train: startAndEndList) {
            train.setFlag(1);
        }

        //起点-过
        List<Train> startAndPassList = singleService.findSingleByStartAndPass(fromStation, toStation);
        for (Train train: startAndPassList) {
            train.setFlag(2);
        }

        //过-终点
        List<Train> passAndEndList = singleService.findSingleByPassAndEnd(fromStation, toStation);
        for (Train train: passAndEndList) {
            train.setFlag(3);
        }

        //过-过
        List<Train> passAndPassList = singleService.findSingleBypassAndPass(fromStation, toStation);
        for (Train train: passAndPassList) {
            train.setFlag(4);
        }

        singleTrainList.addAll(startAndEndList);
        singleTrainList.addAll(startAndPassList);
        singleTrainList.addAll(passAndEndList);
        singleTrainList.addAll(passAndPassList);

        if (singleTrainList.isEmpty()) {
            return "front_errorTrain";
        }

        singleTrainList = singleTrainList.stream().
                sorted(Comparator.comparing(Train::getBeginTime).
                        thenComparing(Train::getTimes)).collect(Collectors.toList());

        for (Train train: singleTrainList) {
            System.out.println(train.getSeat().getFirstSeat());
        }
        int trainCount = singleTrainList.size();
        String goWeek = DateUtil.dateToWeek(goDate);
        model.addAttribute("goWeek", goWeek);
        model.addAttribute("trainCount", trainCount);
        model.addAttribute("singleTrainList", singleTrainList);
        return "front_singleResult";
    }

    @PostMapping("/timesReversed")
    public String timesReversed() {

        return "front_singleResult";
    }
}
