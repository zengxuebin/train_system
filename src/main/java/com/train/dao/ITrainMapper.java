package com.train.dao;

import com.train.pojo.Train;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ITrainMapper {
    //列车信息增删改查
    List<Train> findAllTrains();
    Train findTrainById(String trainId);
    int addTrain(Train train);
    int updateTrain(Train train);
    int deleteTrainById(String trainId);



}
