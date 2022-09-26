package com.train.controller;

import org.springframework.web.bind.annotation.GetMapping;

public class BackController {
    @GetMapping(value = {"/toStation"})
    public String index() {
        return "back_trainId";
    }
}
