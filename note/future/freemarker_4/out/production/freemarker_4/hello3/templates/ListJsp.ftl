<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="<#noparse>$</#noparse>{APP_PATH}/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="<#noparse>$</#noparse>{APP_PATH}/css/style2.css" rel="stylesheet" type="text/css"/>
    <style>

    </style>
    <script src="<#noparse>$</#noparse>{APP_PATH}/js/jquery-1.12.4.min.js" type="text/javascript">
    </script>
</head>
<body>
<div id="div0" style="width: 1500px;">
    <form id="formSearch" action="<#noparse>$</#noparse>{APP_PATH}/${table_name?uncap_first}/list" method="post">
        <table>
        <#list model_column as model>
            <#if (model_index%4=0)>
                <tr>
            </#if>
            <td>${model.columnComment}:</td><td><input name="${model.changeColumnName?uncap_first}"></td>
            <#if (model_index%4=3)>
                </tr>
            </#if>
        </#list>
        </table>
        <input type="submit" value="提    交" >
    </form>
</div>
<div class="div1">
    <input type="button" value="添加员工" onclick="goTo('<#noparse>$</#noparse>{APP_PATH}/${table_name?uncap_first}/page/${table_name?uncap_first}Go?way=add');" style="margin：15px;">
    <input type="button" value="反选" class="opposite${table_name}" >
    <input type="button" value="批量删除" class="deleteBatch${table_name}">
    <input type="button" value="批量修改" class="updateBatch${table_name}">
    <input type="button" value="批量保存" class="saveBatch${table_name}">
    <input type="button" value="excel导出本页" class="exportExcelOnly${table_name}">
    <input type="button" value="excel全部导出" class="exportExcelAll${table_name}">
</div>
<form style="margin-left:20px;margin-bottom: 20px" id="uploadForm" action="<#noparse>$</#noparse>{APP_PATH}/${table_name?uncap_first}/importExcel2" enctype="multipart/form-data" method="post">
    <input type="file" name="file">
    <input type="button" class="upload${table_name}" value="上传Excel">
</form>
<!--<input type="button" value="excel导入" class="importExcel">-->
    <#if (model_column?size > 10)>
<table style="border:1px solid <#noparse>#</#noparse>CCC;width:1600px" id="hor-zebra"  summary="${table_name} Pay Sheet">
    <#else>
<table style="border:1px solid <#noparse>#</#noparse>CCC;width:1000px" id="hor-zebra"  summary="${table_name} Pay Sheet">
    </#if>
    <thead>
        <tr >
            <td><input type="checkbox" class="all${table_name}" name="itemF"></td>
        <#list model_column as model>
            <th>${model.columnComment}</th>
        </#list>
            <th >操作</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="<#noparse>$</#noparse>{pageInfo.list}" var="${table_name?uncap_first}" varStatus="status">
            <c:choose>
                <c:when test="<#noparse>$</#noparse>{status.count %2 ==0}">
                    <tr >
                </c:when>
                <c:otherwise>
                    <tr class="odd">
                </c:otherwise>
            </c:choose>
                <td><input type="checkbox" name="item"  value="<#noparse>$</#noparse>{${table_name?uncap_first}.<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>}"></td>
            <#list model_column as model>
                <#if (model.columnType = 'timestamp'|| model.columnType = 'datetime')>
                    <td name="${model.changeColumnName?uncap_first}"><fmt:formatDate value="<#noparse>$</#noparse>{${table_name?uncap_first}.${model.changeColumnName?uncap_first}}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <#else>
                    <td name="${model.changeColumnName?uncap_first}"><#noparse>$</#noparse>{${table_name?uncap_first}.${model.changeColumnName?uncap_first}}</td>
                </#if>
            </#list>
                <td>
                    <a  href="<#noparse>$</#noparse>{APP_PATH}/${table_name?uncap_first}/page/${table_name?uncap_first}Go?way=update&<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>=<#noparse>$</#noparse>{${table_name?uncap_first}.<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>}">修改</a>
                    &nbsp;
                    <a   href="<#noparse>$</#noparse>{APP_PATH}/${table_name?uncap_first}/batchDelete/<#noparse>$</#noparse>{${table_name?uncap_first}.<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>}">删除</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

    <div style="margin-left:100px;">
        &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<input type="hidden" value="<#noparse>$</#noparse>{pageInfo.pageSize}" class="pageSize">
                <input type="hidden" value="<#noparse>$</#noparse>{pageInfo.pageNum}" class="pageNum">
                <!--当前页有多少条-->
                <input type="hidden" value="<#noparse>$</#noparse>{pageInfo.size}" class="size">
        &emsp;&emsp;&emsp;<br>
        当前&emsp;<#noparse>$</#noparse>{pageInfo.pageNum }&emsp;页,&emsp;总&emsp;<#noparse>$</#noparse>{pageInfo.pages }&emsp;页,&emsp;总&emsp;<#noparse>$</#noparse>{pageInfo.total }&emsp;条记录
					<!-- 分页条信息 -->

        &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <a href="<#noparse>$</#noparse>{APP_PATH }/${table_name?uncap_first}/list?pn=1">首页</a>&emsp;

        <c:if test="<#noparse>$</#noparse>{pageInfo.hasPreviousPage }">
            <a href="<#noparse>$</#noparse>{APP_PATH }/${table_name?uncap_first}/list?pn=<#noparse>$</#noparse>{pageInfo.pageNum-1}"
                > <span aria-hidden="true">&laquo;</span>
            </a>&emsp;
        </c:if>


        <c:forEach items="<#noparse>$</#noparse>{pageInfo.navigatepageNums }" var="page_Num">
            <c:if test="<#noparse>$</#noparse>{page_Num == pageInfo.pageNum }">
                <B style="color:royalblue"><#noparse>$</#noparse>{page_Num }</B>&emsp;
            </c:if>

            <c:if test="<#noparse>$</#noparse>{page_Num != pageInfo.pageNum }">
                <a href="<#noparse>$</#noparse>{APP_PATH }/${table_name?uncap_first}/list?pn=<#noparse>$</#noparse>{page_Num }"><#noparse>$</#noparse>{page_Num }</a>&emsp;
            </c:if>

        </c:forEach>
        <c:if test="<#noparse>$</#noparse>{pageInfo.hasNextPage }">
            <a href="<#noparse>$</#noparse>{APP_PATH }/${table_name?uncap_first}/list?pn=<#noparse>$</#noparse>{pageInfo.pageNum+1 }"
                aria-label="Next"> <span aria-hidden="true">&raquo;</span>
            </a>&emsp;
        </c:if>
        <a href="<#noparse>$</#noparse>{APP_PATH }/${table_name?uncap_first}/list?pn=<#noparse>$</#noparse>{pageInfo.pages}">末页</a>
    </div>



<script src="<#noparse>$</#noparse>{APP_PATH}/js/${table_name?uncap_first}.js">

</script>
</body>
</html>