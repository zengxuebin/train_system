package com.train.service;

import com.train.pojo.Train;

import java.util.List;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
public interface ISingleService {

    //单程查询:起点-终点
    List<Train> findSingleByStartAndEnd(String fromStation, String toStation);

    //单程查询:起点-过
    List<Train> findSingleByStartAndPass(String fromStation, String toStation);

    //单程查询:过-终点
    List<Train> findSingleByPassAndEnd(String fromStation, String toStation);

    //单程查询:过-过
    List<Train> findSingleBypassAndPass(String fromStation, String toStation);

    List<String> findAllFromStations(String fromStation);
}
