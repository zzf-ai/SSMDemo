package com.zzf.ssm.service;

import com.zzf.ssm.pojo.Employee;

import java.util.List;

/*
 *
 *@author:zzf
 *@time:2021-01-17
 *
 */
public interface EmployeeService {
    List<Employee> getAll();
    void saveEmployee(Employee employee);
    boolean checkEmail(String email);
    Employee getEmp(Integer empId);
    void updateEmp(Employee employee);
    void deleteEmp(Integer empId);
    void deleteBatch(List<Integer> empIds);
}
