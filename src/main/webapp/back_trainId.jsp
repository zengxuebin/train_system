<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/20
  Time: 7:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        车站管理
    --%>
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/train.css">
    <link rel="stylesheet" href="fonts/iconfont.css">
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
        //页面初始化
        $(function () {
            function getTrainList() {
                $.ajax({
                    url: "http://localhost:8080/trainSystem_war_exploded/findAllTrain",
                    type: "GET",
                    async: false,
                    dataType: "JSON",
                    success: function (data) {
                        /* 可在后端增加判断发起者和接受者用户是否是同一用户的判断 */
                        for (var i = 0; i < data.length; i++) {
                            var jsonObj = data[i];
                            $("#selectTrainId").append("<option value='" + jsonObj.trainId + "'>" + jsonObj.trainId + "</option>");//主页面车次下拉框
                            $("#insertTrainId").append("<option value='" + jsonObj.trainId + "'>" + jsonObj.trainId + "</option>");//新增模态框车次下拉框
                        }
                    }
                });
            }

            function getStationList() {
                $.ajax({
                    url: "http://localhost:8080/trainSystem_war_exploded/findAllStation",
                    type: "GET",
                    async: false,
                    dataType: "JSON",

                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            var jsonObj = data[i];
                            $("#stationname").append("<option value='" + jsonObj.name + "'>")
                        }
                    }
                });
            }

            getTrainList();
            getStationList();
            $('body').css('display', 'block');
        });
        //更新列表
        $(function () {
            $("#select").click(function () {
                var value = document.getElementById("selectTrainId");//1：获取select对象
                var index = value.selectedIndex;//2：取到选中项的索引
                var val = value.options[index].value;//3：获取选中项的value
                //alert(val);
                $.ajax({
                    url: "http://localhost:8080/trainSystem_war_exploded/findAllTCById/" + val,
                    type: "GET",
                    dataType: "JSON",
                    success: function (result) {
                        //alert(JSON.stringify(result));
                        //删除原表格内容
                        while (1) {
                            if (document.getElementById('tablechild') == null) {
                                break;
                            }
                            var div = document.getElementById('tablechild');
                            div.parentNode.removeChild(div);
                        }

                        //将查找到的值显示到表格中
                        // var tbodyInfos=document.getElementById('tbody')
                        // var code='';//定义字符串格式，防止出现undefined
                        var obj = new Date();
                        var tbtStr = "";
                        var tetStr = "";
                        var stStr = "";
                        var blStr = "";
                        var h=0;
                        var m=0;
                        for (var i = 0; i < result.length; i++) {
                            if (result[i].tempBeginTime != null) {
                                obj = new Date(result[i].tempBeginTime);
                                tbtStr = obj.Format("hh:mm");
                            } else {
                                tbtStr = "--";
                            }
                            if (result[i].tempEndTime != null) {
                                obj = new Date(result[i].tempEndTime);
                                tetStr = obj.Format("hh:mm");
                            } else {
                                tetStr = "--";
                            }
                            if (result[i].sumTime != null) {
                                obj = new Date(result[i].sumTime);
                                stStr = obj.Format("hh时mm分");
                            } else {
                                stStr = "--";
                            }
                            if (result[i].lateTime != 0) {
                                h=parseInt(result[i].lateTime/60);
                                m=result[i].lateTime%60;
                                if (h==0){
                                    blStr=m+"分钟";
                                }else {
                                    blStr=h+"时"+m+"分";
                                }
                            } else {
                                blStr = "预计正点";
                            }
                            $("#tbody").append('<tr id="tablechild"><th>' + (i + 1) + '</th><td>' + result[i].id + '</td><td>' + result[i].trainId + '</td><td>' + result[i].stationName + '</td><td>' + tbtStr + '</td><td>' + tetStr + '</td><td>' + stStr + '</td><td>' + result[i].checkTicket + '</td><td>' + blStr + '</td><td id="option' + i + '"></td></tr>')
                            $("#option" + i + "").append('<a id="toset" class="btn btn-primary iconfont text-white"  value="'+result[i].id+'" data-toggle="modal" href="#update">&#xe8cf;</a><button type="button" class="btn btn-primary iconfont text-white" id="delete" value="'+result[i].id+'">&#xe74b;</button>')
                            // code+='<tr id="tablechild"><th>'+(i+1)+'</th><td>'+result[i].trainId+'</td><td>'+result[i].stationName+'</td><td>'+tbtStr+'</td><td>'+tetStr+'</td><td>'+stStr+'</td><td>'+result[i].checkTicketId+'</td><td>'+blStr+'</td></tr>'
                        }
                    }
                });
            });
        })
        //新增内容提交
        $(function () {
            $("#submitAdd").click(function () {
                alert($("#insert form").serialize());
                $.ajax({
                    url: "http://localhost:8080/trainSystem_war_exploded/addTC",
                    type: "POST",
                    async: false,//关闭异步
                    data: $("#insert form").serialize(),
                    success: function (result) {
                        alert(result.msg);
                        if (result.code==200){
                            $('#AutoCloseAddModal').trigger('click');//新增成功后，模拟点击关闭模态框
                        }
                    }
                });
                $('#select').trigger('click');//模拟点击刷新
                return false;//手动使表单提交不成功，避免刷新页面
            });
        })

        //给编辑按钮绑定点击 事件
        $(document).on("click","#delete",function(){
            var id=$(this).attr("value");
            var bool=confirm("是否删除？");
            if (bool){
                $.ajax({
                    url: "http://localhost:8080/trainSystem_war_exploded/deleteTC/"+id,
                    type: "POST",
                    async: false,//关闭异步
                    success: function (result) {
                        alert(result.msg)
                        $('#select').trigger('click');//模拟点击刷新
                    }
                });
            }
        });
        //初始化修改框内容
        $(document).on("click","#toset",function(){
            // alert('#delete'.target.parentElement.parentElement.children[2].children[0].innerText);
            //alert("delete");
            var id=$(this).attr("value");
            var ids=document.getElementById("ids");
            var tid=document.getElementById("tid")
            var trainId=document.getElementById("setTrainId");
            var station=document.getElementById("setStation");
            var arrTime=document.getElementById("setTenmBeginTime");
            var startTime=document.getElementById("setTenmEndTime");
            var blTime=document.getElementById("setBeginLate")
            var ticket=document.getElementById("setCheckTicket");
            //alert(id)
            $.ajax({
                url: "http://localhost:8080/trainSystem_war_exploded/toSet/"+id,
                type: "GET",
                async: false,
                success: function (data) {
                    //删除修改框内容
                    trainId.innerHTML="";
                    station.innerHTML="";
                    arrTime.innerHTML="";
                    startTime.innerHTML="";
                    ids.setAttribute("value",data[0].id);
                    blTime.setAttribute("value",data[0].lateTime);
                    tid.setAttribute("value",data[0].trainId)
                    trainId.append(data[0].trainId);
                    station.append(data[0].stationName)
                    var tbtStr = "";
                    var tetStr = "";
                    if (data[0].tempBeginTime != null) {
                        obj = new Date(data[0].tempBeginTime);
                        tbtStr = obj.Format("hh:mm");
                    } else {
                        tbtStr = "--";
                    }
                    if (data[0].tempEndTime != null) {
                        obj = new Date(data[0].tempEndTime);
                        tetStr = obj.Format("hh:mm");
                    } else {
                        tetStr = "--";
                    }
                    arrTime.append(tbtStr);
                    startTime.append(tetStr);
                    $.ajax({
                        url: "http://localhost:8080/trainSystem_war_exploded/findAllTicketByName/"+data[0].stationName,
                        type: "GET",
                        async: false,
                        dataType: "JSON",
                        success: function (result) {
                            //删除原表格内容
                            while (1) {
                                if (document.getElementById('setCheckTicketChild') == null) {
                                    break;
                                }
                                var div = document.getElementById('setCheckTicketChild');
                                div.parentNode.removeChild(div);
                            }
                            for (var i = 0; i < result.length; i++) {
                                var jsonObj = result[i];
                                $("#setCheckTicket").append("<option id='setCheckTicketChild' value='" + jsonObj.name + "'>" + jsonObj.name + "</option>")
                            }
                        }
                    });
                }
            });

        });
        //提交修改内容
        $(function () {
            $("#submitSet").click(function () {
                $.ajax({
                    url: "http://localhost:8080/trainSystem_war_exploded/setTC",
                    type: "POST",
                    async: false,//关闭异步
                    data: $("#update form").serialize(),
                    success: function (result) {
                        //console.log(result);控制台打印
                        alert("修改成功");
                        $('#AutoCloseSetModal').trigger('click');//模拟点击关闭模态框
                    }
                });
                $('#select').trigger('click');//模拟点击刷新
                return false;//手动使表单提交不成功，避免刷新页面
            });
        })

        $(function () {
            $("#inserStationName").click(function () {
                var station=document.getElementById("inserStationName");
                var text=station.value;
                if (text!=""){
                    $.ajax({
                        url: "http://localhost:8080/trainSystem_war_exploded/findAllTicketByName/"+text,
                        type: "GET",
                        async: false,
                        dataType: "JSON",
                        success: function (data) {
                            //删除原表格内容
                            while (1) {
                                if (document.getElementById('insertCheckTicketChild') == null) {
                                    break;
                                }
                                var div = document.getElementById('insertCheckTicketChild');
                                div.parentNode.removeChild(div);
                            }
                            for (var i = 0; i < data.length; i++) {
                                var jsonObj = data[i];
                                $("#insertCheckTicket").append("<option id='insertCheckTicketChild' value='" + jsonObj.name + "'>" + jsonObj.name + "</option>")
                            }
                        }
                    });
                }
            });
        })

    </script>
