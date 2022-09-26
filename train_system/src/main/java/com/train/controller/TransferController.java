package com.train.controller;

import com.train.pojo.Train;
import com.train.pojo.Transfer;
import com.train.service.ITransferService;
import com.train.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author:曾雪斌
 * @Description:中转换乘
 * @History:
 */
@Controller
public class TransferController {

    @Autowired
    private ITransferService transferService;

    @RequestMapping("/searchTransfer")
    public String searchTransfer(String fromStation,
                               String toStation,
                               String transferStation,
                               @DateTimeFormat(pattern = "yyyy-MM-dd")
                                       Date goDate,
                               Model model) {
        model.addAttribute("fromStation", fromStation);
        model.addAttribute("toStation", toStation);
        model.addAttribute("goDate", goDate);
        List<Transfer> transferTrainList = new ArrayList<>();

        //换乘：起点-终(下)—起(上)-终点
        List<Transfer> startEndAndStartEndList =
                transferService.findTransferByStartEndAndStartEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: startEndAndStartEndList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘起点-终(下)—过(上)-终点
        List<Transfer> startEndAndPassEndList =
                transferService.findTransferByStartEndAndPassEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: startEndAndPassEndList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘起点-终(下)—起点(上)-过
        List<Transfer> startEndAndStartPassList =
                transferService.findTransferByStartEndAndStartPass(fromStation, toStation, transferStation);
        for (Transfer transfer: startEndAndStartPassList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘起点-终(下)—过(上)-过
        List<Transfer> startEndAndPassPassList =
                transferService.findTransferByStartEndAndPassPass(fromStation, toStation, transferStation);
        for (Transfer transfer: startEndAndPassPassList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(2);
        }

        //换乘起点-过(下)—起点(上)-终点
        List<Transfer> startPassAndStartEndList =
                transferService.findTransferByStartPassAndStartEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: startPassAndStartEndList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘起点-过(下)—起点(上)-过
        List<Transfer> startPassAndStartPassList =
                transferService.findTransferByStartPassAndStartPass(fromStation, toStation, transferStation);
        for (Transfer transfer: startPassAndStartPassList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(2);
        }

        //换乘起点-过(下)—过(上)-终点
        List<Transfer> startPassAndPassEndList =
                transferService.findTransferByStartPassAndPassEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: startPassAndPassEndList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘起点-过(下)—过(上)-过
        List<Transfer> startPassAndPassPassList =
                transferService.findTransferByStartPassAndPassPass(fromStation, toStation, transferStation);
        for (Transfer transfer: startPassAndPassPassList) {
            transfer.setFlagFirstTrainFromStation(1);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(2);
        }

        //换乘过-终点(下)—起点(上)-终点
        List<Transfer> passEndAndStartEndList =
                transferService.findTransferBySassEndAndStartEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: passEndAndStartEndList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘过-终点(下)—起点(上)-过
        List<Transfer> passEndAndStartPassList =
                transferService.findTransferByPassEndAndStartPass(fromStation, toStation, transferStation);
        for (Transfer transfer: passEndAndStartPassList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(2);
        }

        //换乘过-终点(下)—过(上)-终点
        List<Transfer> passEndAndPassEndList =
                transferService.findTransferByPassEndAndPassEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: passEndAndPassEndList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘过-终点(下)—过(上)-过
        List<Transfer> passEndAndPassPassList =
                transferService.findTransferByPassEndAndPassPass(fromStation, toStation, transferStation);
        for (Transfer transfer: passEndAndPassPassList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(3);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(2);
        }

        //换乘过-过(下)—起点(上)-终点
        List<Transfer> passPassAndStartEndList =
                transferService.findTransferByPassPassAndStartEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: passPassAndStartEndList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘过-过(下)—起点(上)-过
        List<Transfer> passPassAndStartPassList =
                transferService.findTransferByPassPassAndStartPass(fromStation, toStation, transferStation);
        for (Transfer transfer: passPassAndStartPassList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(1);
            transfer.setFlagSecondTrainToStation(2);
        }

        //换乘过-过(下)—过(上)-终点
        List<Transfer> passPassAndPassEndList =
                transferService.findTransferByPassPassAndPassEnd(fromStation, toStation, transferStation);
        for (Transfer transfer: passPassAndPassEndList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(3);
        }

        //换乘过-过(下)—过(上)-过
        List<Transfer> passPassAndPassPassList =
                transferService.findTransferByPassPassAndPassPass(fromStation, toStation, transferStation);
        for (Transfer transfer: passPassAndPassPassList) {
            transfer.setFlagFirstTrainFromStation(2);
            transfer.setFlagFirstTrainToStation(2);
            transfer.setFlagSecondTrainFromStation(2);
            transfer.setFlagSecondTrainToStation(2);
        }

        //汇总
        transferTrainList.addAll(startEndAndStartEndList);
        transferTrainList.addAll(startEndAndPassEndList);
        transferTrainList.addAll(startEndAndStartPassList);
        transferTrainList.addAll(startEndAndPassPassList);

        transferTrainList.addAll(startPassAndStartEndList);
        transferTrainList.addAll(startPassAndStartPassList);
        transferTrainList.addAll(startPassAndPassEndList);
        transferTrainList.addAll(startPassAndPassPassList);

        transferTrainList.addAll(passEndAndStartEndList);
        transferTrainList.addAll(passEndAndStartPassList);
        transferTrainList.addAll(passEndAndPassEndList);
        transferTrainList.addAll(passEndAndPassPassList);

        transferTrainList.addAll(passPassAndStartEndList);
        transferTrainList.addAll(passPassAndStartPassList);
        transferTrainList.addAll(passPassAndPassEndList);
        transferTrainList.addAll(passPassAndPassPassList);

        //默认排序
        transferTrainList = transferTrainList.stream().
                sorted(Comparator.comparing(Transfer::getSumTimes)).collect(Collectors.toList());


        int trainCount = transferTrainList.size();
        model.addAttribute("trainCount", trainCount);
        model.addAttribute("transferTrainList", transferTrainList);
        return "front_transferResult";
    }
}
