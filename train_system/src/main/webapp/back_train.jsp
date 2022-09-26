<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>管理员后台</title>
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/train.css">
    <link rel="stylesheet" href="fonts/iconfont.css">
</head>
<!-- 这里是列车管理 -->
<body>
<!-- navbar-->
<header class="header">

    <nav class="navbar bg-white shadow">
        <img src="./img/logo2.png" height="42px"/>
        <h1 class="navbar-brand font-weight-bold" style="font-size: 30px">
            欢迎${sessionScope.admin.username}使用后台管理系统</h1>
    </nav>

</header>
<div class="d-flex align-items-stretch">
    <!-- sidebar -->
    <div id="sidebar" class="sidebar py-3">
        <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">MAIN
        </div>

        <ul class="sidebar-menu list-unstyled">
            <li class="sidebar-list-item"><a href="queryAllStation?page=1" class="sidebar-link text-muted">
                <i class="iconfont text-gray icon1">&#xe626;</i><span>车站管理</span></a></li>
            <li class="sidebar-list-item"><a href="back_trainId.jsp" class="sidebar-link text-muted">
                <i class="iconfont text-gray icon1">&#xe65d;</i><span>车次管理</span></a></li>

            <li class="sidebar-list-item"><a href="trainList" class="sidebar-link text-muted active">
                <i class="iconfont text-gray icon1">&#xe65a;</i><span>列车管理</span></a></li>

            <li class="sidebar-list-item"><a href="back_login.jsp" class="sidebar-link text-muted">
                <i class="iconfont text-gray icon1">&#xe68e;</i><span>切换账户</span></a>
            </li>
        </ul>

        <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family"></div>

    </div>

    <div class="page-holder w-100 d-flex flex-wrap">
        <div class="container-fluid px-xl-5">
            <section class="py-5">

                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="h4 text-uppercase mb-0">列车管理</h6>
                        </div>
                        <div class="card-body">

                            <div class="form-group">

                                <!-- 查询 -->
                                <input id="selectTrainId" value="">
                                <a class="btn btn-primary iconfont text-white" id="select" href="">&#xe656;</a>
                                <!-- 增加 -->
                                <a class="btn btn-primary iconfont text-white" data-toggle="modal" href='#insert'>&#xe8c0;</a>
                                <div class="modal fade" id="insert">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">增加列车</h4>
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-hidden="true">&times;
                                                </button>
                                            </div>
                                            <!-- 提交表单 -->
                                            <form action="addTrain">
                                                <div class="modal-body">
                                                    <!-- 这里后端填想要增加的内容 -->


                                                    列车车次:<input type="text" name="trainId" class="form-control"><br>
                                                    列车类型:<input type="text" name="trainType" class="form-control"><br>
                                                    始发站:<input type="text" name="beginStation" class="form-control"><br>
                                                    终点站:<input type="text" name="endStation" class="form-control"><br>

                                                    发车时间 :<input type="text" name="bt" class="form-control"> <br/>
                                                    到达时间 :<input type="text" name="et" class="form-control"> <br/>
                                                    历时 :<input type="text" name="tim" class="form-control"> <br/>

                                                    正晚点: <input type="text" name="lateTime" class="form-control"><br>

                                                    检票口:<input type="text" name="checkTicket" class="form-control"><br>
                                                    备注:<input type="text" name="note" class="form-control"><br>


                                                </div>
                                                <div class="modal-footer">
                                                    <input type="submit" class="btn btn-success" value="保存" onclick=alert("添加成功")>
                                                    <a href="#" class="btn btn-danger" data-dismiss="modal">关闭</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <table id="table" class="table table-striped table-sm card-text">
                                <thead>
                                <tr>
                                    <th>列车车次</th>
                                    <th>列车类型</th>
                                    <th>始发站</th>
                                    <th>终点站</th>
                                    <th>发车时间</th>
                                    <th>到达时间</th>
                                    <th>历时</th>
                                    <th>正晚点</th>

                                    <th>检票口</th>
                                    <th>备注</th>

                                </tr>

                                </thead>
                                <tbody id="tbody">


                                <c:forEach items="${trainList}" var="Train">
                                    <tr id="${Train.trainId}">

                                        <td>${Train.trainId}</td>
                                        <td>${Train.trainType}</td>
                                        <td>${Train.beginStation}</td>
                                        <td>${Train.endStation}</td>

                                        <td><fmt:formatDate value="${Train.beginTime}" pattern="HH:mm:ss"/></td>
                                        <td><fmt:formatDate value="${Train.endTime}" pattern="HH:mm:ss"/></td>
                                        <td><fmt:formatDate value="${Train.times}" pattern="HH:mm:ss"/></td>

                                        <td>${Train.lateTime}</td>
                                        <td>${Train.checkTicket}</td>
                                        <td>${Train.note}</td>


                                        <td>
                                            <!-- 修改 -->
                                            <a id="toset" class="btn btn-primary iconfont text-white"
                                               data-toggle="modal" value="${Train.trainId}"
                                               href="#update">&#xe8cf;</a>

                                            <div class="modal fade" id="update">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title">修改</h4>
                                                            <button type="button" class="close" data-dismiss="modal"
                                                                    aria-hidden="true">&times;
                                                            </button>
                                                        </div>
                                                        <form action="updateTrain">
                                                            <div class="modal-body">
                                                                <!-- 这里后端填想要修改的内容,记得加上form-control -->

                                                                列车车次 :<input id="trainId" type="text" name="trainId"
                                                                             value="${train.trainId}"
                                                                             class="form-control"> <br/>
                                                                列车类型 :<input id="trainType" type="text" name="trainType"
                                                                             value="${train.trainType}"
                                                                             class="form-control"> <br/>

                                                                始发站 :<input id="beginStation" type="text"
                                                                            name="beginStation"
                                                                            value="${train.beginStation}"
                                                                            class="form-control"> <br/>
                                                                终点站 :<input id="endStation" type="text"
                                                                            name="endStation"
                                                                            value="${train.endStation}"
                                                                            class="form-control"> <br/>

                                                                发车时间 :<input id="beginTime" type="text" name="bt"
                                                                             class="form-control"
                                                                <fmt:formatDate value="${train.beginTime}"
                                                                                pattern="HH:mm"/>> <br/>
                                                                到达时间 :<input id="endTime" type="text" name="et"
                                                                             class="form-control"
                                                                <fmt:formatDate value="${train.endTime}"
                                                                                pattern="HH:mm"/> > <br/>
                                                                历时 :<input id="times" type="text" name="tim"
                                                                           class="form-control"
                                                                <fmt:formatDate value="${train.times}"
                                                                                pattern="HH:mm"/>> <br/>


                                                                正晚点:<input id="lateTime" type="text" name="lateTime"
                                                                           value="${train.lateTime}"
                                                                           class="form-control"> <br/>

                                                                检票口 :<input id="checkTicket" type="text"
                                                                            name="checkTicket"
                                                                            value="${train.checkTicket}"
                                                                            class="form-control"> <br/>
                                                                备注 :<input id="note" type="text" name="note"
                                                                           value="${train.note}"
                                                                           class="form-control"> <br/>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <input type="submit" class="btn btn-success" value="保存" onclick=alert("修改成功!")>
                                                                <a href="#" class="btn btn-danger" data-dismiss="modal">关闭</a>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 删除 -->
                                            <a class="btn btn-primary iconfont text-white"
                                               href="delete/${Train.trainId}" onclick=alert("删除成功！")>&#xe74b;</a>
                                        </td>

                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </section>
        </div>
    </div>
