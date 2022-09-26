<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/6/10 0010
  Time: 2:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="page-header">
    <h1>修改经停站信息
        <small>车次：${TC.trainId}/站点：${TC.stationName}</small>
    </h1>
</div>
<%--<form action="setTC/${TC.id}" method="post">--%>
<%--    <ul>--%>
<%--        <li>列车车次:   <input type="text" name="trainId" value="${TC.trainId}"></li>--%>
<%--        <li>经停站:    <input type="text" name="stationName" value="${TC.stationName}"></li>--%>
<%--        <li>到站时间:   <input type="text" name="tbt" value="<fmt:formatDate pattern="HH:mm:ss" value="${TC.tempBeginTime}"/>"></li>--%>
<%--        <li>发车时间:   <input type="text" name="tet" value=" <fmt:formatDate pattern="HH:mm:ss" value="${TC.tempEndTime}"/>"></li>--%>
<%--&lt;%&ndash;        到站用时后期给予去除，根据上次发车进行计算&ndash;%&gt;--%>
<%--        <li>晚点时间:   <input type="text" name="st" placeholder="<fmt:formatDate pattern="HH:mm:ss" value="${TC.sumTime}"/>"></li>--%>
<%--    </ul>--%>
<%--    <input type="submit" value="提交">--%>
<%--</form>--%>
<form id="form1" name="form1" action="" method="post">
    <ul>
        <li>列车车次:  ${TC.trainId}</li>
        <li>经停站:   ${TC.stationName}</li>
        <li>到站时间:  <fmt:formatDate pattern="HH:mm" value="${TC.tempBeginTime}"/></li>
        <li>发车时间:  <fmt:formatDate pattern="HH:mm" value="${TC.tempEndTime}"/></li>
        <li>晚点时间:  <input type="time" name="bl" ></li>
<%--        <li>晚点时间:  <input type="text" name="bl" placeholder="<fmt:formatDate pattern="HH:mm" value="${TC.beginLate}"/>"></li>--%>
        <li>检票口:   <input type="text" name="checkTicketId" placeholder="${TC.checkTicketId}"></li>
    </ul>
    <input type="submit" name="button1" id="button1" value="提  交" class="submit_01"
           onclick="form1.action='setTC/${TC.id}/0/${TC.trainId}';form1.submit();"/>
    <input type="submit" name="button2" id="button2" value="提交并复用晚点信息" class="submit_01"
           onclick="form1.action='setTC/${TC.id}/1/${TC.trainId}';form1.submit();"/>
</form>
</body>
</html>
