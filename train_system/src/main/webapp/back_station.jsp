<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/20
  Time: 7:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/train.css">
    <link rel="stylesheet" href="fonts/iconfont.css">
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        $(function () {
            $("#insertBtn").click(function () {
                $("#addStationForm").get(0).reset();
                $("#insertModal").modal("show");
            })
            $(".quit").click(function () {
                $("#insertModal").modal("hide");
            })

            $("#addStationBtn").click(function () {
                let cityName = $("#cityName").val();
                let stationName = $("#stationName").val();
                let sellTime = $("#sellTime").val();
                $.ajax({
                    url:"addStation",
                    data:{
                        id:0,
                        cityName:cityName,
                        name:stationName,
                        ticketStartSell:sellTime,
                    },
                    type:"post",
                    success:function (i) {
                        if (i > 0) {
                            $("#insertModal").modal("hide");
                        } else {
                            $("#insertModal").modal("show");
                            alert("输入有误");
                        }
                        let maxPages = $("#maxPages").val();
                        window.location.href = "queryAllStation?page=" + maxPages;
                    }
                })
            });

            $(".deleteBtn").click(function () {
                if (window.confirm("确定要删除该车站吗？")) {
                    let id = $(this).parent().prevAll().eq(3).text();
                    $.ajax({
                        url: "delStation?id=" + id,
                        type: "post",
                        dataType: "json",
                        success: function (i) {
                            let currentPage = $("#pageNum").val();
                            if (i > 0) {
                                window.location.href = "queryAllStation?page=" + currentPage;
                            } else {
                                alert("删除失败！");
                            }
                        }
                    })
                }
            })
        })
    </script>