</head>
<body style="display: none">

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
            <li class="sidebar-list-item"><a href="back_trainId.jsp" class="sidebar-link text-muted active">
                <i class="iconfont text-gray icon1">&#xe65d;</i><span>车次管理</span></a></li>
            <li class="sidebar-list-item"><a href="trainList" class="sidebar-link text-muted">
                <i class="iconfont text-gray icon1">&#xe65a;</i><span>列车管理</span></a></li>
            <li class="sidebar-list-item"><a href="toLogin" class="sidebar-link text-muted">
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
                            <h6 class="h4 text-uppercase mb-0">车次管理</h6>
                        </div>
                        <div class="card-body">
                            <div class="form-group">

                                <!-- 查询 -->
                                <select type='text' name='selectTrainId' id='selectTrainId'></select>
                                <button type="button" class="btn btn-primary iconfont text-white" id="select">&#xe656;</button>
                                <%--                                <a class="btn btn-primary iconfont text-white" href="#">&#xe656;</a>--%>
                                <!-- 增加 -->
                                <a class="btn btn-primary iconfont text-white" data-toggle="modal" href='#insert'>&#xe8c0;</a>
                                <div class="modal fade" id="insert">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">增加车站</h4>
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-hidden="true">&times;
                                                </button>
                                            </div>
                                            <!-- 提交表单 -->
                                            <form>
                                                <div class="modal-body">
                                                    <!-- 这里后端填想要增加的内容 -->
                                                    <h5>添加经停站信息</h5><br><br>

                                                    <b>车次：</b> <select id="insertTrainId" name="trainId"></select> <br><br>
                                                    <b>站点名称：</b><input id="inserStationName" type="text" name="stationName" list="stationname"
                                                                placeholder="请输入车站名" class="form-control">
                                                        <datalist id="stationname"></datalist><br><br>
                                                    <b>到达时间：</b><input type="time" name="tbt" class="form-control"><br><br>
                                                    <b>当日达：</b><input type="radio" value="0" name="day" checked>
                                                    <b>次日达：</b><input type="radio" value="1" name="day"> <br><br>
                                                    <b>发车时间：</b><input type="time" name="tet" class="form-control"><br><br>
                                                    <b>检票口：</b><select id="insertCheckTicket" name="checkTicket"></select>

                                                </div>
                                                <div class="modal-footer">
                                                    <input type="submit" id="submitAdd" class="btn btn-success"
                                                           value="保存">
                                                    <a id="AutoCloseAddModal" href="#" class="btn btn-danger"
                                                       data-dismiss="modal">关闭</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="update">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">修改车站</h4>
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-hidden="true">&times;
                                                </button>
                                            </div>
                                            <form action="#">
                                                <div class="modal-body">

                                                    <h5>修改</h5>
                                                    <input name="id" id="ids" type="text" style="display: none" value="">
                                                    <input name="trainId" id="tid" type="text" style="display: none" value="">
                                                    <b>列车车次:</b> <b id="setTrainId"></b><br><br>
                                                    <b>经停站:</b><b id="setStation"></b><br><br>
                                                    <b>到站时间:</b><b id="setTenmBeginTime"></b><br><br>
                                                    <b>发车时间:</b><b id="setTenmEndTime"></b><br><br>
                                                    <b>晚点时间:</b><input class="form-control" type="text" name="lateTime" id="setBeginLate" ></b><br><br>
                                                    <b>检票口:</b><select id="setCheckTicket" name="checkTicket"></select><br><br>
                                                    <b>是否复用</b>单个：<input type="radio" value="0" class="flag" name="flag" checked>
                                                    全部：<input  type="radio" value="1" class="flag" name="flag"><br><br>


                                                </div>
                                                <div class="modal-footer">
                                                    <input id="submitSet" type="submit" class="btn btn-success" value="保存">
                                                    <a href="#" id="AutoCloseSetModal" class="btn btn-danger"
                                                       data-dismiss="modal">关闭</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <table class="table table-striped table-sm card-text" id="table">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>id</th>
                                    <th>车次</th>
                                    <th>经停站</th>
                                    <th>到达时间</th>
                                    <th>发车时间</th>
                                    <th>用时</th>
                                    <th>检票口</th>
                                    <th>正晚点</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbody">
                                <tr id="tablechild">
                                    <%--                                    <th scope="row">1</th>--%>
                                    <th>1</th>
                                        <td id=" id">22</td>
                                    <td>车次</td>
                                    <td>经停站</td>
                                    <td>到达时间</td>
                                    <td>发车时间</td>
                                    <td>用时</td>
                                    <td>检票口</td>
                                    <td>正晚点</td>
                                    <td id="option">
                                        <!-- 修改 -->
                                        <a class="btn btn-primary iconfont text-white" data-toggle="modal"
                                           href='#update'>&#xe8cf;</a>
                                        <div class="modal fade" id="update">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">修改车站</h4>
                                                        <button type="button" class="close" data-dismiss="modal"
                                                                aria-hidden="true">&times;
                                                        </button>
                                                    </div>
                                                    <form action="#">
                                                        <div class="modal-body">
                                                            <!-- 这里后端填想要增加的内容,记得加上form-control -->
                                                            <h5>添加</h5>
                                                            <input type="text" class="form-control">

                                                        </div>
                                                        <div class="modal-footer">
                                                            <input type="submit" class="btn btn-success" value="保存">
                                                            <a href="#" class="btn btn-danger"
                                                               data-dismiss="modal">关闭</a>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 删除 -->
                                        <button id="delete" class="btn btn-primary iconfont text-white" name="序号为1">&#xe74b;</button>

                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>

</body>
</html>
