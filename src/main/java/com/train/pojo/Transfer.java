package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author:曾雪斌
 * @Description:
 * @History:
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Transfer {

    //第一趟列车
    private Train firstTrain;
    //第二趟列车
    private Train secondTrain;
    //中转时间
    @DateTimeFormat(pattern = "HH:mm:ss")
    private Date transferTime;
    //总历时
    @DateTimeFormat(pattern = "HH:mm:ss")
    private Date sumTimes;

    /**
     * 1始
     * 2过
     * 3终
     */
    private int flagFirstTrainFromStation;
    private int flagFirstTrainToStation;
    private int flagSecondTrainFromStation;
    private int flagSecondTrainToStation;

}
