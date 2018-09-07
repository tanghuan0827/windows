<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="${APP_PATH}/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${APP_PATH}/css/style2.css" rel="stylesheet" type="text/css"/>
    <style>

    </style>
    <script src="${APP_PATH}/js/jquery-1.12.4.min.js"  type="text/javascript">
    </script>
</head>
<body>
<div class="div1">
    <input type="button" value="反选" class="opposite" style="margin：15px">
    <input type="button" value="批量删除" class="deleteBatch">
    <input type="button" value="批量修改" class="updateBatch">
    <input type="button" value="批量保存" class="saveBatch">
    <input type="button" value="excel导出本页" class="exportExcelOnly">
    <input type="button" value="excel全部导出" class="exportExcelAll">
</div>
<form style="margin-left:20px;margin-bottom: 20px" id="uploadForm" action="${APP_PATH}/employee/importExcel2" enctype="multipart/form-data" method="post">
    <input type="file" name="file">
    <input type="button" class="upload" value="上传Excel">
</form>



<!--<input type="button" value="excel导入" class="importExcel">-->

<table style="border:1px solid #CCC;width:1000px" id="hor-zebra"  summary="Employee Pay Sheet">

    <thead>
        <tr >
            <td><input type="checkbox" class="all"></td>
            <th >序号</th>
            <th >姓名</th>
            <th >性别</th>
            <th >邮箱</th>
            <th >部门</th>
            <th >操作</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${pageInfo.list}" var="employee" varStatus="status">
            <c:choose>
                <c:when test="${status.count %2 ==0}">
                    <tr >
                </c:when>
                <c:otherwise>
                    <tr class="odd">
                </c:otherwise>
            </c:choose>
                <td><input type="checkbox" name="item"  value="${employee.empId}"></td>
                <td name="empId" >${employee.empId}</td>
                <td name="empName">${employee.empName}</td>
                <td name="gender">${employee.gender}</td>
                <td name="email">${employee.email}</td>
                <td name="dId">${employee.dId}</td>
                <td>
                    <a class="updateGoA" href="javscript:void(0)">修改</a>
                    &nbsp;
                    <a class="updateSaveA" href="javscript:void(0)" >保存</a>
                    &nbsp;
                    <a  class="deleteA" href="javascript:void(0);">删除</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

    <div style="margin-left:100px;">
        &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<input type="hidden" value="${pageInfo.pageSize}" class="pageSize">
                <input type="hidden" value="${pageInfo.pageNum}" class="pageNum">
                <!--当前页有多少条-->
                <input type="hidden" value="${pageInfo.size}" class="size">
        &emsp;&emsp;&emsp;<br>
        当前&emsp;${pageInfo.pageNum }&emsp;页,&emsp;总&emsp;${pageInfo.pages }&emsp;页,&emsp;总&emsp;${pageInfo.total }&emsp;条记录
					<!-- 分页条信息 -->

        &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
        <a href="${APP_PATH }/employee/employeeList?pn=1">首页</a>&emsp;

        <c:if test="${pageInfo.hasPreviousPage }">
            <a href="${APP_PATH }/employee/employeeList?pn=${pageInfo.pageNum-1}"
                > <span aria-hidden="true">&laquo;</span>
            </a>&emsp;
        </c:if>


        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
            <c:if test="${page_Num == pageInfo.pageNum }">
                <B style="color:royalblue">${page_Num }</B>&emsp;
            </c:if>

            <c:if test="${page_Num != pageInfo.pageNum }">
                <a href="${APP_PATH }/employee/employeeList?pn=${page_Num }">${page_Num }</a>&emsp;
            </c:if>

        </c:forEach>
        <c:if test="${pageInfo.hasNextPage }">
            <a href="${APP_PATH }/employee/employeeList?pn=${pageInfo.pageNum+1 }"
                aria-label="Next"> <span aria-hidden="true">&raquo;</span>
            </a>&emsp;
        </c:if>
        <a href="${APP_PATH }/employee/employeeList?pn=${pageInfo.pages}">末页</a>
    </div>



<script src="${APP_PATH}/js/employee.js">

</script>
</body>
</html>