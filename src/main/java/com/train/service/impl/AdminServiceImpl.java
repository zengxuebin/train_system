package com.train.service.impl;

import com.train.dao.AdminMapper;
import com.train.pojo.Admin;
import com.train.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements IAdminService {
    @Autowired
    private AdminMapper adminDao;

    @Override
    public Admin findByAdmin(Admin admin){
        return adminDao.findByAdmin(admin);
    }
}
