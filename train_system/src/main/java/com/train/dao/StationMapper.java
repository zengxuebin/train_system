package com.train.dao;

import com.train.pojo.City;
import com.train.pojo.Station;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StationMapper {


    //添加
    int addStation(Station station);

    //删除
    int delStation(Integer id);


    List<Station> selectAllStation();

    List<City> selectAllCityName();

    List<Station> selectStationByCondition(@Param("stationName") String stationName,
                                           @Param("cityName") String cityName);
}
