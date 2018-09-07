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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <form id="formAdd${table_name}" action="<#noparse>$</#noparse>{APP_PATH}/${table_name?uncap_first}/<#noparse>$</#noparse>{way}" method="post">
            <input type="hidden" name="<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>" value="<#noparse>$</#noparse>{${table_name?uncap_first}.<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>}">

                <#list model_column as model>
                <#if !(model_index =0)>
                    ${model.columnComment}:<input type="text" name="${model.changeColumnName?uncap_first}" value="<#noparse>$</#noparse>{${table_name?uncap_first}.${model.changeColumnName?uncap_first}}"><br>
                </#if>
                </#list>
                <%--部门:&nbsp;<select name="dId" style="width:170px;margin:8px;">
                <c:choose>
                    <c:when test="<#noparse>$</#noparse>{fn:length(${table_name?uncap_first}.department.deptName)>0}">
                        <option value="<#noparse>$</#noparse>{${table_name?uncap_first}.dId}"><#noparse>$</#noparse>{${table_name?uncap_first}.department.deptName}</option>
                    </c:when>
                    <c:otherwise>
                        <option >-----请选择部门-----</option>
                    </c:otherwise>
                </c:choose>
                        <c:forEach items="<#noparse>$</#noparse>{departmentList}" var="department">
                            <c:if test="<#noparse>$</#noparse>{${table_name?uncap_first}.department.deptName!= department.deptName}">
                                <option value="<#noparse>$</#noparse>{department.deptId}"><#noparse>$</#noparse>{department.deptName}</option>
                            </c:if>
                        </c:forEach>
                </select><br> --%>
                &emsp;&emsp;&emsp;<input type="submit" value="提    交" >
        </form>
    </div>
</body>
<script src="<#noparse>$</#noparse>{APP_PATH}/js/${table_name?uncap_first}.js">

</script>
</html>
