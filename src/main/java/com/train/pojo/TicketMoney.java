package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 票价实体类——对应t_ticket_money
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class TicketMoney {

    //列车车次
    private String trainType;
    //商务座价格
    private Double businessSeaMoney;
    //一等座价格
    private Double firstSeatMoney;
    //二等座价格
    private Double secondSeatMoney;
    //软卧价格
    private Double softSleeperMoney;
    //硬卧价格
    private Double hardSleeperMoney;
    //软座价格
    private Double softSeatMoney;
    //硬座价格
    private Double hardSeatMoney;
    //无座价格
    private Double noSeatMoney;
    //其它价格
    private Double otherMoney;

}