</head>
<body>
<%--添加车站模态框--%>
<div class="modal fade" id="insertModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="insertModalLabel">添加车站信息</h5>
                <button type="button" class="close quit" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addStationForm">
                    <div class="form-group">
                        <label for="cityName">所在城市</label>
                        <select class="form-control" id="cityName">
                            <option value="" selected>请选择</option>
                            <c:forEach items="${cityNameList}" var="city">
                                <option value="${city.id}">${city.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="stationName">车站名称</label>
                        <input type="text" class="form-control" id="stationName">
                    </div>
                    <div class="form-group">
                        <label for="sellTime">售票时间</label>
                        <input type="time" class="form-control" id="sellTime">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger quit">取消</button>
                <button type="button" class="btn btn-success" id="addStationBtn">添加</button>
            </div>
        </div>
    </div>
</div>
<%--修改车站模态框--%>
<div class="modal fade" id="updateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">修改车站信息</h5>
                <button type="button" class="close quit" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger quit">取消</button>
                <button type="button" class="btn btn-success" id="updateStationBtn">添加</button>
            </div>
        </div>
    </div>
</div>
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
        <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">MAIN</div>

        <ul class="sidebar-menu list-unstyled">
            <li class="sidebar-list-item"><a href="queryAllStation?page=1" class="sidebar-link text-muted active">
                <i class="iconfont text-gray icon1">&#xe626;</i><span>车站管理</span></a></li>
            <li class="sidebar-list-item"><a href="back_trainId.jsp" class="sidebar-link text-muted">
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
                            <h6 class="h4 text-uppercase mb-0">车站管理</h6>
                        </div>
                        <div class="card-body">
                            <div class="form-group">

                                <form class="form-inline" action="queryStationByCondition" method="post">
                                    <div class="form-group">
                                        <label for="nameByFind">车站名称：</label>
                                        <input type="text" id="nameByFind" name="stationName" value="${stationName}"
                                               class="form-control mx-sm-3">
                                        <label for="cityByFind">所在城市：</label>
                                        <input type="text" id="cityByFind" name="cityName" value="${cityName}"
                                               class="form-control mx-sm-3">
                                        <!-- 查询 -->
                                        <button class="btn btn-primary iconfont text-white" type="submit">&#xe656;</button>
                                    </div>
                                </form>
                            </div>
                            <!-- 增加 -->
                            <div> <button class="btn btn-primary iconfont text-white" id="insertBtn">&#xe8c0;</button></div>
                            <table class="table table-striped table-sm card-text">
                                <thead>
                                <tr>
                                    <th style="width: 250px">编号</th>
                                    <th style="width: 250px">车站名称</th>
                                    <th style="width: 250px">所在城市</th>
                                    <th style="width: 250px">售票时间</th>
                                    <th style="width: 250px">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${stationList}" var="station" varStatus="status">
                                <tr>
                                    <th scope="row">${station.id}</th>
                                    <td>${station.name}</td>
                                    <td>${station.cityName}</td>
                                    <td>
                                        <fmt:formatDate value="${station.ticketStartSell}" pattern="HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <!-- 删除 -->
                                        <button class="btn btn-primary iconfont text-white deleteBtn" >&#xe74b;</button>
                                    </td>
                                </tr>
                                </c:forEach>

                                </tbody>
                            </table>
                            <div>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item">
                                        <a class="page-link" href="queryAllStation?page=1">首页</a>
                                    </li>
                                    <li class="page-item <c:if test="${pageInfo.pageNum==1}">disabled</c:if>">
                                        <a class="page-link"
                                           href="queryAllStation?page=${pageInfo.pageNum-1}">上一页</a>
                                    </li>
                                    <input type="hidden" id="maxPages" value="${pageInfo.pages}"/>
                                    <input type="hidden" id="pageNum" value="${pageInfo.pageNum}"/>
                                    <c:if test="${pageInfo.pageNum >= 1 && pageInfo.pageNum <= 6
                                    && pageInfo.pages > 20}">
                                        <c:forEach  begin="1" end="10" step="1" var="pageNo">
                                            <li class="page-item <c:if test="${pageInfo.pageNum==pageNo}">active</c:if>"
                                                <c:if test="${pageInfo.pageNum==pageNo}">aria-current="page"</c:if>>
                                                <a class="page-link"
                                                   href="queryAllStation?page=${pageNo}">${pageNo}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${pageInfo.pageNum >= 7 && pageInfo.pageNum <= (pageInfo.pages - 5)
                                     && pageInfo.pages > 20}">
                                    <c:forEach  begin="${pageInfo.pageNum - 4}" end="${pageInfo.pageNum + 5}" step="1" var="pageNo">
                                    <li class="page-item <c:if test="${pageInfo.pageNum==pageNo}">active</c:if>"
                                        <c:if test="${pageInfo.pageNum==pageNo}">aria-current="page"</c:if>>
                                        <a class="page-link"
                                           href="queryAllStation?page=${pageNo}">${pageNo}</a>
                                    </li>
                                    </c:forEach>
                                    </c:if>
                                    <c:if test="${pageInfo.pageNum >= (pageInfo.pages - 4) && pageInfo.pageNum <= pageInfo.pages
                                    && pageInfo.pages > 20}">
                                        <c:forEach  begin="${pageInfo.pageNum - 4}" end="${pageInfo.pages}" step="1" var="pageNo">
                                            <li class="page-item <c:if test="${pageInfo.pageNum==pageNo}">active</c:if>"
                                                <c:if test="${pageInfo.pageNum==pageNo}">aria-current="page"</c:if>>
                                                <a class="page-link"
                                                   href="queryAllStation?page=${pageNo}">${pageNo}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                    <li class="page-item <c:if test="${pageInfo.pageNum==pageInfo.pages}">disabled</c:if>">
                                        <a class="page-link"
                                           href="queryAllStation?page=${pageInfo.pageNum+1}">下一页</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link"
                                           href="queryAllStation?page=${pageInfo.pages}">尾页</a>
                                    </li>
                                </ul>
                            </nav>
                            </div>
                        </div>
                    </div>
                </div>
        </section>
    </div>
</div>
</div>
</body>
</html>
