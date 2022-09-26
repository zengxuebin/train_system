<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/17
  Time: 7:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        起售时间查询页面
    --%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/startTime.css">
    <style>
        ul {
            padding: 0;
        }

        .content {
            width: 1190px;
            margin: 0 auto;
            min-height: 700px;
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

            let saleDate = $("#saleDate").val();

            if (saleDate == "") {
                $("#saleDate").attr({
                    "value" : startDate,
                    "min" : startDate,
                    "max" : addDate()
                });
            } else {
                $("#saleDate").attr({
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
                <a class="nav_a" href="schedule">时刻表查询</a>
            </li>
            <li class="nav_item">
                <a class="nav_a" href="checkIn">检票口查询</a>
            </li>
            <li class="nav_item">
                <a class="nav_a active" href="saleTime">起售时间查询</a>
            </li>
        </ul>
    </div>
</div>

<div class="content">
    <div class="main_box">
        <div class="box_hd">
            <span>起售时间</span>
        </div>

        <div class="box_bd">
            <!-- 搜索条件 -->
            <div class="search_box">
                <form action="front_saleTime" method="post">
                    <div class="row g-3 align-items-center">
                        <!-- 起售时间 -->
                        <div class="col-auto">
                            <b style="color: red;">*</b>
                            <label for="saleDate" class="col-form-label">起售日期</label>
                        </div>
                        <div class="col-auto">
                            <input type="date" id="saleDate" name="saleDate" value="${saleDate}" class="form-control">
                        </div>
                        <!-- 起售车站 -->
                        <div class="col-auto">
                            <b style="color: red;">*</b>
                            <label for="saleStation" class="col-form-label">起售车站</label>
                        </div>
                        <div class="col-auto">
                            <input type="text" id="saleStation" name="cityName" class="form-control"
                                   placeholder="请输入车站名称" value="${cityName}" required>
                        </div>
                        <div class="col-auto" style="padding-left: 50px;">
                            <button type="submit" class="btn btn-primary"  id="select_btn">查&nbsp;&nbsp;询</button>
                        </div>
                    </div>
                </form>
            </div>


            <!-- 结果展示 -->
            <div class="sale_box">
                <ul class="sale_list">
                    <c:forEach items="${stationList}" var="station">
                        <li>
                            <div class="sale_station">
                                <div>${station.name}站</div>
                            </div>
                            <div class="sale_time">
                                <div>
                                        <fmt:formatDate value="${station.ticketStartSell}" pattern="HH:mm"/>
                                    <span>起售</span>
                                </div>
                            </div>
                        </li>
                    </c:forEach>

                </ul>
            </div>

            <div style="clear: both;"></div>
        </div>
    </div>

    <!-- 提示 -->
    <div class="tips_box">
        <h6>温馨提示：</h6>
        <p>1、查询结果仅供参考，准确信息以车站公告为准。</p>
        <p>2、车站根据实际情况，可能调整起售时间和止售时间。</p>
    </div>
</div>
<!-- 页脚 -->
<div class="footer">
    <p>实训1班2组</p>
    <p>本前端页面提供：曾聆聆</p>
</div>
</body>
</html>
