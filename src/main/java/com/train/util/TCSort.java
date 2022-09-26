package com.train.util;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import com.train.pojo.TrainChain;
public class TCSort {

    public static List<TrainChain> TCSort(List<TrainChain> list){
        int len=list.size();
        for (int i=1;i<len;i++){
            for (int j=0;j<len-1;j++){
                if (list.get(j).getTempBeginTime()==null){
                    continue;
                }else if (list.get(j+1).getTempBeginTime()==null){
                    Collections.swap(list,j,j+1);
                }else if ((list.get(j).getTempBeginTime().compareTo(list.get(j+1).getTempBeginTime())==1
                        &&list.get(j).getTempBeginDays()>=list.get(j+1).getTempBeginDays())
                        ||list.get(j).getTempBeginDays()>list.get(j+1).getTempBeginDays()){//使用Date类中自带的.compareTo比较先后，返回值为int
                    Collections.swap(list,j,j+1);//调换元素位置
                }

            }
        }
        return list;
    }
    public static String TCUsetime(Date d1,Date d2){//发车，到达
        if (d2!=null){
            int h1=d1.getHours();
            int m1=d1.getMinutes();
            int h2=d2.getHours();
            int m2=d2.getMinutes();
            int h,m;
            if(d1.compareTo(d2)==1){
                h=h1-h2;
                if(m1<m2){
                    h--;
                    m=60-(m2-m1);
                }else {
                    m=m1-m2;
                }
            }else {
                h=h2-h1;
                if(m2<m1){
                    h--;
                    m=60-(m1-m2);
                }else {
                    m=m2-m1;
                }
            }
            String str=h+":"+m+":"+0;
            return str;
        }else {
            return null;
        }
    }


}
