package com.train.service.impl;

import com.train.dao.TrainMapper;
import com.train.pojo.Train;
import com.train.service.ISingleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
@Service
public class SingleServiceImpl implements ISingleService {

    @Autowired
    private TrainMapper trainMapper;

    @Override
    public List<Train> findSingleByStartAndEnd(String fromStation, String toStation) {
        return trainMapper.selectSingleByStartAndEnd(fromStation, toStation);
    }

    @Override
    public List<Train> findSingleByStartAndPass(String fromStation, String toStation) {
        return trainMapper.selectSingleByStartAndPass(fromStation, toStation);
    }

    @Override
    public List<Train> findSingleByPassAndEnd(String fromStation, String toStation) {
        return trainMapper.selectSingleByPassAndEnd(fromStation, toStation);
    }

    @Override
    public List<Train> findSingleBypassAndPass(String fromStation, String toStation) {
        return trainMapper.selectSingleBypassAndPass(fromStation, toStation);
    }

    @Override
    public List<String> findAllFromStations(String fromStation) {
        return trainMapper.selectAllFromStations(fromStation);
    }
}
