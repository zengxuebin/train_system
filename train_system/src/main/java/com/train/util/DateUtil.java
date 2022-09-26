package com.train.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @author:曾雪斌
 * @Description:已知日期求星期
 * @History:
 */
public class DateUtil {
    private DateUtil() {
    }

    public static String dateToWeek(Date date) {
        String[] weekDays = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        //一周的第几天
        int week = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (week < 0)
            week = 0;
        return weekDays[week];
    }
}
