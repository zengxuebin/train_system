<%--
  Created by IntelliJ IDEA.
  User: 曾雪斌
  Date: 2022/6/20
  Time: 6:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>全国列车在线查询系统</title>
    <%--
        登录页面
    --%>
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="./vendor/bootstrap/css/bootstrap.min.css">
    <!-- 这个页面的css-->
    <link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<div style="background-color: white">
<div style="width: 1200px;padding: 0 5px;margin-left: auto;margin-right: auto;">
    <!-- 头部内容 -->
    <div style="height: 80px;">
        <h1 style="float: left;margin: 15px 0 0 0;">
            <a href="toLogin">
                <img src="./img/logo2.png" height="48px"/>
            </a>
        </h1>
        <div style="float: left;height: 80px;line-height: 80px;padding-left: 40px;font-size: 20px;">
            欢迎登录列车查询后台管理系统
        </div>
    </div>
</div>
</div>
<div class="page-holder d-flex align-items-center">
    <div class="container">
        <div class="row align-items-center py-5">

            <!-- 左边，这里是图片 -->
            <div class="col-5 col-lg-7 mx-auto mb-5 mb-lg-0">
                <div class="pr-lg-5"><img src="images/illustration.svg" alt="" class="img-fluid"></div>
            </div>

            <!-- 右边，这里是表单 -->
            <div class="col-lg-5 px-lg-4">
                <h1 class="text-base text-primary text-uppercase mb-4">Administrator Login</h1>
                <h2 class="mb-4">管理员登录</h2>
                <p class="text-muted">此界面仅提供给管理员使用，登录后您可以对列车、车站、车次进行管理</p>

                <form id="loginForm" action="login" class="mt-4" method="post">

                    <!-- 用户名 -->
                    <div class="form-group mb-4">
                        <input type="text" name="username" placeholder="请输入管理员账号" class="form-control border-0 shadow form-control-lg" required>
                    </div>
                    <!-- 密码 -->
                    <div class="form-group mb-4">
                        <input type="password" name="password" placeholder="请输入管理员密码" class="form-control border-0 shadow form-control-lg" required>
                    </div>

                    <!-- <div class="form-group mb-4">
                      <div class="custom-control custom-checkbox">
                        <input id="customCheck1" type="checkbox" checked class="custom-control-input">
                        <label for="customCheck1" class="custom-control-label">Remember Me</label>
                      </div>
                    </div> -->
                    <div>
                        <button type="submit" class="btn btn-primary shadow px-5"
                                style="font-size: 16px;height: 44px;width: 100%;">
                            立即登录
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- JavaScript files-->
<script src="./vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
