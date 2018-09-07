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
import javax.swing.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

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

    //查询所有的员工信息
    @RequestMapping("/list")
    public ModelAndView getAll(@RequestParam(value="pn", defaultValue="1") Integer pn){
        PageHelper.startPage(pn, 10);
        List<${table_name}> ${table_name?uncap_first}List = ${table_name?uncap_first}Service.getAll();

        PageInfo page = new PageInfo(${table_name?uncap_first}List, 5);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/${table_name?uncap_first}/${table_name?uncap_first}List");
        mv.addObject("pageInfo", page);
        return mv;
    }

    //到添加${table_name?uncap_first}的页面
    @RequestMapping("/addGo")
    public String goAdd(){
        return "/${table_name?uncap_first}/${table_name?uncap_first}AddGo";
    }

    //添加员工
    @RequestMapping(value="/add", method= RequestMethod.POST)
    @ResponseBody
    public Msg add${table_name}(${table_name} ${table_name?uncap_first}){
        ${table_name?uncap_first}Service.save(${table_name?uncap_first});
        return Msg.success();
    }

    //删除元素
    @RequestMapping(value="/batchDelete/{ids}")
    @ResponseBody
    public Msg delete${table_name}(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains(",")){
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split(",");
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            ${table_name?uncap_first}Service.deleteBatch(del_ids);
        }else{
            //删除一个
            Integer id = Integer.parseInt(ids);
            ${table_name?uncap_first}Service.delete(id);
        }
        return Msg.success();
    }



    //修改员工数据
    @RequestMapping(value="/update", method= RequestMethod.POST)
    @ResponseBody
    public Msg editEmp(@RequestBody ${table_name} ${table_name?uncap_first}){
        ${table_name?uncap_first}Service.update(${table_name?uncap_first});
        return Msg.success();
    }
    //批量修改员工数据
    @RequestMapping(value="/batchUpdate", method= RequestMethod.POST)
    @ResponseBody
    public Msg ${table_name?uncap_first}BatchUpdate(@RequestBody List<${table_name}> list){
        ${table_name?uncap_first}Service.${table_name?uncap_first}BatchUpdate(list);
        return Msg.success();
    }


    //导出excel  前端不能使用ajax，ajax是字符流，不是字节流，后端传输不了前端
    @RequestMapping(value="/exportExcel")
    @ResponseBody
    public Msg exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception, IOException {
        ByteArrayOutputStream os = new ByteArrayOutputStream();

        // 测试学生
        ExportExcel<${table_name}> ex = new ExportExcel<${table_name}>();
        String[] headers =
        { <#list model_column as model>"${model.columnComment}"<#if model_has_next>, </#if></#list> };

        List<${table_name}> dataset = ${table_name?uncap_first}Service.getAll();

        try
        {
            //指定特定路径
            //OutputStream out = new FileOutputStream("E://a_all.xls");

            //弹出下载框
            response.setHeader("Content-Disposition", "attachment; filename=appointmentUser.xls");
            response.setContentType("application/vnd.ms-excel; charset=utf-8") ;
            OutputStream out = response.getOutputStream() ;

            //这个方法主要需要的是这句代码  workbook.write(out);
            ex.exportExcel(headers, dataset, out, ${table_name}.class);
            out.flush();
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return Msg.success();
    }

    //导出本页excel
    @RequestMapping("/exportExcelOnly")
    @ResponseBody
    public Msg exportExcelOnly(HttpServletResponse response ,@RequestParam(value="startRow") Integer startRow,
                                @RequestParam(value="limit") Integer limit) throws IllegalAccessException, InstantiationException {
        // 测试学生
        ExportExcel<${table_name}> ex = new ExportExcel<${table_name}>();
        String[] headers =
        { <#list model_column as model>"${model.columnComment}"<#if model_has_next>, </#if></#list> };
        List<${table_name}> dataset = ${table_name?uncap_first}Service.getPart(startRow, limit);
        try
        {
            //OutputStream out = new FileOutputStream("E://a_part.xls");

            //弹出下载框
            response.setHeader("Content-Disposition", "attachment; filename=appointmentUser.xls");
            response.setContentType("application/vnd.ms-excel; charset=utf-8") ;
            OutputStream out = response.getOutputStream() ;
            ex.exportExcel(headers, dataset, out, ${table_name}.class);
            out.close();
            //JOptionPane.showMessageDialog(null, "导出成功!");
            //System.out.println("excel导出成功！");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Msg.success();
    }


    //导入excel
    @RequestMapping("importExcel2")
    @ResponseBody
    public Msg importExcel2(@RequestParam("file") MultipartFile file) throws Exception {
         //此时的Workbook应该是从 客户端浏览器上传过来的 uploadFile了,其实跟读取本地磁盘的一个样
        //POIFSFileSystem fs=new POIFSFileSystem(new FileInputStream("e:/a_part.xls"));
        POIFSFileSystem fs=new POIFSFileSystem(file.getInputStream());
        HSSFWorkbook wb=new HSSFWorkbook(fs);
        HSSFSheet hssfSheet=wb.getSheetAt(0);

        //将excel转换为列表 java实体
        List<${table_name}> listE = getEntityFromSheet(hssfSheet,${table_name}.class );

        try {
            ${table_name?uncap_first}Service.insertBatch(listE);
        }catch (Exception e){
            Msg msg = new Msg();
            msg.add("error1",e.getMessage());
            return msg;
        }
        return Msg.success();
    }
}
