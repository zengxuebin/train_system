package com.train.service;

import com.train.pojo.Train;

import java.util.List;

public interface ITrainService {
    //列车信息增删改查
    List<Train> findAllTrains();
    Train findTrainById(String trainId);
    int updateTrain(Train train);
    int  addTrain(Train train);
    int deleteTrainById(String trainId);



}
