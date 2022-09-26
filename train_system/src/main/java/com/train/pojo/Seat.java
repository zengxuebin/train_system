package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 座位实体类——对应t_seat
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Seat {

    //列车车次
    private String trainId;
    //商务座
    private String businessSeat;
    //一等座
    private String firstSeat;
    //二等座
    private String secondSeat;
    //软卧
    private String softSleeper;
    //硬卧
    private String hardSleeper;
    //软座
    private String softSeat;
    //硬座
    private String hardSeat;
    //无座
    private String noSeat;
    //其它
    private String other;

}
