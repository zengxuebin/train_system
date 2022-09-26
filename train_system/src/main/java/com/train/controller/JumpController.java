package com.train.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JumpController {

    @GetMapping(value = {"/", "/index"})
    public String index() {
        return "front_index";
    }

    @GetMapping(value = {"/toLogin"})
    public String toLogin() {
        return "back_login";
    }

    @GetMapping(value = {"/late"})
    public String toLate() {
        return "front_late";
    }

    @GetMapping(value = {"/checkIn"})
    public String toCheckIn() {
        return "front_checkIn";
    }

    @GetMapping(value = {"/price"})
    public String toPrice() {
        return "front_price";
    }

    @GetMapping(value = {"/roundResult"})
    public String toRoundResult() {
        return "front_roundResult";
    }

    @GetMapping(value = {"/saleTime"})
    public String toSaleTime() {
        return "front_saleTime";
    }

    @GetMapping(value = {"/schedule"})
    public String toSchedule() {
        return "front_schedule";
    }

    @GetMapping(value = {"/singleResult"})
    public String toSingleResult() {
        return "front_singleResult";
    }

    @GetMapping(value = {"/transfer"})
    public String toTransfer() {
        return "front_transferResult";
    }

    @GetMapping(value = {"/train"})
    public String toTrain() {
        return "back_train";
    }

}
