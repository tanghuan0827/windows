<%--
  Created by IntelliJ IDEA.
  User: tanghuan
  Date: 2018/2/25
  Time: 17:56
  To change this template use File | Settings | File Templates.
--%>
<%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="<#noparse>$</#noparse>{APP_PATH}/js/jquery-1.12.4.min.js" type="text/javascript">
    </script>
</head>
<style>
    input{
        margin:10px;
    }
</style>
<body>
    <div style="margin-left:50px;margin-top:30px;">
        <form id="formAdd${table_name}">
        <#list model_column as model>
        <#if !(model_index =0)>
            ${model.columnComment}:<input type="text" name="${model.changeColumnName?uncap_first}"><br>
        </#if>
        </#list>
            <input type="button" value="提交" class="add${table_name}">
        </form>
    </div>
</body>
<script src="<#noparse>$</#noparse>{APP_PATH}/js/${file_name}.js">

</script>
</html>
