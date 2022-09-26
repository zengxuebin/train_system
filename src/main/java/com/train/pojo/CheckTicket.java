package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 检票口实体类——对应t_check_ticket
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class CheckTicket {

    //检票口名称
    private String name;
    //车站名称
    private String stationName;

}
