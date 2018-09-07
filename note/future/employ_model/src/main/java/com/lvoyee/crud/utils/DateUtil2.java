package com.lvoyee.crud.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 数据库链接工具
 * @author 钟林森
 *
 */
public class DateUtil2 {

    public static String formatDate(Date date,String format){
        String result="";
        SimpleDateFormat sdf=new SimpleDateFormat(format);
        if(date!=null){
            result=sdf.format(date);
        }
        return result;
    }


    public static Date formatString(String str, String format) throws Exception{
        SimpleDateFormat sdf=new SimpleDateFormat(format);
        return sdf.parse(str);
    }

    public static void main(String[] args) throws Exception{
        Date date=formatString("1993/10/12", "yyyy/MM/dd");
        String str=formatDate(date, "yyyy-MM-dd");
        System.out.println(str);
    }
}
