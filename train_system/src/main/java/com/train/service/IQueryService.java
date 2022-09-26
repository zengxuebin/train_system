package com.train.service;

import com.train.pojo.*;

import java.util.List;

public interface IQueryService {

    Train findTrainById(String train_id);

    //寻找列车经过站信息
    TrainChain findTrainChainByTrainAndStation(String train_id,String station_name);

    //通过检票口编号，查找检票口信息
    CheckTicket findCheckTicketById(String id);

    //查找列车运行图
    TrainRun findTrainRunByDateAndTrainId(String id,String date);

    //查找车站
    List<Station> findStationByCityName(String cityName);

    //寻找列车经过站信息
    List<TrainChain> findTrainChainByTrainId(String train_id);

    //通过起始站点名查找车次
    List<Train> findTrainByBeginStationName(String stationName);

    //通过终点站名查找车次
    List<Train> findTrainByEndStationName(String stationName);

    //通过站点找到车次
    List<Train> findTrainByStation(String beginStationName,String endStationName);

    //通过车次找票价
    TicketMoney findPriceByTrainId(String trainId);
}
