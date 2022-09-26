<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/6/9 0009
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" href="./css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="page-header">
    <h1>添加经停站信息</h1>
</div>
<form action="addTC" method="post">
    <ul>
        车次：<li>
<%--        <input type="text" name="trainId" id="" list="trainid" placeholder="请输入车次" value="${train.trainId}"--%>
<%--                      style="width: 250px" class="input-text">--%>

<%--        <datalist id="trainid">--%>
<%--            <c:forEach items="${trainlist}" var="train">--%>
<%--                <option value="${train.trainId}">--%>
<%--            </c:forEach>--%>
<%--        </datalist>--%>

            <select name="trainId">
            <c:forEach items="${trainlist}" var="train">
                    <option value="${train.trainId}" selected>${train.trainId}</option>
            </c:forEach>
        </select>
    </li>
        站点名称：<li>
                <input type="text" name="stationName" list="stationname" placeholder="请输入车站名"
                              style="width: 250px" class="input-text">

                <datalist id="stationname">
                    <c:forEach items="${stationlist}" var="station">
                        <option value="${station.name}">
                    </c:forEach>
                </datalist></li>
        到达时间：<li><input type="time" name="tbt"></li>
        <li>当日达：<input type="radio" value="0" name="day" checked>次日达：<input type="radio" value="1" name="day"></li>
        发车时间：<li><input type="time" name="tet"></li>
        检票口： <li><input type="text" name="checkTicketId"></li>
    </ul>
    <input type="submit" value="提交">
</form>

</body>
</html>
