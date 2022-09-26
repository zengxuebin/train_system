package com.train.service.impl;

import com.train.dao.ITrainMapper;
import com.train.pojo.Train;
import com.train.service.ITrainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class TrainServiceImpl implements ITrainService {

    @Autowired
    private ITrainMapper trainDao;

    //列车信息增删改查
    @Override
    public List<Train> findAllTrains() {
        return trainDao.findAllTrains();
    }

    @Override
    public Train findTrainById(String trainId) {
        return trainDao.findTrainById(trainId);
    }

    @Override
    public int updateTrain(Train train) {
        return trainDao.updateTrain(train);
    }

    @Override
    public int addTrain(Train train) {
        return trainDao.addTrain(train);
    }

    @Override
    public int deleteTrainById(String trainId) {
        return trainDao.deleteTrainById(trainId);
    }
}
