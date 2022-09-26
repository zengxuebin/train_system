package com.train.service;

import com.train.pojo.City;
import com.train.pojo.Station;

import java.util.List;

public interface IStationService {

    //添加
    int addStation(Station userInfo);

    //删除
    int delStation(Integer id);

    List<Station> findAllStation();

    List<City> findAllCityName();

    List<Station> findStationByCondition(String stationName, String cityName);
}
