<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/17
  Time: 7:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        单程查询页面
    --%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/result.css">
    <script src="https://cdn.staticfile.org/jquery/3.6.0/jquery.min.js"></script>
    <style>
        .content {
            width: 1190px;
            margin: 0 auto;
            min-height: 700px;
        }
    </style>
    <script>
        $(function (){
            //交换出发站和到达站
            $(".swap_icon").click(function() {
                let fromStation = $("#fromStation").val();
                let toStation = $("#toStation").val();
                let temp = fromStation;
                $("#fromStation").val(toStation);
                $("#toStation").val(temp);
            });

            //获取当前时间
            function nowDate() {
                let now = new Date();
                let m = now.getMonth() + 1 < 10 ? "0" +(now.getMonth() + 1) : now.getMonth() + 1;
                let day = now.getDate() < 10 ? "0" + now.getDate() : now.getDate();
                return now.getFullYear() + '-' + m + '-'+ day;
            }

            let startDate = nowDate();

            function addDate() {
                let d = new Date();
                d.setDate(d.getDate() + 15);
                let m = d.getMonth() + 1 < 10 ? "0" +(d.getMonth() + 1) : d.getMonth() + 1;
                let day = d.getDate() < 10 ? "0" + d.getDate() : d.getDate();
                return d.getFullYear() + '-' + m + '-'+ day;
            }

            let goDate = $("#goDate").val();

            if (goDate == "") {
                $("#goDate").attr({
                    "value" : startDate,
                    "min" : startDate,
                    "max" : addDate()
                });
            } else {
                $("#goDate").attr({
                    "min" : startDate,
                    "max" : addDate()
                });
            }

            $(".radio_station").click(function() {
                let selected = $("input[name='radioStation']:checked").val();
                $("table tbody tr").hide().filter(":contains('"+(selected )+"')").map(function(){
                    if ($(".beginStation").text() === selected) {
                        return this;
                    }
                }).show();
            });

        })
    </script>
</head>
<body>
<!-- 头部 -->
<div class="header">
    <div class="wrapper">
        <!-- 头部内容 -->
        <div class="header_con">
            <h1 class="logo">
                <a href="index">
                    <img src="./img/logo1.png" height="48px"/>
                </a>
            </h1>
            <div class="header_right">
                <!-- 搜索条 -->
                <div class="header_search">
                    <div class="search_bd">
                        <input type="text" class="search_input" placeholder="搜索车票">
                        <a class="search_btn" href="#">
                            <img src="./img/search.png" height="29px">
                        </a>
                    </div>
                </div>
                <!-- 管理员登录 -->
                <span class="menu_item">欢迎使列车车次查询系统！如果您是<strong>管理员</strong>，请在此处
                            <a class="login" href="toLogin">登录</a>
                        </span>
            </div>
        </div>
    </div>

    <!-- 导航栏 -->
    <div class="nav_box">
        <ul class="nav">
            <li class="nav_item">
                <a class="nav_a" href="index">首页</a>
            </li>
            <li class="nav_item">
                <a class="nav_a dropdown-toggle active" href="javascript:void(0);" data-bs-toggle="dropdown">车票查询</a>
                <ul class="dropdown-menu nav_ticket" style="width: 180px;">
                    <li><a class="dropdown-item" href="singleResult">单程查询</a></li>
                    <li><a class="dropdown-item" href="roundResult">往返查询</a></li>
                    <li><a class="dropdown-item" href="transfer">中转换乘查询</a></li>
                </ul>
            </li>
            <li class="nav_item">
                <a class="nav_a" href="price">票价查询</a>
            </li>
            <li class="nav_item">
                <a class="nav_a" href="late">正晚点查询</a>
            </li>
            <li class="nav_item">
                <a class="nav_a" href="schedule">时刻表查询</a>
            </li>
            <li class="nav_item">
                <a class="nav_a" href="checkIn">检票口查询</a>
            </li>
            <li class="nav_item">
                <a class="nav_a" href="saleTime">起售时间查询</a>
            </li>
        </ul>
    </div>
</div>

