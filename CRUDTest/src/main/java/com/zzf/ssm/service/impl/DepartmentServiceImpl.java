package com.zzf.ssm.service.impl;

import com.zzf.ssm.dao.DepartmentMapper;
import com.zzf.ssm.pojo.Department;
import com.zzf.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/*
 *
 *@author:zzf
 *@time:2021-01-17
 *
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAllDepts() {
        return departmentMapper.selectByExample(null);
    }
}
