package ${package_name}.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${package_name}.bean.${table_name};
import ${package_name}.bean.Msg;
import ${package_name}.service.${table_name}Service;
import ${package_name}.utils.ExportExcel;
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

import static ${package_name}.utils.ImportExcel2.getEntityFromSheet;

//spring对于对象的传递，只能ajax json串的形式
//modelAttribute不会使用
//关于form表单提交不了 input button submit之间的区别

/**
* 描述：${table_annotation}控制层
* @author ${author}
* @date ${date}
*/
@Controller
@RequestMapping("/${table_name?uncap_first}")
public class ${table_name}Controller {
    @Autowired
    ${table_name}Service ${table_name?uncap_first}Service;

    //分页显示的条数是10

    @RequestMapping("/")
    public String index2(){
        return "index2";
    }



    //查询所有的员工信息 将部门信息带过去
    @RequestMapping("/list")
    public ModelAndView getAll2(@RequestParam(value="pn", defaultValue="1") Integer pn, ${table_name} ${table_name?uncap_first}){
        PageHelper.startPage(pn, 10);
        //emoloyee中有部门信息了
        List<${table_name}> ${table_name?uncap_first}List = ${table_name?uncap_first}Service.getAll(${table_name?uncap_first});

        PageInfo page = new PageInfo(${table_name?uncap_first}List, 5);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/${table_name?uncap_first}/${table_name?uncap_first}List");
        mv.addObject("pageInfo", page);
        return mv;
    }

    //查询所有的员工信息 使用了ajax请求
    @RequestMapping("/listX")
    @ResponseBody
    public Msg getAllX(@RequestParam(value="pn", defaultValue="1") Integer pn,${table_name} ${table_name?uncap_first}){
        PageHelper.startPage(pn, 10);
        List<${table_name}> ${table_name?uncap_first}List = ${table_name?uncap_first}Service.getAll(${table_name?uncap_first});

        PageInfo page = new PageInfo(${table_name?uncap_first}List, 5);
        Msg msg = new Msg();
        msg.getExtend().put("pageInfo", page);
        return msg;
    }


    //添加员工
    @RequestMapping(value="/add", method= RequestMethod.POST)
    public String add${table_name}(${table_name} ${table_name?uncap_first}){
        ${table_name?uncap_first}Service.save(${table_name?uncap_first});
        return "redirect:/${table_name?uncap_first}/list";
    }







}
