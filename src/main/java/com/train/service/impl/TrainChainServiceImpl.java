package com.train.service.impl;

import com.train.dao.TrainChainMapper;
import com.train.pojo.CheckTicket;
import com.train.pojo.Station;
import com.train.pojo.Train;
import com.train.pojo.TrainChain;
import com.train.service.ITrainChainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TrainChainServiceImpl implements ITrainChainService {
    @Autowired
    private TrainChainMapper trainChainDao;
    @Override
    public List<TrainChain> findAllTC(String trainId) {
        return trainChainDao.findAllTC(trainId);
    }

    @Override
    @Transactional
    public int addTC(TrainChain trainChain) {
        return trainChainDao.addTC(trainChain);
    }

    @Override
    @Transactional
    public int setTC(TrainChain trainChain) {

        return trainChainDao.setTC(trainChain);
    }

    @Override
    @Transactional
    public int setTCLate(TrainChain trainChain) {
        return trainChainDao.setTCLate(trainChain);
    }

    @Override
    public List<TrainChain> findOnceTC(int id) {
        return trainChainDao.findOnceTC(id);
    }

    @Override
    @Transactional
    public int deleteTC(int id) {
        return trainChainDao.deleteTC(id);
    }



    @Override
    public List<Train> findAllTrain() {
        return trainChainDao.findAllTrain();
    }

    @Override
    public List<Station> findAllStation() {
        return trainChainDao.findAllStation();
    }

    @Override
    public CheckTicket findCTById(int id) {
        return trainChainDao.findCTById(id);
    }

    @Override
    public TrainChain findCTByname(TrainChain trainChain) {
        return trainChainDao.findCTByname(trainChain);
    }

    @Override
    public List<CheckTicket> findCTByStationName(String name) {
        return trainChainDao.findCTByStationName(name);
    }

    @Override
    public Train findOnceTrain(String trainId) {
        return trainChainDao.findOnceTrain(trainId);
    }


}
