package com.train.service.impl;

import com.train.dao.StationMapper;
import com.train.pojo.City;
import com.train.pojo.Station;
import com.train.service.IStationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class StationServiceImpl implements IStationService {

    @Resource
    private StationMapper stationMapper;

    public int addStation(Station station) {

        return stationMapper.addStation(station);
    }


    public int delStation(Integer id) {

        return stationMapper.delStation(id);
    }

    @Override
    public List<Station> findAllStation() {
        return stationMapper.selectAllStation();
    }

    @Override
    public List<City> findAllCityName() {
        return stationMapper.selectAllCityName();
    }

    @Override
    public List<Station> findStationByCondition(String stationName, String cityName) {
        return stationMapper.selectStationByCondition(stationName, cityName);
    }
}
