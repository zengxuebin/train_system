package com.train.service;

import com.train.pojo.CheckTicket;
import com.train.pojo.Station;
import com.train.pojo.Train;
import com.train.pojo.TrainChain;

import java.util.List;

public interface ITrainChainService {
    List<TrainChain> findAllTC(String trainId);//TC=TrainChain
    int addTC(TrainChain trainChain);


    int setTC(TrainChain trainChain);
    int setTCLate(TrainChain trainChain);
    List<TrainChain> findOnceTC(int id);
    int deleteTC(int id);

    //Dao临时内容，后期根据等效代码替换
    List<Train> findAllTrain();
    List<Station> findAllStation();
    CheckTicket findCTById(int id);
    TrainChain findCTByname(TrainChain trainChain);
    List<CheckTicket> findCTByStationName(String name);
    public Train findOnceTrain(String trainId);
}
