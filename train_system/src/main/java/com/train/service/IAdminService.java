package com.train.service;

import com.train.pojo.Admin;
import org.apache.ibatis.annotations.Mapper;

public interface IAdminService {
    Admin findByAdmin(Admin admin);
}
