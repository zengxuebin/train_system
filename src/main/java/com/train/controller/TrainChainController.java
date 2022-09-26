package com.train.controller;

import com.train.pojo.*;
import com.train.service.ITrainChainService;
import com.train.util.TCSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class TrainChainController {
    @Autowired
    private ITrainChainService ITrainChainService;
    private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

    @RequestMapping(value="/findAllTrain",method = RequestMethod.GET)
    @ResponseBody
    public List<Train> findAllTrain(){//查询所有现有车次,用于下拉框选择
        List<Train> train= ITrainChainService.findAllTrain();
        System.out.println("/////////////////"+train.toString());
        return train;
    }

    @RequestMapping(value="/findAllStation",method = RequestMethod.GET)
    @ResponseBody
    public List<Station> findAllStation(){//查询所有车站，用于下拉框筛选
        List<Station> stations= ITrainChainService.findAllStation();
        return stations;
    }
    @RequestMapping(value="/findAllTicketByName/{name}",method = RequestMethod.GET)
    @ResponseBody
    public List<CheckTicket> findAllTicketByName(@PathVariable String name){//查询所有车站，用于下拉框筛选
        List<CheckTicket> checkTickets= ITrainChainService.findCTByStationName(name);
        System.out.println("/////tbt//////////tbt/////////////////tbt///////////tbt////////////");
        System.out.println("/////tbt//////////tbt/////////////////tbt///////////tbt////////////");
        System.out.println(checkTickets);
        System.out.println("/////tbt//////////tbt/////////////////tbt///////////tbt////////////");
        System.out.println("/////tbt//////////tbt/////////////////tbt///////////tbt////////////");
        System.out.println("/////tbt//////////tbt/////////////////tbt///////////tbt////////////");

        return checkTickets;
    }
    @RequestMapping(value="/findAllTCById/{trainId}",method = RequestMethod.GET)
    @ResponseBody
    public List<TrainChain> findAllTCById(@PathVariable String trainId){//根据车次号查询所有经停站
        List<TrainChain> trainChains= ITrainChainService.findAllTC(trainId);
        CheckTicket checkTicket;
        for (int i=0;i<trainChains.size();i++){
            if (trainChains.get(i).getCheckTicketId()!=null){
                checkTicket= ITrainChainService.findCTById(trainChains.get(i).getCheckTicketId());
                trainChains.get(i).setCheckTicket(checkTicket.getName());
            }
        }
        return trainChains;
    }

    @RequestMapping(value="/addTC",method = RequestMethod.POST)
    @ResponseBody
    public Msg addTC(int day, String tbt, String tet, String trainId, TrainChain trainChain1) throws ParseException {//添加经停站
        Msg msg=new Msg();
        int flag = 0;
        TrainChain tc = new TrainChain();
        //处理检票口信息
        if(trainChain1.getCheckTicket()!=""){
            //根据name和车站号查检票口id
            trainChain1.setCheckTicketId(ITrainChainService.findCTByname(trainChain1).getCheckTicketId());
        }

        if (tbt == ""||tet == ""){
            msg.setMsg("到达时间或发车时间不可为空！！！");
        }else {
            List<TrainChain> list = ITrainChainService.findAllTC(trainId);//获取该车次所有经停站信息
            for (int i=0;i<list.size();i++){//判断输入站点名称是否已存在
                int TC1=list.get(i).getStationName().hashCode();
                int TC2= trainChain1.getStationName().hashCode();
                if (TC1 ==TC2){//比较站点名称的hashCode
                    msg.setCode(400);
                    msg.setMsg("该站点已存在");
                    break;
                }
            }
            System.out.println("/////////fored");
            System.out.println(msg.getCode());
            if (msg.getCode()!=400){//站点不存在

                //Date数据处理
                Date tbtdate = sdf.parse(tbt);
                trainChain1.setTempBeginTime(tbtdate);

                Date tetdate = sdf.parse(tet);
                trainChain1.setTempEndTime(tetdate);
                if (list.size() != 0) {
                    //获取最后一个经停站信息
                    tc = list.get(list.size() - 1);
                    Date d1=tc.getTempEndTime();
                    Date d2=tbtdate;
                    Date d3=tc.getSumTime();
                    int h1=d1.getHours();
                    int m1=d1.getMinutes();
                    int h2=d2.getHours();
                    int m2=d2.getMinutes();
                    int h3=d3.getHours();
                    int m3=d3.getMinutes();
                    int h,m;
                    if(d1.compareTo(d2)==1){
                        h=h1-h2;
                        if(m1<m2){
                            h--;
                            m=60-(m2-m1);
                        }else {m=m1-m2;}
                    }else {
                        h=h2-h1;
                        if(m2<m1){
                            h--;
                            m=60-(m1-m2);
                        }else {m=m2-m1;}
                    }
                    h1=(m+m3)/60;
                    m=(m+m3)%60;
                    h=h+h3+h1;
                    String str=h+":"+m;
                    Date stdate = sdf.parse(str);
                    trainChain1.setSumTime(stdate);
                }else {
                    //第一个经停站
                    Train firsttc= ITrainChainService.findOnceTrain(trainId);
                    Date d1=firsttc.getBeginTime();
                    Date d2=tbtdate;
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
                        }else {m=m1-m2;}
                    }else {
                        h=h2-h1;
                        if(m2<m1){
                            h--;
                            m=60-(m1-m2);
                        }else {m=m2-m1;}
                    }
                    String str=h+":"+m;
                    Date stdate = sdf.parse(str);
                    trainChain1.setSumTime(stdate);
                }
                if (list.size() == 0) {//起始站
                    trainChain1.setTempBeginDays(0);//初始化新增站时间信息
                    flag = ITrainChainService.addTC(trainChain1);
                } else {
                    //判断是否符合添加数据要求
                    if (day == 0) {//当日到达
                        trainChain1.setTempBeginDays(tc.getTempBeginDays());
                        if (tc.getTempEndTime().compareTo(tbtdate) == -1) {//时间正确
                            flag = ITrainChainService.addTC(trainChain1);
                        }else {
                            msg.setMsg("到达时间冲突请重试");
                        }
                    } else {//次日到达
                        trainChain1.setTempBeginDays(tc.getTempBeginDays() + 1);
                        flag = ITrainChainService.addTC(trainChain1);
                    }
                }
            }
        }
        if (flag != 0) {
            msg.setCode(200);
            msg.setMsg("添加成功");
        } else if (msg.getMsg()==null){
            msg.setMsg("添加失败");
        }
        return msg;
    }

    @RequestMapping(value="/toSet/{id}",method = RequestMethod.GET)
    @ResponseBody
    public List<TrainChain> findAllTCById(@PathVariable int id){//打开修改模态框时获取原内容
        List<TrainChain> list = ITrainChainService.findOnceTC(id);
        CheckTicket checkTicket;
        for (int i=0;i<list.size();i++){
            if (list.get(i).getCheckTicketId()!=null){
                checkTicket= ITrainChainService.findCTById(list.get(i).getCheckTicketId());
                list.get(i).setCheckTicket(checkTicket.getName());
            }
        }
        return list;
    }

    @RequestMapping(value="/setTC",method = RequestMethod.POST )
    @ResponseBody
    public Msg findAllTCById(int id,int flag,TrainChain trainChain) throws ParseException {//修改经停站信息，

        trainChain.setId(id);//设置修改操作目标id
        List<TrainChain> trainChain3= ITrainChainService.findOnceTC(id);

        trainChain.setStationName(trainChain3.get(0).getStationName());
        //处理检票口信息
        if(trainChain.getCheckTicket()!=""){
            //根据name和车站号查检票口id
            trainChain.setCheckTicketId(ITrainChainService.findCTByname(trainChain).getCheckTicketId());
        }
        ITrainChainService.setTC(trainChain);//修改操作
        if (flag==1){//复用晚点信息

            List<TrainChain> list = ITrainChainService.findAllTC(trainChain.getTrainId());//获取该车次所有经停站信息

            int found=0;
            for (int i=0;i<list.size();i++){
                System.out.println("list["+i+"]");
                TrainChain trainChain2=list.get(i);
                if (trainChain2.getId()==id){//找到当前页面站点并标记
                    System.out.println("///");
                    found=1;
                }else if (found == 1){
                    trainChain2.setLateTime(trainChain.getLateTime());
                    ITrainChainService.setTCLate(trainChain2);
                }
            }
        }
        return Msg.success();
    }

    @RequestMapping(value="/deleteTC/{id}",method = RequestMethod.POST)
    @ResponseBody
    public Msg deleteTC(@PathVariable int id,HttpServletResponse response){//根据id删除站点
        int flag = ITrainChainService.deleteTC(id);
        Msg msg = new Msg();
        if (flag==0){
            msg.setMsg("删除失败，请重试！");
        }else {
            msg.setMsg("删除成功！");
        }
        return msg;
    }
}
