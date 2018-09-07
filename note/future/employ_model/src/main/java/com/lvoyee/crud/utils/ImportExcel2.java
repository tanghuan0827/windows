package com.lvoyee.crud.utils;

import com.lvoyee.crud.bean.Employee;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class ImportExcel2 {
    public static List<Employee> getEntityFromSheet(HSSFSheet hssfSheet) throws Exception {
        List list = new ArrayList();
        if(hssfSheet!=null){
            //遍历excel,从第二行开始 即 rowNum=1,逐个获取单元格的内容,然后进行格式处理,最后插入数据库
            for(int rowNum=1;rowNum<=hssfSheet.getLastRowNum();rowNum++){
                HSSFRow hssfRow=hssfSheet.getRow(rowNum);
                if(hssfRow==null){
                    continue;
                }

                //获取基本的类型
                Field[] fields = Employee.class.getDeclaredFields();
                List<Field> list3 = ExportExcel.getBasicFields(fields);

                //将每一行的数据填充到实体类中(利用反射)
                Employee employee =Employee.class.newInstance();
                for(int i=0;i<list3.size();i++){
                    Field field = list3.get(i);
                    String type2 = field.getGenericType().toString();

                    field.setAccessible(true);
                    String excelValue =ExcelUtil2.formatCell4(type2, hssfRow.getCell(i));
                    //对于日期需要特殊处理
                    //反射注入值 使用set注入值
                    if(type2.equals("class java.util.Date")) {
                        field.set(employee, DateUtil2.formatString(excelValue, "yyyy-MM-dd"));
                    }else if(type2.equals("class java.lang.Integer")){
                        //注意integer值和double值之间的转换
                        field.set(employee, Integer.parseInt( excelValue));
                    }else if(type2.equals("class java.lang.Double")){
                        field.set(employee, Double.parseDouble( excelValue));
                    }else if(type2.equals("class java.lang.Boolean")){
                        field.set(employee, Boolean.parseBoolean( excelValue));
                    }else if(type2.equals("class java.lang.Short")){
                        field.set(employee, Short.parseShort( excelValue));
                    }else if(type2.equals("class java.lang.String")){
                        field.set(employee, excelValue);
                    }else if(type2.equals("class java.lang.Char")) {
                        field.set(employee, excelValue);
                    }
                }
                list.add(employee);
            }
        }
        return list;
    }
}
