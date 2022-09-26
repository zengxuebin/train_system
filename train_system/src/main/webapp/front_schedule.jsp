<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/17
  Time: 7:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        时刻表查询页面
    --%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/result.css">
    <style>
        .content {
            width: 700px;
            margin: 0 auto;
            min-height: 700px;
        }
        .search_box {
            margin-top: 40px;
        }
    </style>
    <script src="https://cdn.staticfile.org/jquery/3.6.0/jquery.min.js"></script>
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
                <a class="nav_a dropdown-toggle" href="javascript:void(0);" data-bs-toggle="dropdown">车票查询</a>
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
                <a class="nav_a active" href="schedule">时刻表查询</a>
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

<!-- 主体 -->
<div class="content">
    <!-- 搜索框 -->
    <div class="search_box">
        <form action="front_schedule" method="post">
            <div class="row g-3 align-items-center">
                <!-- 日期 -->
                <div class="col-auto">
                    <b style="color: red;">*</b>
                    <label for="goDate" class="col-form-label">日期</label>
                </div>
                <div class="col-auto">
                    <input type="date" id="goDate" name="date" class="form-control"
                    value="${date}">
                </div>
                <!-- 车次 -->
                <div class="col-auto">
                    <label for="stationId" class="col-form-label">车次</label>
                </div>
                <div class="col-auto">
                    <input type="text" id="stationId" class="form-control" name="trainId"
                           placeholder="请输入车次编号" value="${trainId}" required>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary"  id="select_btn">查询</button>
                </div>
            </div>
        </form>
    </div>

    <!-- 结果展示 -->
    <c:choose>
        <c:when test="${msg  eq  '当日存在该车次'}"><!-- 如果 -->
            <div class="search_result">
                <p>
                    <strong>${train.trainId}</strong>
                    次列车（高速 有空调），始发站：
                    <strong>${train.beginStation}</strong>
                    ；终点站：
                    <strong>${train.endStation}</strong>
                    ；全程共有
                    <strong>${stationCount}</strong>
                    个停靠站：
                </p>
            </div>
            <div class="t_list">
                <table class="table table-sm table-bordered table-hover table-striped" style="border-color: #b0cedd;table-layout: fixed;">
                    <thead class="t_head" style="vertical-align:middle;">
                    <tr>
                        <th scope="col">站序</th>
                        <th scope="col">车站</th>
                        <th scope="col">车次</th>
                        <th scope="col">出发时间</th>
                        <th scope="col">到达时间</th>
                        <th scope="col">历时</th>
                    </tr>
                    </thead>
                    <tbody style="vertical-align:middle; font-size: 14px;">
                    <tr style="text-align: center; height: 45px; font-weight: 700">
                        <th scope="row">${i=1}</th>
                        <td>
                                ${train.beginStation}
                        </td>
                        <td>
                                ${train.trainId}
                        </td>
                        <td>
                            <strong>
                                <fmt:formatDate value="${train.beginTime}" pattern="HH:mm"/>
                            </strong>
                        </td>
                        <td>
                            <strong>
                                ----
                            </strong>
                        </td>
                        <td>
                            <strong>
                                ----
                            </strong>
                            <br>
                                <%--                    <span style="color: #999;">当日到达</span>--%>
                        </td>
                    </tr>
                    <c:forEach items="${trainChainList}" var="trainChain" varStatus="s">
                        <tr style="text-align: center; height: 45px; font-weight: 700">
                            <th scope="row">${s.count+1}</th>
                            <td>
                                    ${trainChain.stationName}
                            </td>
                            <td>
                                    ${trainChain.trainId}
                            </td>
                            <td>
                                <strong>
<%--                                        ${trainChain.tempBeginTime}--%>
                                        <fmt:formatDate value="${trainChain.tempBeginTime}" pattern="HH:mm"/>
                                    <c:if test="${empty trainChain.tempBeginTime}">
                                        ----
                                    </c:if>
                                </strong>
                            </td>
                            <td>
                                <strong>
<%--                                        ${trainChain.tempEndTime}--%>
                                        <fmt:formatDate value="${trainChain.tempEndTime}" pattern="HH:mm"/>
                                        <c:if test="${empty trainChain.tempEndTime}">
                                            ----
                                        </c:if>
                                </strong>
                            </td>
                            <td>
                                <strong>
<%--                                        ${trainChain.sumTime}--%>
                                        <fmt:formatDate value="${trainChain.sumTime}" pattern="HH:mm"/>
                                        <c:if test="${empty trainChain.sumTime}">
                                            ----
                                        </c:if>
                                </strong>
                                <br>
                                <c:if test="${not empty trainChain.sumTime}">
                                    <span style="color: #999;">${arriveDay[s.count-1]}</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr style="text-align: center; font-weight: 700">
                        <th scope="row">${stationCount}</th>
                        <td>
                                ${train.endStation}
                        </td>
                        <td>
                                ${train.trainId}
                        </td>
                        <td>
                            <strong>
                                ----
                            </strong>
                        </td>
                        <td>
                            <strong>
                                    <fmt:formatDate value="${train.endTime}" pattern="HH:mm"/>
                            </strong>
                        </td>
                        <td>
                            <strong>
                                    <fmt:formatDate value="${train.times}" pattern="HH:mm"/>
                            </strong>
                            <br>
                            <span style="color: #999;">${arriveDay[stationCount-2]}</span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </c:when>

        <c:otherwise> <!-- 否则 -->
            <span style="color: red;line-height: 60px;font-size: 20px;">${msg}</span>
        </c:otherwise>
    </c:choose>


</div>

<!-- 页脚 -->
<div class="footer">
    <p>实训1班2组</p>
    <p>本前端页面提供：曾聆聆</p>
</div>
</body>
</html>
