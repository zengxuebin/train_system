package com.train.dao;

import com.train.pojo.Train;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
@Mapper
public interface MoneyMapper {

    //单程查询:起点-终点
    List<Train> selectMoneyByStartAndEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

    //单程查询:起点-过
    List<Train> selectMoneyByStartAndPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

    //单程查询:过-终点
    List<Train> selectMoneyByPassAndEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

    //单程查询:过-终点
    List<Train> selectMoneyBypassAndPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation);

}
