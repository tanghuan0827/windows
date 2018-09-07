package com.hello;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 获取所有的日期
 */

public class GetAllDateUtils
{

 public static List<String> getAllDate(String start, String end) throws Exception
 {
  // "2012-02-01";
    //"2012-03-02";
  Calendar cal = Calendar.getInstance();

  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  Date dBegin = sdf.parse(start);
  Date dEnd = sdf.parse(end);
  List<Date> lDate = findDates(dBegin, dEnd);
  List<String> list=new ArrayList<>();
  for (Date date : lDate)
  {
   list.add(sdf.format(date));
  }
  return list;
 }

 public static List<Date> findDates(Date dBegin, Date dEnd)
 {
  List lDate = new ArrayList();
  lDate.add(dBegin);
  Calendar calBegin = Calendar.getInstance();
  // 使用给定的 Date 设置此 Calendar 的时间
  calBegin.setTime(dBegin);
  Calendar calEnd = Calendar.getInstance();
  // 使用给定的 Date 设置此 Calendar 的时间
  calEnd.setTime(dEnd);
  // 测试此日期是否在指定日期之后
  while (dEnd.after(calBegin.getTime()))
  {
   // 根据日历的规则，为给定的日历字段添加或减去指定的时间量
   calBegin.add(Calendar.DAY_OF_MONTH, 1);
   lDate.add(calBegin.getTime());
  }
  return lDate;
 }
}