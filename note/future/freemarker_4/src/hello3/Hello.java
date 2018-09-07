package hello3;

import java.sql.*;

public class Hello {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        String m_TableName="ay_test";
        //1. JDBC连接MYSQL的代码很标准。
        Class.forName("com.mysql.jdbc.Driver") ;
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/mybatis_freemarker?","root","123456");

        //2. 下面就是获取表的信息。
        DatabaseMetaData dm=  conn.getMetaData();
        ResultSet tableRet = dm.getTables(null, "%",m_TableName,new String[]{"TABLE"});
        /*其中"%"就是表示*的意思，也就是任意所有的意思。其中m_TableName就是要获取的数据表的名字，如果想获取所有的表的名字，就可以使用"%"来作为参数了。*/

        //3. 提取表的名字。
        while(tableRet.next()) {
        System.out.println(tableRet.getString("TABLE_NAME"));
        };
        /*通过getString("TABLE_NAME")，就可以获取表的名字了。
        从这里可以看出，前面通过getTables的接口的返回，JDBC是将其所有的结果，保存在一个类似table的内存结构中，而其中TABLE_NAME这个名字的字段就是每个表的名字。*/

        //4. 提取表内的字段的名字和类型
        String columnName;
        String columnType;
        ResultSet rs = dm.getColumns(null,"%", m_TableName,"%");
        while(rs.next()) {
            columnName = rs.getString("COLUMN_NAME");
            columnType = rs.getString("TYPE_NAME");
            int datasize = rs.getInt("COLUMN_SIZE");
            int digits = rs.getInt("DECIMAL_DIGITS");
            int nullable = rs.getInt("NULLABLE");
            System.out.println(columnName+" "+columnType+" "+datasize+" "+digits+" "+ nullable);
        }
    }
}
