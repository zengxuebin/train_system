package com.train.controller;

import com.train.pojo.Admin;
import com.train.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * @author: 曾聆聆
 * @History:
 * LoginController更名为AdminController
 * 新增退出管理员退出功能
 * 删除用户名密码判空验证
 * 接收参数可以直接用Admin admin，Controller会自动封装对象
 * 登录成功后将用户信息保存在Session中
 */
@Controller
public class AdminController {

    @Autowired
    private IAdminService adminService;

    @PostMapping("/login")
    public String saveAdmin(Admin admin, Model model, HttpSession session) {
        System.out.println("登录");
        System.out.println(admin);
        if (admin.getPassword().length() < 6) {
            System.out.println("密码不能少于6位");
            model.addAttribute("msg", "密码不能少于6位");
            return "login";
        } else {
            admin = adminService.findByAdmin(admin);
            if (admin != null) {
                System.out.println("登录成功");
                session.setAttribute("admin", admin);
                return "forward:/queryAllStation" + "?page=1";
            } else {
                model.addAttribute("msg", "用户名或密码错误");
                return "login";
            }
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        //销毁session
        session.invalidate();
        return "redirect:/toLogin";
    }
}



