package com.train.controller;

import com.train.pojo.Train;
import com.train.service.ISingleService;
import com.train.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

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
public class RoundController {

    @Autowired
    private ISingleService singleService;

    @PostMapping("/searchRound")
    public String searchSingle(String fromStation,
                               String toStation,
                               @DateTimeFormat(pattern = "yyyy-MM-dd")
                                           Date goDate,
                               @DateTimeFormat(pattern = "yyyy-MM-dd")
                                           Date backDate,
                               Model model) {
        model.addAttribute("fromStation", fromStation);
        model.addAttribute("toStation", toStation);
        model.addAttribute("goDate", goDate);
        model.addAttribute("backDate", backDate);

        List<Train> goTrainList = new ArrayList<>();
        List<Train> backTrainList = new ArrayList<>();

        List<String> stations = singleService.findAllFromStations(fromStation);
        model.addAttribute("stations", stations);

        //起点-终点
        List<Train> startAndEndListByGo = singleService.findSingleByStartAndEnd(fromStation, toStation);
        for (Train train: startAndEndListByGo) {
            train.setFlag(1);
        }

        //起点-过
        List<Train> startAndPassListByGo = singleService.findSingleByStartAndPass(fromStation, toStation);
        for (Train train: startAndPassListByGo) {
            train.setFlag(2);
        }

        //过-终点
        List<Train> passAndEndListByGo = singleService.findSingleByPassAndEnd(fromStation, toStation);
        for (Train train: passAndEndListByGo) {
            train.setFlag(3);
        }

        //过-过
        List<Train> passAndPassListByGo = singleService.findSingleBypassAndPass(fromStation, toStation);
        for (Train train: passAndPassListByGo) {
            train.setFlag(4);
        }

        goTrainList.addAll(startAndEndListByGo);
        goTrainList.addAll(startAndPassListByGo);
        goTrainList.addAll(passAndEndListByGo);
        goTrainList.addAll(passAndPassListByGo);

        goTrainList = goTrainList.stream().
                sorted(Comparator.comparing(Train::getBeginTime).
                        thenComparing(Train::getTimes)).collect(Collectors.toList());

        int trainCountByGo = goTrainList.size();
        String goWeek = DateUtil.dateToWeek(goDate);
        model.addAttribute("goWeek", goWeek);
        model.addAttribute("trainCountByGo", trainCountByGo);
        model.addAttribute("goTrainList", goTrainList);

        //起点-终点
        List<Train> startAndEndListByBack = singleService.findSingleByStartAndEnd(toStation, fromStation);
        for (Train train: startAndEndListByBack) {
            train.setFlag(1);
        }

        //起点-过
        List<Train> startAndPassListByBack = singleService.findSingleByStartAndPass(toStation, fromStation);
        for (Train train: startAndPassListByBack) {
            train.setFlag(2);
        }

        //过-终点
        List<Train> passAndEndListByBack = singleService.findSingleByPassAndEnd(toStation, fromStation);
        for (Train train: passAndEndListByBack) {
            train.setFlag(3);
        }

        //过-过
        List<Train> passAndPassListByBack = singleService.findSingleBypassAndPass(toStation, fromStation);
        for (Train train: passAndPassListByBack) {
            train.setFlag(4);
        }

        backTrainList.addAll(startAndEndListByBack);
        backTrainList.addAll(startAndPassListByBack);
        backTrainList.addAll(passAndEndListByBack);
        backTrainList.addAll(passAndPassListByBack);

        if (backTrainList.isEmpty()) {
            return "front_errorTrain";
        }

        backTrainList = backTrainList.stream().
                sorted(Comparator.comparing(Train::getBeginTime).
                        thenComparing(Train::getTimes)).collect(Collectors.toList());

        int trainCountByBack = backTrainList.size();
        String backWeek = DateUtil.dateToWeek(goDate);
        model.addAttribute("backWeek", backWeek);
        model.addAttribute("trainCountByBack", trainCountByBack);
        model.addAttribute("backTrainList", backTrainList);

        return "front_roundResult";
    }

}
