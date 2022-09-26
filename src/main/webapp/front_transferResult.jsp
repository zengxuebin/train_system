<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/19
  Time: 20:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        中转换乘页面
    --%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/result.css">
    <link rel="stylesheet" href="./css/transfer.css">
    <script src="https://cdn.staticfile.org/jquery/3.6.0/jquery.min.js"></script>
    <style>
        .content {
            width: 1000px;
            min-height: 700px;
            margin: 0 auto;
        }
    </style>
    <script>
        $(function (){

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
    <!-- 搜索框 -->
    <div class="search_box" style="height: auto;">
        <form action="searchTransfer" method="post">
            <div class="row g-3 align-items-center">
                <!-- 出发地 -->
                <div class="col-auto">
                    <b style="color: red;">*</b>
                    <label for="fromStation" class="col-form-label">出发地</label>
                </div>
                <div class="col-auto">
                    <input type="text" id="fromStation" class="form-control" value="${fromStation}"
                           name="fromStation" placeholder="请输入出发地名称" required>
                </div>
                <!-- 目的地 -->
                <div class="col-auto">
                    <b style="color: red;">*</b>
                    <label for="toStation" class="col-form-label">目的地</label>
                </div>
                <div class="col-auto">
                    <input type="text" id="toStation" class="form-control" value="${toStation}"
                           name="toStation" placeholder="请输入到达地名称" required>
                </div>
                <!-- 乘车日期 -->
                <div class="col-auto">
                    <b style="color: red;">*</b>
                    <label for="goDate" class="col-form-label">乘车日期</label>
                </div>
                <div class="col-auto">
                    <input type="date" id="goDate" class="form-control" name="goDate"
                           value="<fmt:formatDate value="${goDate}" pattern="yyyy-MM-dd"/>" placeholder="请输入乘车日期">
                </div>
                <div class="col-auto" style="padding-left: 5px;">
                    <button type="submit" class="btn btn-primary"  id="select_btn">查&nbsp;&nbsp;询</button>
                </div>
            </div>
            <div class="row g-3 align-items-center">
                <!-- 出发地 -->
                <div class="col-auto" style="padding: 5px 12px;">
                    <label for="transferStation" class="col-form-label">指定换乘站</label>
                </div>
                <div class="col-auto" style="padding: 5px 3px;">
                    <input type="text" id="transferStation" class="form-control" placeholder="可选：输入换乘站">
                </div>
            </div>
        </form>
        <div class="transfer_tips">
            <p>温馨提示：以下仅为您展示途中换乘一次的部分列车余票信息，且为同站换乘，您也可以通过指定换乘站来缩小换乘的范围。注意，指定换乘站是可选的。</p>
        </div>
    </div>

    <!-- 搜索结果 -->
    <div class="transfer_search_res" style="margin-bottom: 10px;">
        <c:if test="${not empty fromStation}">
        <p>
            搜索结果：
            <strong>${fromStation}</strong>
            ->
            <strong>${toStation}</strong>
            ，以下共有<strong>${trainCount}</strong>个搜索结果
        </p>
        </c:if>
    </div>

    <!-- 结果展示 -->
    <div class="t_list">
        <table class="table table-sm table-bordered" style="border-color: #b0cedd;">
            <thead class="t_head" style="vertical-align:middle;">
            <tr>
                <th scope="col">车次</th>
                <th scope="col">出发站<br>到达站</th>
                <th scope="col">
                    <span class="order">出发时间</span>
                    <br>
                    <span class="order">到达时间</span>
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
            <tbody style="vertical-align:middle; font-size: 14px;" id="result_table">
            <c:forEach items="${transferTrainList}" var="train" varStatus="status">
            <c:if test="${status.index % 2 == 0}">
                <tr style="background: #eef1f8;">
            </c:if>
            <c:if test="${status.index % 2 != 0}">
                <tr>
            </c:if>
                <td colspan="12">
                    <table class="transfer_table">
                        <tbody>
                        <tr>
                            <td width="20px">
                                <div class="train_no">${status.index + 1}</div>
                            </td>
                            <td>
                                <span style="font-weight: 700;font-size: 16px;">${train.firstTrain.beginStation}</span>
                                <span style="color: #666;">
                                    <fmt:formatDate value="${train.firstTrain.beginTime}" pattern="H:mm"/>开
                                </span>
                            </td>
                            <td>
                                <div class="transfer_time">
                                    <span>${train.firstTrain.trainId}</span>
                                    <span>
                                        <fmt:formatDate value="${train.firstTrain.times}" pattern="H小时mm分"/>
                                    </span>
                                </div>
                            </td>
                            <td>
                                <span style="color: #666;">
                                    <fmt:formatDate value="${train.firstTrain.endTime}" pattern="H:mm"/>到
                                </span>
                            </td>
                            <td class="transfer_mid">
                                <div style="font-weight: 700;">${train.firstTrain.endStation}</div>
                                <div>
                                    接续时间：
                                    <fmt:formatDate value="${train.transferTime}" pattern="H小时mm分"/>
                                </div>
                            </td>
                            <td>
                                <span style="color: #666;">
                                    <fmt:formatDate value="${train.secondTrain.beginTime}" pattern="H:mm"/>开
                                </span>
                            </td>
                            <td>
                                <div class="transfer_time">
                                    <span>
                                        ${train.secondTrain.trainId}
                                    </span>
                                    <span>
                                        <fmt:formatDate value="${train.secondTrain.times}" pattern="H小时mm分"/>
                                    </span>
                                </div>
                            </td>
                            <td>
                                <span style="color: #666;">
                                    <fmt:formatDate value="${train.secondTrain.endTime}" pattern="H:mm"/>到
                                </span>
                            </td>
                            <td style="width: auto;text-align: center">
                                <div style="font-weight: 700;font-size: 16px;">${train.secondTrain.endStation}</div>
                            </td>
                            <td class="transfer_mid">
                                <span class="color: #666;">总历时：</span>
                                <span style="color:#fb7403;font-weight: bold;">
                                    <fmt:formatDate value="${train.sumTimes}" pattern="H小时mm分"/>
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <c:if test="${status.index % 2 == 0}">
                <tr style="text-align: center;background: #eef1f8;">
            </c:if>
            <c:if test="${status.index % 2 != 0}">
                <tr style="text-align: center;">
            </c:if>
                <th scope="row">${train.firstTrain.trainId}</th>
                <td style="text-align: left;width: 100px">
                    <strong>
                        <c:if test="${train.flagFirstTrainFromStation == 1}">
                            <span class="flag" style="background-color: #008D83">始</span>
                        </c:if>
                        <c:if test="${train.flagFirstTrainFromStation == 2}">
                            <span class="flag" style="background-color: #845EC2">过</span>
                        </c:if>
                        <c:if test="${train.flagFirstTrainFromStation == 3}">
                            <span class="flag" style="background-color: #936C00">终</span>
                        </c:if>
                        ${train.firstTrain.beginStation}
                    </strong>
                    <br>
                    <strong>
                        <c:if test="${train.flagFirstTrainToStation == 1}">
                            <span class="flag" style="background-color: #008D83">始</span>
                        </c:if>
                        <c:if test="${train.flagFirstTrainToStation == 2}">
                            <span class="flag" style="background-color: #845EC2">过</span>
                        </c:if>
                        <c:if test="${train.flagFirstTrainToStation == 3}">
                            <span class="flag" style="background-color: #936C00">终</span>
                        </c:if>
                        ${train.firstTrain.endStation}</strong>
                </td>
                <td>
                    <strong>
                        <fmt:formatDate value="${train.firstTrain.beginTime}" pattern="H:mm"/>
                    </strong>
                    <br>
                    <strong style="color: #999;">
                        <fmt:formatDate value="${train.firstTrain.endTime}" pattern="H:mm"/>
                    </strong>
                </td>
                <td>
                    <span style="color: #999;">无</span>
                </td>
                <td><span style="color: #f80;">候补</span> </td>
                <td><span style="color: #26a306;">有</span> </td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
            </tr>
            <c:if test="${status.index % 2 == 0}">
                <tr style="text-align: center;background: #eef1f8;">
            </c:if>
            <c:if test="${status.index % 2 != 0}">
                <tr style="text-align: center;">
            </c:if>
                <th scope="row">${train.secondTrain.trainId}</th>
                <td style="text-align: left;width: 100px">
                    <strong>
                        <c:if test="${train.flagSecondTrainFromStation == 1}">
                            <span class="flag" style="background-color: #008D83">始</span>
                        </c:if>
                        <c:if test="${train.flagSecondTrainFromStation == 2}">
                            <span class="flag" style="background-color: #845EC2">过</span>
                        </c:if>
                        <c:if test="${train.flagSecondTrainFromStation == 3}">
                            <span class="flag" style="background-color: #936C00">终</span>
                        </c:if>
                            ${train.secondTrain.beginStation}
                    </strong>
                    <br>
                    <strong>
                        <c:if test="${train.flagSecondTrainToStation == 1}">
                            <span class="flag" style="background-color: #008D83">始</span>
                        </c:if>
                        <c:if test="${train.flagSecondTrainToStation == 2}">
                            <span class="flag" style="background-color: #845EC2">过</span>
                        </c:if>
                        <c:if test="${train.flagSecondTrainToStation == 3}">
                            <span class="flag" style="background-color: #936C00">终</span>
                        </c:if>
                            ${train.secondTrain.endStation}</strong>
                </td>
                <td>
                    <strong>
                        <fmt:formatDate value="${train.secondTrain.beginTime}" pattern="H:mm"/>
                    </strong>
                    <br>
                    <strong style="color: #999;">
                        <fmt:formatDate value="${train.secondTrain.endTime}" pattern="H:mm"/>
                    </strong>
                </td>
                <td>
                    <span style="color: #999;">无</span>
                </td>
                <td><span style="color: #f80;">候补</span> </td>
                <td><span style="color: #26a306;">有</span> </td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="footer">
    <p>实训1班2组</p>
    <p>本前端页面提供：罗宇豪&nbsp;|&nbsp;曾雪斌</p>
</div>
</body>
</html>
