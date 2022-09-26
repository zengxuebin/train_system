package com.train.dao;

import com.train.pojo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface QueryMapper {
    Train findTrainById(String train_id);

    TrainChain findTrainChainByTrainAndStation(@Param("train_id") String train_id,@Param("station_name") String station_name);

    CheckTicket findCheckTicketById(String id);

    TrainRun findTrainRunByDateAndTrainId(@Param("id") String id,@Param("date") String date);

    List<Station> findStationByCityName(String cityName);

    List<TrainChain> findTrainChainByTrainId(String train_id);

    List<Train> findTrainByBeginStationName(String stationName);

    List<Train> findTrainByEndStationName(String stationName);

    List<String> findTrainIdByBeginStationName(String stationName);

    List<String> findTrainIdByEndStationName(String stationName);

  /*  //在train_chain中通过起始站找列车id
    List<String> findTrainIdInChainByBeginStationName(String stationName);
    //在train_chain中通过终止站找列车id
    List<String> findTrainIdInChainByEndStationName(String stationName);*/

    List<TrainChain> findTrainChainByStation(String stationName);

    TicketMoney findPriceByTrainId(String trainId);
}
