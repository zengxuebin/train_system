package com.train.service.impl;

import com.train.dao.TransferMapper;
import com.train.pojo.Transfer;
import com.train.service.ITransferService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
@Service
public class TransferServiceImpl implements ITransferService {

    @Autowired
    private TransferMapper transferMapper;

    @Override
    public List<Transfer> findTransferByStartEndAndStartEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartEndAndStartEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByStartEndAndPassEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartEndAndPassEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByStartEndAndStartPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartEndAndStartPass(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByStartEndAndPassPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartEndAndPassPass(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByStartPassAndStartEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartPassAndStartEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByStartPassAndStartPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartPassAndStartPass(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByStartPassAndPassEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartPassAndPassEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByStartPassAndPassPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByStartPassAndPassPass(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferBySassEndAndStartEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferBySassEndAndStartEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByPassEndAndStartPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByPassEndAndStartPass(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByPassEndAndPassEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByPassEndAndPassEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByPassEndAndPassPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByPassEndAndPassPass(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByPassPassAndStartEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByPassPassAndStartEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByPassPassAndStartPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByPassPassAndStartPass(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByPassPassAndPassEnd(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByPassPassAndPassEnd(fromStation, toStation, transferStation);
    }

    @Override
    public List<Transfer> findTransferByPassPassAndPassPass(String fromStation, String toStation, String transferStation) {
        return transferMapper.selectTransferByPassPassAndPassPass(fromStation, toStation, transferStation);
    }

}
