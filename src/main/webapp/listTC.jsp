<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/6/10 0010
  Time: 1:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="page-header">
    <h1>经停站信息
        <small>${TClist.get(0).trainId}</small>
    </h1>
</div>
<table class="table table-striped table-bordered table-hover table-condensed">
    <tr>
        <td>车次</td>
        <td>经停站</td>
        <td>到达时间</td>
        <td>发车时间</td>
        <td>用时</td>
        <td>检票口</td>
        <td>正晚点</td>
        <td>操作</td>
    </tr>
    <c:forEach items="${TClist}" var="tc">
        <tr>
            <td>${tc.trainId}</td>
            <td>${tc.stationName}</td>
            <td><fmt:formatDate pattern="HH:mm" value="${tc.tempBeginTime}"/></td>
            <td><fmt:formatDate pattern="HH:mm" value="${tc.tempEndTime}"/></td>
            <td><fmt:formatDate pattern="HH时mm分" value="${tc.sumTime}"/></td>
            <td>${tc.checkTicketId}</td>
            <c:choose>
                <c:when test="${tc.beginLate==null}">
                    <td>预计正点</td>
                </c:when>
                <c:when test="${tc.beginLate!=null}">
                    <td><fmt:formatDate pattern="HH时mm分" value="${tc.beginLate}"/></td>
                </c:when>
            </c:choose>
            <td><a href="tosetTC/${tc.id}">修改</a><a href="deleteTC/${tc.id}">删除</a></td>
        </tr>
    </c:forEach>

</table>
</body>
</html>
