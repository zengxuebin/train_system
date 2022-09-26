<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/17
  Time: 1:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        首页
    --%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">
    <script src="https://cdn.staticfile.org/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(function (){
            //交换出发站和到达站
            $("#icon_city_swap").click(function() {
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

            $("#goDate").attr({
                "value" : startDate,
                "min" : startDate,
                "max" : addDate()
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
                <a class="nav_a active" href="index">首页</a>
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
                <a class="nav_a" href="saleTime">起售时间查询</a>
            </li>
        </ul>
    </div>
</div>

<!-- 搜索轮播图 -->
<div class="section_first">
    <!-- 轮播图 -->
    <div id="bg_box" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#bg_box" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#bg_box" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#bg_box" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active" data-bs-interval="2000">
                <img src="./img/banner.jpg" class="d-block h-100" alt="...">
            </div>
            <div class="carousel-item" data-bs-interval="2000">
                <img src="./img/banner2.png" class="d-block h-100" alt="...">
            </div>
            <div class="carousel-item" data-bs-interval="2000">
                <img src="./img/banner3.png" class="d-block h-100" alt="...">
            </div>
        </div>
    </div>
    <!-- 车票查询 -->
    <div class="search_index">
        <form action="searchSingle" method="post">
            <div class="mb-3">
                <label for="fromStation" class="form-label">出发地</label>
                <div class="input_box">
                    <input type="text" class="form-control" id="fromStation" name="fromStation" placeholder="请输入出发地名称" required>
                    <i class="bi bi-geo-alt-fill icon_palce" style="top: 10px"></i>
                </div>
            </div>
            <div class="mb-3">
                <label for="toStation" class="form-label">到达地</label>
                <div class="input_box">
                    <input type="text" class="form-control" id="toStation" name="toStation" placeholder="请输入到达地名称" required>
                    <i class="bi bi-geo-alt-fill icon_palce" style="top: 10px"></i>
                </div>
            </div>
            <div class="city_swap">
                <i class="bi bi-arrow-down-up" id="icon_city_swap"></i>
            </div>
            <div class="mb-3">
                <label for="goDate" class="form-label">出发日期</label>
                <input type="date" class="form-control" id="goDate" name="goDate" required>
            </div>
            <button type="submit" class="btn btn-primary btn_search">查询车票</button>
        </form>
    </div>
</div>

<div class="wrapper">
    <!-- 更多功能 -->
    <ul class="menu_list">
        <li id="menu_border">
            <a href="#" class="menu_href">
                <i class="bi bi-bank2 menu_icon"></i>
                <div>热门城市</div>
            </a>
        </li>
        <li>
            <a href="#" class="menu_href">
                <i class="bi bi-chat-text-fill menu_icon"></i>
                <div>用户反馈</div>
            </a>
        </li>
    </ul>
    <!-- 用户反馈 -->
    <div class="advice_tab">
        <div class="tab_hd">
            <ul>
                <li class="active">
                    <a href="javascript:void(0)">版本公告</a>
                </li>
                <li>
                    <a href="javascript:void(0)">用户反馈</a>
                </li>
            </ul>
        </div>
        <div class="tab_hd">
            <!-- 版本公告 -->
            <div class="tab_item" style="display: block;">
                <div class="advice_index">

                </div>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <p>实训1班2组</p>
    <p>本前端页面提供：罗宇豪&nbsp;|&nbsp;曾雪斌</p>
</div>
</body>
</html>
