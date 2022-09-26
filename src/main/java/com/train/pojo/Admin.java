package com.train.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 管理员实体类——t_admin
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Admin {

    //用户名
    private String username;
    //密码
    private String password;

}
