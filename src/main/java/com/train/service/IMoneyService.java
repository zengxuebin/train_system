package com.train.service;

import com.train.pojo.Train;

import java.util.List;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
public interface IMoneyService {
    List<Train> findTrainMoney(String fromStation, String toStation);
}
