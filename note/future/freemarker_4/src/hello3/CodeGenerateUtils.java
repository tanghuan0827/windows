package hello3;

import freemarker.template.Template;

import org.apache.commons.lang3.StringUtils;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CodeGenerateUtils {

    public CodeGenerateUtils() throws Exception {
    }

    Connection connection = getConnection();
    DatabaseMetaData databaseMetaData =  connection.getMetaData();

    private final String AUTHOR = "Ay";
    private final String CURRENT_DATE = "2017/05/03";
    private  String tableName = "tbl_dept";
    private final String packageName = "com.lvoyee.crud";
    private  String tableAnnotation = "";
    private final String URL = "jdbc:mysql://localhost:3306/future_price";
    private final String USER = "root";
    private final String PASSWORD = "123456";
    private final String DRIVER = "com.mysql.jdbc.Driver";
    private final String panPath = "D:";
    //private final String panPath = "E:\\intellij_mine\\employ_model\\src\\main\\java\\";
    private final String packagePath = packageName.replace(".","\\");
    private final String diskPath = panPath+packagePath+"\\";
    private  String authorTableName = "Department";
    private  String changeTableName = authorTableName.length()>0?authorTableName:replaceUnderLineAndUpperCase(tableName);

    public Connection getConnection() throws Exception{
        Class.forName(DRIVER);
        Connection connection= DriverManager.getConnection(URL, USER, PASSWORD);
        return connection;
    }

    public static void main(String[] args) throws Exception{

        CodeGenerateUtils codeGenerateUtils = new CodeGenerateUtils();
        codeGenerateUtils.generate();
    }

    /**获取数据库中所有表名称
	 * @param conn
	 * @return
	 * @throws SQLException
	 */
	private static List<String> getTables(Connection conn) throws SQLException {
		DatabaseMetaData databaseMetaData = conn.getMetaData();
		ResultSet tables = databaseMetaData.getTables(null, null, "%", null);
		ArrayList<String> tablesList = new ArrayList<String>();
		while (tables.next()) {
			tablesList.add(tables.getString("TABLE_NAME"));
		}
		return tablesList;
	}


    //入口，生成文件的入口
    public void generate() throws Exception{
        try {
            Connection connection = getConnection();
            DatabaseMetaData dm=  connection.getMetaData();
            //获取所有的表名
            List<String> tableList = getTables(connection);
            for(String tbName:tableList) {
                tableName = tbName;
                authorTableName = tbName.substring(tbName.indexOf("_")+1);
                authorTableName = replaceUnderLineAndUpperCase(authorTableName);
                changeTableName = authorTableName;
                ResultSet resultSet = dm.getColumns(null, "%", tbName, "%");

                generateAllKindsFile(resultSet);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{

        }
    }

    //除了model文件外，其他类型的文件都生成了，template的文件路径为 hello3/templates
    private void generateAllKindsFile(ResultSet resultSet) throws Exception {
        Map<String,String> map=new HashMap<String,String>();
        //形成什么类型的文件， 什么模板templateName
        map.put("Controller.java","Controller.ftl");
        map.put("ServiceImpl.java","Service.ftl");
        map.put("Service.java","ServiceInterface.ftl");
        map.put("Mapper.java","Repository.ftl");
        map.put("Mapper.xml","Mapper.ftl");
        map.put(".java","Model.ftl");
        map.put(".js","Js.ftl");
        map.put("Go.jsp","GoJsp.ftl");
        map.put("List.jsp","ListJsp.ftl");
        map.put("Msg.java","Msg.ftl");

        //model和mapper.xml文件都需要实体的属性
        //如果是实体文件model,就需要获取各个属性的值
        //ResultSet不能遍历两次，否则第二次size就为0
        List<ColumnClass> columnClassList = getColumnClassList(resultSet);
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("model_column",columnClassList);

        for(Map.Entry<String,String> entry:map.entrySet()){
            String key = entry.getKey();
            String[] arr =key.split("\\.");
            String type=arr[0];
            String templateName = entry.getValue();

            //形成文件的最终路径
            String dir = "";
            String path="";

            //关于service需要特殊处理
            if(key.contains("Impl")) {
                //关于serviceImpl实体
                dir = diskPath + "service//impl//";

            }else if(key.indexOf(".java")==0){
                //关于model实体 ,bean为实体类的文件名
                dir = diskPath+"bean";
            }else if(key.equals(".js")){
                //关于model实体 ,bean为实体类的文件名
                dir = diskPath+"js";
            }else if(key.indexOf("Mapper.java")>-1){
                //关于model实体 ,bean为实体类的文件名
                dir = diskPath+"dao";
            }else if(key.indexOf("Mapper.xml")>-1){
                //关于model实体 ,bean为实体类的文件名
                dir = diskPath+"mapper";
            }else if(key.indexOf("jsp")>-1){
                //关于model实体 ,bean为实体类的文件名
                dir = diskPath+"jsp"+"//"+changeTableName.substring(0,1).toLowerCase()+changeTableName.substring(1);

            }else{
                dir = diskPath+type.toLowerCase();
            }

            String fileName =changeTableName;
            //js文件名为小写的
            if(key.indexOf(".js")>-1){
                fileName= changeTableName.substring(0,1).toLowerCase()+changeTableName.substring(1);
            }
            //特殊的类Msg, 查看
            if(templateName.indexOf("Msg")>-1){
                fileName="";
            }

            path = dir + "\\" + fileName + key;
            //形成文件夹
            File dirFile = new File(dir);
            if(!dirFile.exists()){
                 dirFile.mkdirs();
            }
            File file = new File(path);

            //创建文件
            if(!file.exists())
            {
                try {
                    file.createNewFile();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

            dataMap.put("file_name", fileName);

            generateFileByTemplate(templateName,file,dataMap);
        }
    }

    //获取model实体各个属性的性质
    private List<ColumnClass> getColumnClassList(ResultSet resultSet) throws SQLException {
        List<ColumnClass> columnClassList = new ArrayList<>();
        ColumnClass columnClass = null;
        while(resultSet.next()){
            String columnName = resultSet.getString("COLUMN_NAME");
            System.out.println(columnName);
            //id字段略过
            columnClass = new ColumnClass();
            if(resultSet.getString("COLUMN_NAME").equalsIgnoreCase("id")){
                //获取id字段名称
                columnClass.setColumnName(resultSet.getString("COLUMN_NAME").toLowerCase());
            }else{

                //获取字段名称
                columnClass.setColumnName(resultSet.getString("COLUMN_NAME"));
            }
            //获取字段类型 ,字段类型需要变成小写，否则在模板中不正确，生成不了
            columnClass.setColumnType(resultSet.getString("TYPE_NAME").toLowerCase());

            //转换字段名称，如 sys_name 变成 SysName
            if(resultSet.getString("COLUMN_NAME").equalsIgnoreCase("id")){
                //获取id字段名称
                columnClass.setChangeColumnName("Id");
            }else{
                //获取字段名称
                columnClass.setChangeColumnName(replaceUnderLineAndUpperCase(resultSet.getString("COLUMN_NAME")));
            }
            //字段在数据库的注释
            columnClass.setColumnComment(resultSet.getString("REMARKS"));
            columnClassList.add(columnClass);
        }
        return columnClassList;
    }

    //根据模板生成文件
    private void generateFileByTemplate(final String templateName,File file,Map<String,Object> dataMap) throws Exception{
        Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
        FileOutputStream fos = new FileOutputStream(file);
        dataMap.put("table_name_small",tableName);

        //可能需要修改表的名字
        dataMap.put("table_name",changeTableName);
        dataMap.put("tb_simple_name", changeTableName.substring(0,1).toLowerCase());

        dataMap.put("tb_table_name", tableName);
        dataMap.put("author",AUTHOR);
        dataMap.put("date",CURRENT_DATE);
        dataMap.put("package_name",packageName);
        dataMap.put("table_annotation",tableAnnotation);
        Writer out = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"),10240);
        template.process(dataMap,out);
    }

    //将横线去掉，并且横线后面的第一个字母大写
    public String replaceUnderLineAndUpperCase(String str){
        StringBuffer sb = new StringBuffer();
        sb.append(str);
        int count = sb.indexOf("_");
        while(count!=0){
            int num = sb.indexOf("_",count);
            count = num + 1;
            if(num != -1){
                char ss = sb.charAt(count);
                char ia = (char) (ss - 32);
                sb.replace(count , count + 1,ia + "");
            }
        }
        String result = sb.toString().replaceAll("_","");
        return StringUtils.capitalize(result);
    }
}
