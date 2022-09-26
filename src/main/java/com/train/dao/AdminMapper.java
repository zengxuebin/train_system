package com.train.dao;

import com.train.pojo.Admin;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author: ZLL
 * @create: 2022/6/7
 * @Description:
 * @FileName: IAdminDao
 * @History:
 * @自定义内容：
 */
@Mapper
public interface AdminMapper {
    Admin findByAdmin(Admin admin);
}
