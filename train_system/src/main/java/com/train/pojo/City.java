package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 城市实体类——对应t_city
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class City implements Serializable {

    //城市编号
    private int id;
    //城市名称
    private String name;
    //城市首字母
    private String firstLetter;
    //城市热度
    private int hot;

}
