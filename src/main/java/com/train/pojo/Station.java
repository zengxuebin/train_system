package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 车站实体类——对应t_station
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Station implements Serializable {

    //车站编号
    private int id;
    //车站名称
    private String name;
    //城市名称
    private String cityName;
    //开售时间
    @DateTimeFormat(pattern = "HH:mm")
    private Date ticketStartSell;

}
