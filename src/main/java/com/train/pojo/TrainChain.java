package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 列车时刻实体类——对应t_train_chain(t_train_time改为t_train_chain)
 * 中间站
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class TrainChain {

    //序号
    private int id;
    //列车车次
    private String trainId;
    //到达站名称
    private String stationName;
    //到达时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date tempBeginTime;
    //离开（发车）时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date tempEndTime;
    //列车发车到该站时间
    @DateTimeFormat(pattern = "hh:mm:ss")
    private Date sumTime;
    //列车检票口
    private String CheckTicket;
    //列车正晚点
    private Integer lateTime;
    //票价
    private Double ticketMoney;

    private Integer checkTicketId;

    private Integer tempBeginDays;

    private int flag;
}
