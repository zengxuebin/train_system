package com.train.service.impl;

import com.train.dao.MoneyMapper;
import com.train.dao.TrainMapper;
import com.train.pojo.Train;
import com.train.service.IMoneyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
@Service
public class MoneyServiceImpl implements IMoneyService {

    @Autowired
    private MoneyMapper moneyMapper;

    @Override
    public List<Train> findTrainMoney(String fromStation, String toStation) {
        List<Train> trainList = new ArrayList<>();

        List<Train> startAndEndList = moneyMapper.selectMoneyByStartAndEnd(fromStation, toStation);
        for (Train train: startAndEndList) {
            train.setFlag(1);
        }
        List<Train> startAndPassList = moneyMapper.selectMoneyByStartAndPass(fromStation, toStation);
        for (Train train: startAndPassList) {
            train.setFlag(2);
        }
        List<Train> passAndEndList = moneyMapper.selectMoneyByPassAndEnd(fromStation, toStation);
        for (Train train: passAndEndList) {
            train.setFlag(3);
        }
        List<Train> passAndPassList = moneyMapper.selectMoneyBypassAndPass(fromStation, toStation);
        for (Train train: passAndPassList) {
            train.setFlag(4);
        }

        trainList.addAll(startAndEndList);
        trainList.addAll(startAndPassList);
        trainList.addAll(passAndEndList);
        trainList.addAll(passAndPassList);

        return trainList;
    }
}
