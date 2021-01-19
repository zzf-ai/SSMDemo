package com.zzf.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzf.ssm.pojo.Employee;
import com.zzf.ssm.pojo.Msg;
import com.zzf.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 *
 *@author:zzf
 *@time:2021-01-16
 *
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    //删除操作
    @DeleteMapping(value = "/empDelete/{empIds}")
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("empIds")String empIds){
        if(empIds.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids=empIds.split("-");
            //组装empId集合
            for (String str:str_ids){
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer empId=Integer.parseInt(empIds);
            employeeService.deleteEmp(empId);
        }

        return Msg.success();
    }

    //更新操作
    @PutMapping(value = "/empUpdate/{empId}")
    @ResponseBody
    public Msg updateEmployee(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //根据id查询单个员工信息
    @GetMapping(value = "/emp/{empId}")
    @ResponseBody
    public Msg getEmp(@PathVariable("empId") Integer empId){
        Employee employee=employeeService.getEmp(empId);
        return Msg.success().add("emp",employee);
    }

    //检查email是否可用
    @PostMapping("/checkEmail")
    @ResponseBody
    public Msg checkEmail(@RequestParam("email") String email){
        //先合法校验
        String regx="^[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*\\.[a-z]{2,}$";
        if(!email.matches(regx)){
            return Msg.fail().add("error_msg","邮箱格式不正确");
        }
        boolean b = employeeService.checkEmail(email);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("error_msg","邮箱已被使用");
        }
    }

    @PostMapping("/empAdd")
    @ResponseBody
    public Msg saveEmp(@Validated Employee employee, BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            Map<String, Object> map=new HashMap<>();
            List<FieldError> errors=bindingResult.getFieldErrors();
            for (FieldError fieldError:
                 errors) {
                //封装错误的字段名和信息
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }

        employeeService.saveEmployee(employee);
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        String orderBy="emp_id asc";
        //传入页码，以及每页大小
        PageHelper.startPage(pn,5,orderBy);
        List<Employee> emps = employeeService.getAll();

        //封装到pageInfo,传入连续显示的页数
        PageInfo page=new PageInfo(emps,5);
        /*for (Object emp:page.getList()
             ) {
            System.out.println();
        }*/
        return Msg.success().add("pageInfo",page);
    }
}
