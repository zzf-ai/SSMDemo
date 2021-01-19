package com.zzf.ssm.test;

import com.github.pagehelper.PageInfo;
import com.zzf.ssm.pojo.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/*
 *
 *@author:zzf
 *@time:2021-01-17
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:beans.xml","classpath:spring-mvc.xml"})
public class PageTest {
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求
    MockMvc mockMvc;

    @Before
    public void initMokcMvc(){
        mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

        //请求成功的话请求域会有pageInfo
        MockHttpServletRequest request=result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页数："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums=pageInfo.getNavigatepageNums();
        for(int i:nums){
            System.out.println(" "+i);
        }

        //获取员工数据
        List<Employee> list=pageInfo.getList();
        for (Employee employee:list){
            System.out.println("ID:"+employee.getEmpId()+"|Name:"+employee.getEmpName());
        }
    }
}
