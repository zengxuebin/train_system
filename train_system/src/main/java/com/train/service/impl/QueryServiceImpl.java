package com.train.service.impl;

import com.train.dao.QueryMapper;
import com.train.pojo.*;
import com.train.service.IQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class QueryServiceImpl implements IQueryService {
    @Autowired
    private QueryMapper queryMapper;

    @Override
    public Train findTrainById(String train_id) {
        return queryMapper.findTrainById(train_id);
    }

    @Override
    public TrainChain findTrainChainByTrainAndStation(String train_id, String station_name) {
        return queryMapper.findTrainChainByTrainAndStation(train_id,station_name);
    }

    @Override
    public CheckTicket findCheckTicketById(String id) {
        return queryMapper.findCheckTicketById(id);
    }

    @Override
    public TrainRun findTrainRunByDateAndTrainId(String id, String date) {
        return queryMapper.findTrainRunByDateAndTrainId(id,date);
    }

    @Override
    public List<Station> findStationByCityName(String cityName) {
        return queryMapper.findStationByCityName(cityName);
    }

    @Override
    public List<TrainChain> findTrainChainByTrainId(String train_id) {
        return queryMapper.findTrainChainByTrainId(train_id);
    }

    @Override
    public List<Train> findTrainByBeginStationName(String stationName) {
        return queryMapper.findTrainByBeginStationName(stationName);
    }

    @Override
    public List<Train> findTrainByEndStationName(String stationName) {
        return queryMapper.findTrainByEndStationName(stationName);
    }

    @Override
    public List<Train> findTrainByStation(String beginStationName, String endStationName) {

        List<String> TrainIds = new ArrayList<String>();
        TrainIds.add("0");
        //查找终点站车次
        List<String> FromTrainIds = queryMapper.findTrainIdByBeginStationName(beginStationName);
        List<String> ArriveTrainIds =queryMapper.findTrainIdByEndStationName(endStationName);
        //查找途径站车次
        List<TrainChain> FromTrainChains = queryMapper.findTrainChainByStation(beginStationName);
        List<TrainChain> ArriveTrainChains = queryMapper.findTrainChainByStation(endStationName);

        //将目的地为途径站的车次添加
        if (FromTrainChains.size()==0){
            for (int i=0;i<ArriveTrainChains.size();i++){
                ArriveTrainIds.add(ArriveTrainChains.get(i).getTrainId());
            }
        }

        //将出发地为途径站的车次添加
        if (ArriveTrainChains.size()==0){
            for (int j=0;j<FromTrainChains.size();j++){
                FromTrainIds.add(FromTrainChains.get(j).getTrainId());
            }
        }

        //添加出发站到达站均为途径站的车次
        for (int i=0;i<FromTrainChains.size();i++){
            for (int j=0;j<ArriveTrainChains.size();j++){
                if (FromTrainChains.get(i).getTrainId().equals(ArriveTrainChains.get(j).getTrainId())){
                    if (FromTrainChains.get(i).getTempBeginTime().compareTo(ArriveTrainChains.get(j).getTempBeginTime())<0){
                        FromTrainIds.add(FromTrainChains.get(i).getTrainId());
                        ArriveTrainIds.add(ArriveTrainChains.get(j).getTrainId());
                    }
                }else {
                    FromTrainIds.add(FromTrainChains.get(i).getTrainId());
                    ArriveTrainIds.add(ArriveTrainChains.get(j).getTrainId());
                }
            }
        }

        //判断可用车次
        for (int i=0;i<FromTrainIds.size();i++){
            for (int j=0;j<ArriveTrainIds.size();j++){
                if (FromTrainIds.get(i).equals(ArriveTrainIds.get(j))){
                    TrainIds.add(FromTrainIds.get(i));
                }
            }
        }

        //查找车辆信息
        List<Train> Trains = new ArrayList<Train>();
        int flag=0;
        for (int i=1;i<TrainIds.size();i++){
            Train train=queryMapper.findTrainById(TrainIds.get(i));
    /*        if (train.getBeginStation().equals(beginStationName)){
                if (train.getEndStation().equals(endStationName)==false){
                    TrainChain trainChain = queryMapper.findTrainChainByTrainAndStation(train.getTrainId(),endStationName);
                    train.setEndStation(endStationName);
                    train.setEndTime(trainChain.getTempBeginTime());
//                    train.setTimes(trainChain.getSumTime());
                }
            }*/

            Trains.add(train);
            flag++;
        }

        if (flag!=0){
            return Trains;
        }else {
            return null;
        }

    }

    @Override
    public TicketMoney findPriceByTrainId(String trainId) {
        return queryMapper.findPriceByTrainId(trainId);
    }
}
