package com.train.controller;

import com.train.pojo.TicketMoney;
import com.train.pojo.Train;
import com.train.service.IMoneyService;
import com.train.service.ISingleService;
import com.train.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.NumberFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
@Controller
public class MoneyController {

    @Autowired
    private ISingleService singleService;
    @Autowired
    private IMoneyService moneyService;

    @RequestMapping("/searchTicketMoney")
    public String searchSingle(String fromStation,
                               String toStation,
                               @DateTimeFormat(pattern = "yyyy-MM-dd")
                                       Date goDate,
                               Model model) {
        model.addAttribute("fromStation", fromStation);
        model.addAttribute("toStation", toStation);
        model.addAttribute("goDate", goDate);

        List<String> fromStations = singleService.findAllFromStations(fromStation);
        model.addAttribute("fromStations", fromStations);
        List<String> toStations = singleService.findAllFromStations(toStation);
        model.addAttribute("toStations", toStations);

        List<Train> trainMoneyList = moneyService.findTrainMoney(fromStation, toStation);


        if (trainMoneyList.isEmpty()) {
            return "front_errorMoney";
        }

        trainMoneyList = trainMoneyList.stream().
                sorted(Comparator.comparing(Train::getBeginTime).
                        thenComparing(Train::getTimes)).collect(Collectors.toList());

        for (Train train: trainMoneyList) {
            Date beginTime = train.getBeginTime();
            Date endTime = train.getEndTime();
            long time = (endTime.getTime() - beginTime.getTime()) / (1000 * 60);
            TicketMoney ticketMoney = new TicketMoney();
            if (train.getTicketMoney().getBusinessSeaMoney() != null) {
                ticketMoney.setBusinessSeaMoney(train.getTicketMoney().getBusinessSeaMoney() * time);
            }
            if (train.getTicketMoney().getFirstSeatMoney() != null) {
                ticketMoney.setFirstSeatMoney(train.getTicketMoney().getFirstSeatMoney() * time);
            }
            if (train.getTicketMoney().getSecondSeatMoney() != null) {
                ticketMoney.setSecondSeatMoney(train.getTicketMoney().getSecondSeatMoney() * time);
            }
            if (train.getTicketMoney().getSoftSleeperMoney() != null) {
                ticketMoney.setSoftSleeperMoney(train.getTicketMoney().getSoftSleeperMoney() * time);
            }
            if (train.getTicketMoney().getHardSleeperMoney() != null) {
                ticketMoney.setHardSleeperMoney(train.getTicketMoney().getHardSleeperMoney() * time);
            }
            if (train.getTicketMoney().getSoftSeatMoney() != null) {
                ticketMoney.setSoftSeatMoney(train.getTicketMoney().getSoftSeatMoney() * time);
            }
            if (train.getTicketMoney().getHardSeatMoney() != null) {
                ticketMoney.setHardSeatMoney(train.getTicketMoney().getHardSeatMoney() * time);
            }
            if (train.getTicketMoney().getNoSeatMoney() != null) {
                ticketMoney.setNoSeatMoney(train.getTicketMoney().getNoSeatMoney() * time);
            }
            if (train.getTicketMoney().getOtherMoney() != null) {
                ticketMoney.setOtherMoney(train.getTicketMoney().getOtherMoney() * time);
            }
            train.setTicketMoney(ticketMoney);
        }

        int trainCount = trainMoneyList.size();
        String goWeek = DateUtil.dateToWeek(goDate);
        model.addAttribute("goWeek", goWeek);
        model.addAttribute("trainCount", trainCount);
        model.addAttribute("trainMoneyList", trainMoneyList);
        return "front_price";
    }

}
