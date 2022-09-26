package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 票价实体类——对应t_train
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Train {

    //列车车次
    private String trainId;
    //列车类型
    private String trainType;
    //始发站
    private String beginStation;
    //终点站
    private String endStation;
    //发车时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date beginTime;
    //到达时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endTime;
    //历时
    @DateTimeFormat(pattern = "HH:mm:ss")
    private Date times;
    //正晚点
    private Integer lateTime;
    //备注（例如有空调等）
    private String note;
    //检票口
    private String checkTicket;

    //票价
    private TicketMoney ticketMoney;

    //座位
    private Seat seat;

    //运行时间
    private TrainRun trainRun;

    /**
     * 1:起点-终点
     * 2:起点-过
     * 3:过-终点
     * 4:过-过
     */
    private int flag;
}
