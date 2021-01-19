package com.zzf.ssm.pojo;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/*
 *
 *@author:zzf
 *@time:2021-01-17
 *
 */
@Data
public class Msg {
    private Integer code;//状态码
    private String msg;//提示信息
    private Map<String, Object> data=new HashMap<>();//返回的数据

    //定义成功，失败的信息
    public static Msg success(){
        Msg result=new Msg();
        result.setCode(200);
        result.setMsg("处理成功");
        return result;
    }
    public static Msg fail(){
        Msg result=new Msg();
        result.setCode(400);
        result.setMsg("处理失败");
        return result;
    }

    //定义添加数据操作
    public Msg add(String key,Object value){
        this.getData().put(key,value);
        return this;
    }
}
