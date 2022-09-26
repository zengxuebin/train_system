package com.train.dao;

import com.train.pojo.CheckTicket;
import com.train.pojo.Station;
import com.train.pojo.Train;
import com.train.pojo.TrainChain;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TrainChainMapper {
    public List<TrainChain> findAllTC(String trainId);//TC=TrainChain

    int addTC(TrainChain trainChain);
    int setTC(TrainChain trainChain);
    int setTCLate(TrainChain trainChain);
    List<TrainChain> findOnceTC(int id);
    int deleteTC(int id);


    //Dao临时内容，后期根据等效代码替换
    List<Train> findAllTrain();
    Train findOnceTrain(String trainId);
    List<Station> findAllStation();

    CheckTicket findCTById(int id);
    TrainChain findCTByname(TrainChain trainChain);
    List<CheckTicket> findCTByStationName(String name);


}