<div class="content">
    <!-- 车票搜索框 -->
    <div class="search_box">
        <form action="searchSingle" method="post">
            <div class="row g-3 align-items-center">
                <span class="col-auto">单程查询</span>
                <!-- 出发地 -->
                <div class="col-auto">
                    <label for="fromStation" class="col-form-label">出发地</label>
                </div>
                <div class="col-auto">
                    <input type="text" id="fromStation" name="fromStation" class="form-control"
                           placeholder="请输入出发地名称" value="${fromStation}" required>
                </div>
                <div class="col-auto">
                    <i class="bi bi-arrow-left-right swap_icon"></i>
                </div>
                <!-- 到达地 -->
                <div class="col-auto">
                    <label for="toStation" class="col-form-label">到达地</label>
                </div>
                <div class="col-auto">
                    <input type="text" id="toStation" name="toStation"  class="form-control"
                           placeholder="请输入到达地名称" value="${toStation}" required>
                </div>
                <!-- 出发日期 -->
                <div class="col-auto">
                    <label for="goDate" class="col-form-label">出发日期</label>
                </div>
                <div class="col-auto">
                    <input type="date" id="goDate" name="goDate" class="form-control"
                           value="<fmt:formatDate value="${goDate}" pattern="yyyy-MM-dd"/>">
                </div>
                <div class="col-auto">
                    <span style="padding: 0;margin: 0;">&nbsp;</span>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary"  id="select_btn">查询</button>
                </div>
            </div>
        </form>
    </div>

    <!-- 检索条件 -->
    <div class="search_con">
        <div class="search_con_bd">
            <div class="section_hd">列车类型：</div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="all" name="typeTrain" value="高铁" checked>
                <label class="form-check-label" for="all">全部</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="G" name="typeTrain" value="高铁">
                <label class="form-check-label" for="G">G-高铁</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="D" name="typeTrain" value="动车">
                <label class="form-check-label" for="D">D-动车</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="Z" name="typeTrain" value="直达">
                <label class="form-check-label" for="Z">Z-直达</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="T" name="typeTrain" value="动车">
                <label class="form-check-label" for="T">T-特快</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="K" name="typeTrain" value="动车">
                <label class="form-check-label" for="K">K-快速</label>
            </div>
            <div class="form-check">
                <input type="radio" class="form-check-input" id="other" name="typeTrain" value="其它">
                <label class="form-check-label" for="other">其它</label>
            </div>
        </div>
        <div class="search_con_bd">
            <div class="section_hd" style="clear: both;">出发车站：</div>
            <div class="form-check">
                <input type="radio" class="form-check-input radio_station" id="radio0"
                       name="radioStation" value="" checked>
                <label class="form-check-label" for="radio0">全部</label>
            </div>
            <c:forEach items="${stations}" var="station" varStatus="status">
                <div class="form-check">
                    <input type="radio" class="form-check-input radio_station" id="radio${status.index + 1}"
                           name="radioStation" value="${station}">
                    <label class="form-check-label" for="radio${status.index + 1}">${station}</label>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 结果统计 -->
    <div class="search_result">
        <c:if test="${not empty fromStation}">
        <p>
            <strong>${fromStation}-->${toStation}（
                <fmt:formatDate value="${goDate}" pattern="MM月dd日"/>&nbsp;&nbsp;
                ${goWeek}
                ）</strong>
            共计
            <strong>${trainCount}</strong>
            个车次
        </p>
        </c:if>
    </div>

    <!-- 结果展示 -->
    <div class="t_list">
        <table class="table table-sm table-bordered table-hover table-striped" style="border-color: #b0cedd;table-layout: fixed;">
            <thead class="t_head" style="vertical-align:middle;">
            <tr>
                <th scope="col">车次</th>
                <th scope="col">出发站<br>到达站</th>
                <th scope="col">
                    <span class="order">出发时间<i class="bi bi-caret-up-fill"></i></span>
                    <br>
                    <span class="order">到达时间<i class="bi bi-caret-down-fill"></i></span>
                </th>
                <th scope="col">
                    <span class="order">历时<i class="bi bi-caret-up-fill" id="times_sort" style="color: #f18934"></i></span>
                </th>
                <th scope="col">商务座</th>
                <th scope="col">一等座</th>
                <th scope="col">二等座</th>
                <th scope="col">软卧</th>
                <th scope="col">硬卧</th>
                <th scope="col">软座</th>
                <th scope="col">硬座</th>
                <th scope="col">无座</th>
                <th scope="col">备注</th>
            </tr>
            </thead>
            <tbody style="vertical-align:middle; font-size: 14px;">
            <c:forEach items="${singleTrainList}" var="train">
                <tr style="text-align: center;">
                    <th scope="row">${train.trainId}</th>
                    <td style="text-align: left">
                        <strong>
                            <c:if test="${train.flag == 1 || train.flag == 2}">
                                <span class="flag" style="background-color: #008D83">始</span>
                            </c:if>
                            <c:if test="${train.flag == 3 || train.flag == 4}">
                                <span class="flag" style="background-color: #845EC2">过</span>
                            </c:if>
                            <span class="beginStation">${train.beginStation}</span></strong>
                        <br>
                        <strong>
                            <c:if test="${train.flag == 1 || train.flag == 3}">
                                <span class="flag" style="background-color: #936C00">终</span>
                            </c:if>
                            <c:if test="${train.flag == 2 || train.flag == 4}">
                                <span class="flag" style="background-color: #845EC2">过</span>
                            </c:if>
                            ${train.endStation}</strong>
                    </td>
                    <td>
                        <strong><fmt:formatDate value="${train.beginTime}" pattern="HH:mm"/></strong>
                        <br>
                        <strong style="color: #999;"><fmt:formatDate value="${train.endTime}" pattern="HH:mm"/></strong>
                    </td>
                    <td>
                        <strong><fmt:formatDate value="${train.times}" pattern="HH:mm"/></strong>
                        <br>
                        <span style="color: #999;">当日到达</span>
                    </td>
                    <td>
                        <c:if test="${train.seat.businessSeat == 0}">
                            <span style="color: #f80;">候补</span>
                        </c:if>
                        <c:if test="${empty train.seat.businessSeat}">
                            --
                        </c:if>
                        <c:if test="${train.seat.businessSeat < 20 && train.seat.businessSeat > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.businessSeat}</span>
                        </c:if>
                        <c:if test="${train.seat.businessSeat >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${train.seat.firstSeat == 0}">
                            <span style="color: #f80;">候补</span>
                        </c:if>
                        <c:if test="${empty train.seat.firstSeat}">
                            --
                        </c:if>
                        <c:if test="${train.seat.firstSeat < 20 && train.seat.firstSeat > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.firstSeat}</span>
                        </c:if>
                        <c:if test="${train.seat.firstSeat >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${train.seat.secondSeat == 0}">
                            <span style="color: #f80;">候补</span>
                        </c:if>
                        <c:if test="${empty train.seat.secondSeat}">
                            --
                        </c:if>
                        <c:if test="${train.seat.secondSeat < 20 && train.seat.secondSeat > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.secondSeat}</span>
                        </c:if>
                        <c:if test="${train.seat.secondSeat >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${train.seat.softSleeper == 0}">
                            <span style="color: #f80;">候补</span>
                        </c:if>
                        <c:if test="${empty train.seat.softSleeper}">
                            --
                        </c:if>
                        <c:if test="${train.seat.softSleeper < 20 && train.seat.softSleeper > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.softSleeper}</span>
                        </c:if>
                        <c:if test="${train.seat.softSleeper >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${train.seat.hardSleeper == 0}">
                            <span style="color: #f80;">候补</span>
                        </c:if>
                        <c:if test="${empty train.seat.hardSleeper}">
                            --
                        </c:if>
                        <c:if test="${train.seat.hardSleeper < 20 && train.seat.hardSleeper > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.hardSleeper}</span>
                        </c:if>
                        <c:if test="${train.seat.hardSleeper >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${train.seat.softSeat == 0}">
                            <span style="color: #f80;">候补</span>
                        </c:if>
                        <c:if test="${empty train.seat.softSeat}">
                            --
                        </c:if>
                        <c:if test="${train.seat.softSeat < 20 && train.seat.softSeat > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.softSeat}</span>
                        </c:if>
                        <c:if test="${train.seat.softSeat >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${train.seat.hardSeat == 0}">
                            <span style="color: #f80;">候补</span>
                        </c:if>
                        <c:if test="${empty train.seat.hardSeat}">
                            --
                        </c:if>
                        <c:if test="${train.seat.hardSeat < 20 && train.seat.hardSeat > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.hardSeat}</span>
                        </c:if>
                        <c:if test="${train.seat.hardSeat >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${train.seat.noSeat == 0}">
                            <span style="color: #999;">无</span>
                        </c:if>
                        <c:if test="${empty train.seat.noSeat}">
                            --
                        </c:if>
                        <c:if test="${train.seat.noSeat < 20 && train.seat.noSeat > 0}">
                            <span style="color: #333;font-weight: 700">${train.seat.noSeat}</span>
                        </c:if>
                        <c:if test="${train.seat.noSeat >= 20}">
                            <span style="color: #26a306;">有</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${empty train.seat.other}">
                            --
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="tips_box">
            <p>如果查询结果中没有满足需求的车次，您还可以使用
                <a href="#">中转换乘</a>
                功能，查询途中换乘一次的部分列车余票情况。</p>
            <p>以上查询结果仅供参考，具体以车站为准！</p>
        </div>
    </div>
</div>
<div class="footer">
    <p>实训1班2组</p>
    <p>本前端页面提供：罗宇豪&nbsp;|&nbsp;曾雪斌</p>
</div>
</body>
</html>
