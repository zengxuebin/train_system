package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 列车运行时间类——t_train_run
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class TrainRun {

    private String trainId;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date runDate;
    private String note;

}
