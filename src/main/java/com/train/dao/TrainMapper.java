package com.train.dao;

import com.train.pojo.Train;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * @author:曾雪斌
 * @Description:单程查询
 * @History:
 */
@Mapper
public interface TrainMapper {

    //单程查询:起点-终点
    List<Train> selectSingleByStartAndEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

    //单程查询:起点-过
    List<Train> selectSingleByStartAndPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

    //单程查询:过-终点
    List<Train> selectSingleByPassAndEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

    //单程查询:过-终点
    List<Train> selectSingleBypassAndPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

    List<String> selectAllFromStations(String fromStation);
}
