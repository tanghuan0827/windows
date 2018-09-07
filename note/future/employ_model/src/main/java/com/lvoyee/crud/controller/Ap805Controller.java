package com.lvoyee.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lvoyee.crud.bean.Ap805;
import com.lvoyee.crud.bean.Msg;
import com.lvoyee.crud.bean.Pap805;
import com.lvoyee.crud.service.Ap805Service;
import com.lvoyee.crud.service.Pap805Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//spring对于对象的传递，只能ajax json串的形式
//modelAttribute不会使用
//关于form表单提交不了 input button submit之间的区别

/**
* 描述：控制层
* @author Ay
* @date 2017/05/03
*/
@Controller
@RequestMapping("/ap805")
public class Ap805Controller {
    @Autowired
    Ap805Service ap805Service;

    @Autowired
    Pap805Service pap805Service;

    //分页显示的条数是10

    @RequestMapping("/")
    public String index2(){
        return "index2";
    }

    @RequestMapping("/index")
    public String index3(){
        return "ap805/index";
    }



    //查询所有的员工信息 将部门信息带过去
    @RequestMapping("/list")
    public ModelAndView getAll2(@RequestParam(value="pn", defaultValue="1") Integer pn, Ap805 ap805){
        PageHelper.startPage(pn, 10);
        //emoloyee中有部门信息了
        List<Ap805> ap805List = ap805Service.getAll(ap805);

        PageInfo page = new PageInfo(ap805List, 5);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/ap805/ap805List");
        mv.addObject("pageInfo", page);
        return mv;
    }

    //查询所有的员工信息 使用了ajax请求
    @RequestMapping("/listX")
    @ResponseBody
    public Msg getAllX(@RequestParam(value="pn", defaultValue="1") Integer pn,Ap805 ap805){
        PageHelper.startPage(pn, 10);
        List<Ap805> ap805List = ap805Service.getAll(ap805);

        PageInfo page = new PageInfo(ap805List, 5);
        Msg msg = new Msg();
        msg.getExtend().put("pageInfo", page);
        return msg;
    }

    @RequestMapping("/getPicture")
    @ResponseBody
    public Map getPicture(){

        List<Ap805> ap805List = ap805Service.getOne();
        List<Pap805> pap805List=pap805Service.getClose();
        Map map = new HashMap();
        map.put("ap805",ap805List);


        List<Pap805> llist=new ArrayList<Pap805>();
        for(Pap805 pap805:pap805List){
            for(Ap805 ap805:ap805List){
                if(ap805.getDateF().compareTo(pap805.getDateP())==0){
                    llist.add(pap805);
                }
            }
        }
        map.put("pap805",llist);
        return map;
    }


    //添加员工
    @RequestMapping(value="/add", method= RequestMethod.POST)
    public String addAp805(Ap805 ap805){
        ap805Service.save(ap805);
        return "redirect:/ap805/list";
    }







}
