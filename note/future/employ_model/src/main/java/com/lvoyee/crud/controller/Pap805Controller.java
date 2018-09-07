package com.lvoyee.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lvoyee.crud.bean.Pap805;
import com.lvoyee.crud.bean.Msg;
import com.lvoyee.crud.service.Pap805Service;
import com.lvoyee.crud.utils.ExportExcel;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.lvoyee.crud.utils.ImportExcel2.getEntityFromSheet;

//spring对于对象的传递，只能ajax json串的形式
//modelAttribute不会使用
//关于form表单提交不了 input button submit之间的区别

/**
* 描述：控制层
* @author Ay
* @date 2017/05/03
*/
@Controller
@RequestMapping("/pap805")
public class Pap805Controller {
    @Autowired
    Pap805Service pap805Service;

    //分页显示的条数是10

    @RequestMapping("/")
    public String index2(){
        return "index2";
    }



    //查询所有的员工信息 将部门信息带过去
    @RequestMapping("/list")
    public ModelAndView getAll2(@RequestParam(value="pn", defaultValue="1") Integer pn, Pap805 pap805){
        PageHelper.startPage(pn, 10);
        //emoloyee中有部门信息了
        List<Pap805> pap805List = pap805Service.getAll(pap805);

        PageInfo page = new PageInfo(pap805List, 5);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/pap805/pap805List");
        mv.addObject("pageInfo", page);
        return mv;
    }

    //查询所有的员工信息 使用了ajax请求
    @RequestMapping("/listX")
    @ResponseBody
    public Msg getAllX(@RequestParam(value="pn", defaultValue="1") Integer pn,Pap805 pap805){
        PageHelper.startPage(pn, 10);
        List<Pap805> pap805List = pap805Service.getAll(pap805);

        PageInfo page = new PageInfo(pap805List, 5);
        Msg msg = new Msg();
        msg.getExtend().put("pageInfo", page);
        return msg;
    }


    //添加员工
    @RequestMapping(value="/add", method= RequestMethod.POST)
    public String addPap805(Pap805 pap805){
        pap805Service.save(pap805);
        return "redirect:/pap805/list";
    }







}
