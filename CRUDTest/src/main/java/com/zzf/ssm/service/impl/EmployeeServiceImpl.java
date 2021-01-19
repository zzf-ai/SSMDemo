package com.zzf.ssm.service.impl;

import com.zzf.ssm.dao.EmployeeMapper;
import com.zzf.ssm.pojo.Employee;
import com.zzf.ssm.pojo.EmployeeExample;
import com.zzf.ssm.service.EmployeeService;
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
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    @Override
    public void saveEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkEmail(String email) {

        EmployeeExample employeeExample=new EmployeeExample();
        //拼装条件
        EmployeeExample.Criteria criteria=employeeExample.createCriteria();
        criteria.andEmailEqualTo(email);
        long count = employeeMapper.countByExample(employeeExample);
        return count==0;
    }

    @Override
    public Employee getEmp(Integer empId) {
        return employeeMapper.selectByPrimaryKey(empId);
    }

    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    @Override
    public void deleteEmp(Integer empId) {
        employeeMapper.deleteByPrimaryKey(empId);
    }

    @Override
    public void deleteBatch(List<Integer> empIds) {
        //封装条件
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpIdIn(empIds);
        //批量删除
        employeeMapper.deleteByExample(example);
    }
}