</div>


<!-- JavaScript files-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    //格式转换函数
    Date.prototype.Format = function (fmt) {
        let o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (let k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };
    $(document).on("click", "#select", function () {
        var sel=document.getElementById("selectTrainId")
        var tid=sel.value;
        var selected=document.getElementById(tid)
        if(selected.innerHTML!=""){
            var tbody=document.getElementById("tbody")
            tbody.prepend(selected)
        }
        return false//阻止刷新
    })
    $(document).on("click", "#toset", function () {
        var id = $(this).attr("value");
        var tid=document.getElementById("trainId")
        var ttype=document.getElementById("trainType")
        var beginS=document.getElementById("beginStation")
        var endS=document.getElementById("endStation")

        var beginTime=document.getElementById("beginTime")
        var endTime=document.getElementById("endTime")
        var times=document.getElementById("times")

        var lateTime=document.getElementById("lateTime")
        var note=document.getElementById("note")
        var checkTicket=document.getElementById("checkTicket")

        var btStr="";
        var etStr="";
        var utStr="";

        $.ajax({
            url: "http://localhost:8080/trainSystem_war/toUpdateTrain/" + id,
            type: "GET",
            async: false,//关闭异步
            success: function (result) {
                if (result.beginTime != null) {
                    obj = new Date(result.beginTime);
                    btStr = obj.Format("hh:mm");
                } else {
                    btStr = "--";
                }
                if (result.endTime != null) {
                    obj = new Date(result.endTime);
                    etStr = obj.Format("hh:mm");
                } else {
                    etStr = "--";
                }
                if (result.times != null) {
                    obj = new Date(result.times);
                    utStr = obj.Format("hh:mm");
                } else {
                    utStr = "--";
                }
                tid.setAttribute("value",result.trainId)
                ttype.setAttribute("value",result.trainType)
                beginS.setAttribute("value",result.beginStation)
                endS.setAttribute("value",result.endStation)

                beginTime.setAttribute("value", btStr)
                endTime.setAttribute("value",etStr)
                times.setAttribute("value",utStr)

                lateTime.setAttribute("value",result.lateTime)
                note.setAttribute("value",result.note)
                checkTicket.setAttribute("value",result.checkTicket)

            },

        });
    })

</script>
</body>
</html>