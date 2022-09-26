package com.train.dao;

import com.train.pojo.Transfer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author:曾雪斌
 * @Description:往返查询
 * @History:
 */
@Mapper
public interface TransferMapper {
    List<Transfer> selectTransferByStartEndAndStartEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByStartEndAndPassEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByStartEndAndStartPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByStartEndAndPassPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByStartPassAndStartEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByStartPassAndStartPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByStartPassAndPassEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByStartPassAndPassPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferBySassEndAndStartEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByPassEndAndStartPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByPassEndAndPassEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByPassEndAndPassPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByPassPassAndStartEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByPassPassAndStartPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByPassPassAndPassEnd(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);

    List<Transfer> selectTransferByPassPassAndPassPass(
            @Param("fromStation") String fromStation,
            @Param("toStation") String toStation,
            @Param("transferStation") String transferStation);
}
