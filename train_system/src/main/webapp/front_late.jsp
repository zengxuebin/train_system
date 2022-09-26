<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/17
  Time: 7:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        正晚点查询页面
    --%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/late.css">
    <style>
        .content {
            min-height: 720px;
        }
        .modal-body i {
            font-size: 60px;
            float: left;
            margin-right: 30px;
            display: block;
            color: #ff8201;
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

            $("#select_btn").click(function () {
                let station_name = $("#station_name").val();
                let train_id = $("#train_id").val();
                $.ajax({
                    url: "query_late",
                    type: "post",
                    data: {
                        station_name : station_name,
                        train_id : train_id
                    },
                    success: function (msg) {
                        $("#result").modal("show");
                        $(".modal-body span").text(msg);
                    }
                })
            })

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
                <a class="nav_a active" href="late">正晚点查询</a>
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
    <div class="line"></div>

    <div class="late_box">
        <ul>
            <li>
                        <span class="label">
                            <b>*</b>
                            车站
                        </span>
                <div class="input">
                    <input type="text" class="form-control mt-3" id="station_name" value="${station_name}"
                           placeholder="请输入车站名称" required>
                </div>
            </li>
            <li>
                        <span class="label">
                            <b>*</b>
                            车次
                        </span>
                <div class="input">
                    <input type="text" class="form-control mt-3" id="train_id" value="${train_id}"
                           placeholder="请输入车次编号" required>
                </div>
            </li>
        </ul>
        <div class="btn_box">
            <button type="submit" class="btn btn-primary" id="select_btn">查&nbsp;&nbsp;询</button>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="result" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">列车正晚点信息</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <i class="bi bi-exclamation-circle"></i>
                    <span></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">确认</button>
                </div>
            </div>
        </div>
    </div>


    <!-- 温馨提示 -->
    <div class="tips_box">
        <h6>温馨提示：</h6>
        <p>1.本查询提供未来24小时内列车正晚点信息。</p>
        <p>2.车站输入时不用加“站”，例如“南昌西站”应输入“南昌西”。</p>
        <p>3.本功能及查询结果仅作为参考，准确信息以车站公告为准。</p>
    </div>

</div>


<div class="footer">
    <p>实训1班2组</p>
    <p>本前端页面提供：曾聆聆</p>
</div>
</body>
</html>
