package com.gtz.commons.domain;

import com.gtz.commons.contants.Code;

/**
 * @author 葛天助
 * @version 1.0
 */
public class Result {
    private String code; //处理成功或失败的标记
    private Object data;
    private String msg;

    public Result() {
    }

    public Result(String code, Object data, String msg) {
        this.code = code;
        this.data = data;
        this.msg = msg;
    }

    public void resError(){
        this.setCode(Code.RETURN_CODE_ERR);
        this.setMsg("系统繁忙,请稍后再试...");
    }

    public void resError(String msg){
        this.setCode(Code.RETURN_CODE_ERR);
        this.setMsg(msg);
    }

    public void resOk(Object data){
        this.setCode(Code.RETURN_CODE_OK);
        this.setData(data);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
