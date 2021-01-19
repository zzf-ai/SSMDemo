package com.zzf.ssm.controller;

import com.zzf.ssm.pojo.Department;
import com.zzf.ssm.pojo.Msg;
import com.zzf.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/*
 *
 *@author:zzf
 *@time:2021-01-17
 *
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list = departmentService.getAllDepts();
        return Msg.success().add("depts",list);
    }
}
