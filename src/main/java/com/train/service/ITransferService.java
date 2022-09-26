package com.train.service;

import com.train.pojo.Transfer;

import java.util.List;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
public interface ITransferService {
    List<Transfer> findTransferByStartEndAndStartEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByStartEndAndPassEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByStartEndAndStartPass(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByStartEndAndPassPass(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByStartPassAndStartEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByStartPassAndStartPass(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByStartPassAndPassEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByStartPassAndPassPass(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferBySassEndAndStartEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByPassEndAndStartPass(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByPassEndAndPassEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByPassEndAndPassPass(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByPassPassAndStartEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByPassPassAndStartPass(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByPassPassAndPassEnd(String fromStation, String toStation, String transferStation);

    List<Transfer> findTransferByPassPassAndPassPass(String fromStation, String toStation, String transferStation);
}
