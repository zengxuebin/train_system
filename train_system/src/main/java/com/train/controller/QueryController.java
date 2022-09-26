package com.train.controller;


import com.train.pojo.*;
import com.train.service.IQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.xml.crypto.Data;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class QueryController {

    private static final long nd = 1000 * 24 * 60 * 60;
    private static final long nh = 1000 * 60 * 60;
    private static final long nm = 1000 * 60;


    public static Date computationTime(Date startTime, Date endTime){
        try {
            long diff = endTime.getTime() - startTime.getTime();
            long day = diff / nd;
            long hour = diff % nd / nh;
            long min = diff % nd % nh / nm;
            long sec = diff % nd % nh % nm / 1000;

            //String转Date
            Date date1 = new SimpleDateFormat("HH:mm:ss").parse(hour+":"+min+":"+sec);


            return date1;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }



    //计算时间比值
    public static Double TimePercent(Date startTime, Date endTime,Date sumTime){
        try {
            long diff = endTime.getTime() - startTime.getTime();
            long hour = diff % nd / nh;
            long min = diff % nd % nh / nm;
//            long sec = diff % nd % nh % nm / 1000;
            long countSum = sumTime.getHours()*60 + sumTime.getMinutes();
            long count = 60*hour+min;

            double percent = (double) count/countSum;

            return percent;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Autowired
    private IQueryService queryService;

    @RequestMapping("query_late")//查询列车是否晚点
    @ResponseBody
    public String TimeQuery(Model model,String train_id,String station_name) {
        String msg = "列车时刻表中无" + train_id + "次列车的信息";

        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

        if (train_id != null && station_name != null){
            //查找起始站晚点信息
            if (queryService.findTrainById(train_id)!=null){
                Train train=queryService.findTrainById(train_id);
                int lateTime = train.getLateTime();
                String beginTime = sdf.format(train.getBeginTime());
                if (station_name.equals(train.getBeginStation())){
                    if (lateTime ==0){
                        msg="列车准点，" + "预计" + train_id + "次列车，" + station_name + "站的到达时间为" + beginTime;

                    }else {
                        msg="列车晚点" + lateTime + "分钟，预计" + train_id + "次列车，" + station_name + "站的到达时间为" + beginTime;

                    }
                }else if (station_name.equals(train.getEndStation())){
                    if (lateTime == 0){
                        msg="列车准点，" + "预计" + train_id + "次列车，" + station_name + "站的到达时间为" + beginTime;
                    }else {
                        msg="列车晚点" + lateTime + "分钟，预计" + train_id + "次列车，" + station_name + "站的到达时间为" + beginTime;
                    }
                }

            }

            //查找经停站晚点信息
            if (queryService.findTrainChainByTrainAndStation(train_id, station_name)!=null){
                TrainChain trainChain=queryService.findTrainChainByTrainAndStation(train_id, station_name);
                String tempBeginTime = sdf.format(trainChain.getTempBeginTime());
                if (trainChain.getLateTime()==0){
                    msg="列车准点，" + "预计" + train_id + "次列车，" + station_name + "站的到达时间为" + tempBeginTime;
                }else if (trainChain.getLateTime()==1){
                    msg="列车晚点" + trainChain.getLateTime() + "分钟，预计" + train_id + "次列车，" + station_name + "站的到达时间为" + tempBeginTime;
                }
            }
        }

        model.addAttribute("train_id", train_id);
        model.addAttribute("station_name", station_name);
        model.addAttribute("msg",msg);
        return msg;
    }


    //查询检票口信息
    @RequestMapping("front_checkIn")
    public String CheckTicketQuery(Model model,String date,String stationId,String station) throws SQLException {
        String msg="&nbsp/";

            if (stationId != null && station!=null){
                TrainChain trainChain=queryService.findTrainChainByTrainAndStation(stationId, station);
                if (trainChain==null){
                    msg = "&nbsp/";
                }else {
                    CheckTicket checkTicket = queryService.findCheckTicketById(trainChain.getCheckTicket());
                    msg=checkTicket.getName();
                }
            }

        model.addAttribute("stationId", stationId);
        model.addAttribute("station", station);
        model.addAttribute("date", date);
        model.addAttribute("msg",msg);
        return "front_checkIn";

    }


    //查询起售时间
    @RequestMapping("front_saleTime")
    public String SaleTimeQuery(Model model,String cityName, String saleDate){
        List<Station> stationList=new ArrayList<Station>();
        stationList=queryService.findStationByCityName(cityName);
        model.addAttribute("cityName", cityName);
        model.addAttribute("stationList",stationList);
        model.addAttribute("saleDate", saleDate);
        if (stationList.isEmpty()) {
            return "front_errorMoney";
        }
        return "front_saleTime";
    }



    @RequestMapping("front_schedule")
    public String scheduleQuery(Model model,String trainId,String date){
        String msg="列车时刻表中无" + trainId + "次列车的信息";
        Train train = new Train();
        List<TrainChain> trainChainList=new ArrayList<TrainChain>();
        List<String> arriveDay = new ArrayList<>();
        if (queryService.findTrainById(trainId) != null){
            train = queryService.findTrainById(trainId);
            trainChainList=queryService.findTrainChainByTrainId(trainId);
            model.addAttribute("train",train);
            model.addAttribute("trainChainList",trainChainList);
            int stationCount = 2+trainChainList.size();
            model.addAttribute("stationCount",stationCount);
            msg="当日存在该车次";

            if (train.getBeginTime().compareTo(trainChainList.get(0).getTempBeginTime())<0){
                arriveDay.add("当日到达");
            }else {
                arriveDay.add("次日到达");
            }

            for (int i =1;i<trainChainList.size();i++){
                if (trainChainList.get(i-1).getTempEndTime().compareTo(trainChainList.get(i).getTempBeginTime())<0){
                    arriveDay.add("当日到达");
                }else {
                    arriveDay.add("次日到达");
                }
            }

            if (trainChainList.get(trainChainList.size()-1).getTempEndTime().compareTo(train.getEndTime())<0){
                arriveDay.add("当日到达");
            }else {
                arriveDay.add("次日到达");
            }
        } else {
            System.out.println("error");
        }

        model.addAttribute("date", date);
        model.addAttribute("trainId", trainId);
        model.addAttribute("msg",msg);
        model.addAttribute("arriveDay",arriveDay);
        return "front_schedule";
    }

    //控制精度
    public static double Precision(double num){
        String  str = String.format("%.1f",num);
        return Double.parseDouble(str);
    }
    //计算新票价
    public static TicketMoney NewPrice(TicketMoney ticketMoney,Double percent) {
        if(ticketMoney.getBusinessSeaMoney()!=null) ticketMoney.setBusinessSeaMoney(Precision(ticketMoney.getBusinessSeaMoney()*percent));
        if(ticketMoney.getFirstSeatMoney()!=null) ticketMoney.setFirstSeatMoney(Precision(ticketMoney.getFirstSeatMoney()*percent));
        if(ticketMoney.getSecondSeatMoney()!=null) ticketMoney.setSecondSeatMoney(Precision(ticketMoney.getSecondSeatMoney()*percent));
        if(ticketMoney.getSoftSleeperMoney()!=null) ticketMoney.setSoftSleeperMoney(Precision(ticketMoney.getSoftSleeperMoney()*percent));
        if(ticketMoney.getHardSleeperMoney()!=null) ticketMoney.setHardSleeperMoney(Precision(ticketMoney.getHardSleeperMoney()*percent));
        if(ticketMoney.getSoftSeatMoney()!=null) ticketMoney.setSoftSeatMoney(Precision(ticketMoney.getSoftSeatMoney()*percent));
        if(ticketMoney.getHardSeatMoney()!=null) ticketMoney.setHardSeatMoney(Precision(ticketMoney.getHardSeatMoney()*percent));
        if(ticketMoney.getNoSeatMoney()!=null) ticketMoney.setNoSeatMoney(Precision(ticketMoney.getNoSeatMoney()*percent));
        if(ticketMoney.getNoSeatMoney()!=null) ticketMoney.setOtherMoney(Precision(ticketMoney.getNoSeatMoney()*percent));
        return ticketMoney;
    }


    //查询票价
    @RequestMapping("front_price")
    public String priceQuery(Model model,String fromPlace,String arrivePlace,String goDate){
        List<Station> fromStations= queryService.findStationByCityName(fromPlace);
        List<Station> arriveStations = queryService.findStationByCityName(arrivePlace);
        List<Train> trainList= new ArrayList<>();
        String msg = "当日无车次";
        List<String> arriveDay = new ArrayList<>();
//        double pricePercent=1.0;
        List<TicketMoney> ticketMoneyList = new ArrayList<>();

        int flag=0;

        for (int i=0;i<fromStations.size();i++){
            for (int j=0;j<arriveStations.size();j++){
                List<Train> trains = queryService.findTrainByStation(fromStations.get(i).getName(),arriveStations.get(j).getName());

                if (trains!=null){
                    for (int z=0;z<trains.size();z++) {
                        if (queryService.findTrainRunByDateAndTrainId(trains.get(z).getTrainId(), goDate) != null) {
                            if (trains.get(z).getBeginStation().equals(fromStations.get(i).getName())) {
                                if (trains.get(z).getEndStation().equals(arriveStations.get(i).getName()) == false) {
                                    TrainChain trainChain = queryService.findTrainChainByTrainAndStation(trains.get(z).getTrainId(), arriveStations.get(j).getName());
                                    double pricePercent = TimePercent(trains.get(z).getBeginTime(), trainChain.getTempBeginTime(), trains.get(z).getTimes());
                                    System.out.println();
                                    System.out.println("百分比" + pricePercent);
                                    System.out.println();

                                    trains.get(z).setEndStation(arriveStations.get(i).getName());
                                    trains.get(z).setEndTime(trainChain.getTempBeginTime());
                                    trains.get(z).setTimes(trainChain.getSumTime());
                                    TicketMoney ticketMoney = queryService.findPriceByTrainId(trains.get(z).getTrainId());

                                    if (trains.get(z).getBeginTime().compareTo(trains.get(z).getEndTime())<0){
                                        arriveDay.add("当日到达");
                                    }else {
                                        arriveDay.add("次日到达");
                                    }

                                    if (ticketMoney != null) ticketMoney = NewPrice(ticketMoney, pricePercent);
                                    ticketMoneyList.add(ticketMoney);
                                } else {
                                    TicketMoney ticketMoney = queryService.findPriceByTrainId(trains.get(z).getTrainId());
                                    ticketMoneyList.add(ticketMoney);

                                    if (trains.get(z).getBeginTime().compareTo(trains.get(z).getEndTime())<0){
                                        arriveDay.add("当日到达");
                                    }else {
                                        arriveDay.add("次日到达");
                                    }
                                }
                            } else {
                                if (trains.get(z).getEndStation().equals(arriveStations.get(i).getName())) {
                                    TrainChain trainChain = queryService.findTrainChainByTrainAndStation(trains.get(z).getTrainId(), fromStations.get(i).getName());
                                    double pricePercent = TimePercent(trainChain.getTempEndTime(), trains.get(z).getEndTime(), trains.get(z).getTimes());

                                    trains.get(z).setBeginStation(fromStations.get(i).getName());
                                    trains.get(z).setBeginTime(trainChain.getTempEndTime());

                                    Date a = QueryController.computationTime(trainChain.getTempEndTime(), trains.get(z).getEndTime());
                                    trains.get(z).setTimes(a);

                                    TicketMoney ticketMoney = queryService.findPriceByTrainId(trains.get(z).getTrainId());
                                    if (ticketMoney != null) ticketMoney = NewPrice(ticketMoney, pricePercent);
                                    ticketMoneyList.add(ticketMoney);

                                    if (trains.get(z).getBeginTime().compareTo(trains.get(z).getEndTime())<0){
                                        arriveDay.add("当日到达");
                                    }else {
                                        arriveDay.add("次日到达");
                                    }
                                } else {
                                    TrainChain trainChainFrom = queryService.findTrainChainByTrainAndStation(trains.get(z).getTrainId(), fromStations.get(i).getName());
                                    TrainChain trainChainArrive = queryService.findTrainChainByTrainAndStation(trains.get(z).getTrainId(), arriveStations.get(j).getName());
                                    double pricePercent = TimePercent(trainChainFrom.getTempEndTime(), trainChainArrive.getTempBeginTime(), trains.get(z).getTimes());

                                    trains.get(z).setBeginStation(fromStations.get(i).getName());
                                    trains.get(z).setEndStation(arriveStations.get(i).getName());

                                    trains.get(z).setBeginTime(trainChainFrom.getTempEndTime());
                                    trains.get(z).setEndTime(trainChainArrive.getTempBeginTime());

                                    Date a = QueryController.computationTime(trainChainFrom.getTempEndTime(), trainChainArrive.getTempBeginTime());
                                    trains.get(z).setTimes(a);

                                    TicketMoney ticketMoney = queryService.findPriceByTrainId(trains.get(z).getTrainId());
                                    if (ticketMoney != null) ticketMoney = NewPrice(ticketMoney, pricePercent);
                                    ticketMoneyList.add(ticketMoney);

                                    if (trains.get(z).getBeginTime().compareTo(trains.get(z).getEndTime())<0){
                                        arriveDay.add("当日到达");
                                    }else {
                                        arriveDay.add("次日到达");
                                    }
                                }
                            }
                            trains.get(z).setBeginStation(fromStations.get(i).getName());
                            trains.get(z).setEndStation(arriveStations.get(j).getName());
                            trainList.addAll(trains);
                            flag++;
                            msg = "有车次";
                        }
                    }
                }
            }
        }

        System.out.println(trainList);
        if (flag==0){
            System.out.println("test");
        }

        model.addAttribute("arriveDay",arriveDay);
        model.addAttribute("trainList",trainList);
        model.addAttribute("msg",msg);
        model.addAttribute("ticketMoneyList",ticketMoneyList);
        return "front_price";
    }

}
