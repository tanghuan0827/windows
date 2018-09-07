package com.lvoyee.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lvoyee.crud.bean.Employee;
import com.lvoyee.crud.bean.Msg;
import com.lvoyee.crud.service.EmployeeService;
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
import javax.swing.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static com.lvoyee.crud.utils.ImportExcel2.getEntityFromSheet;

//spring对于对象的传递，只能ajax json串的形式
//modelAttribute不会使用
//关于form表单提交不了 input button submit之间的区别

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    //分页显示的条数是10

    @RequestMapping("/")
    public String index2(){
        return "index2";
    }

    //查询所有的员工信息
    @RequestMapping("/employeeList")
    public ModelAndView getAll(@RequestParam(value="pn", defaultValue="1") Integer pn){
        PageHelper.startPage(pn, 10);
        List<Employee> emps = employeeService.getAll();

        PageInfo page = new PageInfo(emps, 5);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/employee/employeeList");
        mv.addObject("pageInfo", page);
        return mv;
    }

    //到添加employee的页面
    @RequestMapping("/employeeAddGo")
    public ModelAndView goAdd(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/employee/employeeAddGo");
        return mv;
    }

    //添加员工
    @RequestMapping(value="/employeeAdd")
    public String addEmp(Employee employee){
        employeeService.save(employee);
        return "redirect:/employeeList";
    }

    //删除元素
    @RequestMapping(value="/employeeBatchDelete/{ids}")
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains(",")){
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split(",");
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            //删除一个
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    //根据id查找员工信息
    @RequestMapping(value="/employee/{id}")
    public ModelAndView getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/employee/employee");
        mv.addObject("employee", employee);
        return mv;
    }

//    //跳转到修改员工的页面
//    @RequestMapping(value="/employeeUpdateGo/{empId}")
//    public ModelAndView editEmp(@PathVariable("id") Integer id){
//        Employee employee = employeeService.getEmp(id);
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("/employee/employeeUpdateGo");
//        mv.addObject("employee", employee);
//        return mv;
//    }

    //修改员工数据
    @RequestMapping(value="/employeeUpdate", method= RequestMethod.POST)
    @ResponseBody
    public Msg editEmp(@RequestBody Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    //批量修改员工数据
    @RequestMapping(value="/employeeBatchUpdate", method= RequestMethod.POST)
    @ResponseBody
    public Msg employeeBatchUpdate(@RequestBody List<Employee> list){
        employeeService.employeeBatchUpdate(list);
        return Msg.success();
    }


    //导出excel  前端不能使用ajax，ajax是字符流，不是字节流，后端传输不了前端
    @RequestMapping(value="/exportExcel")
    @ResponseBody
    public Msg exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception, IOException {
        ByteArrayOutputStream os = new ByteArrayOutputStream();

        // 测试学生
        ExportExcel<Employee> ex = new ExportExcel<Employee>();
        String[] headers =
        { "学号", "姓名", "性别", "邮箱", "部门编号" };

        List<Employee> dataset = employeeService.getAll();

        try
        {
            //指定特定路径
            //OutputStream out = new FileOutputStream("E://a_all.xls");

            //弹出下载框
            response.setHeader("Content-Disposition", "attachment; filename=appointmentUser.xls");
            response.setContentType("application/vnd.ms-excel; charset=utf-8") ;
            OutputStream out = response.getOutputStream() ;

            //这个方法主要需要的是这句代码  workbook.write(out);
            ex.exportExcel(headers, dataset, out);
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
        ExportExcel<Employee> ex = new ExportExcel<Employee>();
        String[] headers =
        { "学号", "姓名", "性别", "邮箱", "部门编号" };
        List<Employee> dataset = employeeService.getPart(startRow, limit);
        try
        {
            //OutputStream out = new FileOutputStream("E://a_part.xls");

            //弹出下载框
            response.setHeader("Content-Disposition", "attachment; filename=appointmentUser.xls");
            response.setContentType("application/vnd.ms-excel; charset=utf-8") ;
            OutputStream out = response.getOutputStream() ;
            ex.exportExcel(headers, dataset, out);
            out.close();
            JOptionPane.showMessageDialog(null, "导出成功!");
            System.out.println("excel导出成功！");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Msg.success();
    }

    //导入excel
    @RequestMapping("importExcel")
    @ResponseBody
    public Msg importExcel() throws Exception {
         //此时的Workbook应该是从 客户端浏览器上传过来的 uploadFile了,其实跟读取本地磁盘的一个样
        POIFSFileSystem fs=new POIFSFileSystem(new FileInputStream("e:/a_part.xls"));
        HSSFWorkbook wb=new HSSFWorkbook(fs);
        HSSFSheet hssfSheet=wb.getSheetAt(0);

        //将excel转换为列表 java实体
        List<Employee> listE = getEntityFromSheet(hssfSheet);

        try {
            employeeService.insertBatch(listE);
        }catch (Exception e){
            Msg msg = new Msg();
            msg.add("error1",e.getMessage());
            return msg;
        }
        return Msg.success();
    }
    //导入excel
    @RequestMapping("importExcel2")
    @ResponseBody
    public Msg importExcel2(@RequestParam("file") MultipartFile file) throws Exception {
         //此时的Workbook应该是从 客户端浏览器上传过来的 uploadFile了,其实跟读取本地磁盘的一个样
        POIFSFileSystem fs=new POIFSFileSystem(file.getInputStream());
        HSSFWorkbook wb=new HSSFWorkbook(fs);
        HSSFSheet hssfSheet=wb.getSheetAt(0);

        //将excel转换为列表 java实体
        List<Employee> listE = getEntityFromSheet(hssfSheet);

        try {
            employeeService.insertBatch(listE);
        }catch (Exception e){
            Msg msg = new Msg();
            msg.add("error1",e.getMessage());
            return msg;
        }
        return Msg.success();
    }
}
