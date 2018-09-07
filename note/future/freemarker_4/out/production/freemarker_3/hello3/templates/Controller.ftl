package ${package_name};

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${package_name}.bean.Department;
import ${package_name}.bean.${table_name};
import ${package_name}.bean.Msg;
import ${package_name}.service.DepartmentService;
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

    //跳转到指定的页面 ，增加或者修改页面， way url中的操作参数
    @RequestMapping("/page/{index}")
    public ModelAndView index(@PathVariable String index, @RequestParam(defaultValue = "") String way, @RequestParam(defaultValue = "0") Integer <#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>){
        ModelAndView mv = new ModelAndView("/${table_name?uncap_first}/"+index);

        //带入修改还是删除的参数 url
        mv.addObject("way", way);
        ${table_name} ${table_name?uncap_first} =new ${table_name}();

        //如果是更新，就需要更新的数据
        if(way.equals("update")){
            ${table_name?uncap_first} = ${table_name?uncap_first}Service.get(<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>);
            mv.addObject("${table_name?uncap_first}", ${table_name?uncap_first});
        }
        return mv;
    }

    //查询所有的员工信息 将部门信息带过去
    @RequestMapping("/list")
    public ModelAndView getAll2(@RequestParam(value="pn", defaultValue="1") Integer pn){
        PageHelper.startPage(pn, 10);
        //emoloyee中有部门信息了
        List<${table_name}> ${table_name?uncap_first}List = ${table_name?uncap_first}Service.getAll();

        PageInfo page = new PageInfo(${table_name?uncap_first}List, 5);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/${table_name?uncap_first}/${table_name?uncap_first}List");
        mv.addObject("pageInfo", page);
        return mv;
    }

    //查询所有的员工信息 使用了ajax请求
    @RequestMapping("/listX")
    @ResponseBody
    public Msg getAllX(@RequestParam(value="pn", defaultValue="1") Integer pn){
        PageHelper.startPage(pn, 10);
        List<${table_name}> ${table_name?uncap_first}List = ${table_name?uncap_first}Service.getAll();

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

    //删除元素
    @RequestMapping(value="/batchDelete/{ids}")
    public String delete${table_name}(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains(",")){
            List<Integer> ids2 = new ArrayList<Integer>();
            String[] str_ids = ids.split(",");
            for(String string:str_ids){
                ids2.add(Integer.parseInt(string));
            }
            ${table_name?uncap_first}Service.deleteBatch(ids2);
        }else{
            //删除一个
            Integer id = Integer.parseInt(ids);
            ${table_name?uncap_first}Service.delete(id);
        }
        return "redirect:/${table_name?uncap_first}/list";
    }

    //根据id查找员工信息， 这里没有使用，在第一个方法修改中 就查询了员工信息 带入页面了
    @RequestMapping(value="/{id}")
    public ModelAndView get${table_name}(@PathVariable("id") Integer id){
        ${table_name} ${table_name?uncap_first} = ${table_name?uncap_first}Service.get(id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/${table_name?uncap_first}/${table_name?uncap_first}");
        mv.addObject("${table_name?uncap_first}", ${table_name?uncap_first});
        return mv;
    }

    //修改员工数据
    @RequestMapping(value="/update", method= RequestMethod.POST)
    public String editEmp( ${table_name} ${table_name?uncap_first}){
        ${table_name?uncap_first}Service.update(${table_name?uncap_first});
        return "redirect:/${table_name?uncap_first}/list";
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

            //导出这个类对应的属性内容（包括对象属性）
            List<String> listField = new ArrayList<String>();
        <#list model_column as model>
            listField.add("${model.changeColumnName?uncap_first}");
        </#list>

            //导出的其他对象的其他属性
            Map<Class, String> mapOther = new HashMap<Class,String>();
            mapOther.put(Department.class, "deptName");

            //这个方法主要需要的是这句代码  workbook.write(out);
            ex.exportExcel(headers, dataset, out, ${table_name}.class, mapOther ,listField);
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
            response.setHeader("Content-Disposition", "attachment; filename=${table_name?uncap_first}.xls");
            response.setContentType("application/vnd.ms-excel; charset=utf-8") ;
            OutputStream out = response.getOutputStream() ;

            //导出这个类对应的属性内容（包括对象属性）
            List<String> listField = new ArrayList<String>();
            <#list model_column as model>
                listField.add("${model.changeColumnName?uncap_first}");
            </#list>

            //导出的其他对象的其他属性
            Map<Class, String> mapOther = new HashMap<Class,String>();
            //mapOther.put(Department.class, "deptName");

            ex.exportExcel(headers, dataset, out, ${table_name}.class, mapOther ,listField);
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


        //将excel转换为列表 java实体, 关于键值对的转换
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
