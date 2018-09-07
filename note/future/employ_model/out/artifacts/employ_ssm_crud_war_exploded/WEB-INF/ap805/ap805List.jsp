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
    <link href="${APP_PATH}/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${APP_PATH}/css/style2.css" rel="stylesheet" type="text/css"/>
    <style>

    </style>
    <script src="${APP_PATH}/js/jquery-1.12.4.min.js" type="text/javascript">
    </script>
</head>
<body>
<div id="div0" style="width: 1500px;">
    <form id="formSearch" action="${APP_PATH}/ap805/list" method="post">
        <table>
                <tr>
            <td>:</td><td><input name="dateF"></td>
            <td>:</td><td><input name="rankF"></td>
            <td>:</td><td><input name="nameF"></td>
            <td>:</td><td><input name="longF"></td>
                </tr>
                <tr>
            <td>:</td><td><input name="longChangeF"></td>
            <td>:</td><td><input name="longPercentF"></td>
            <td>:</td><td><input name="shoftF"></td>
            <td>:</td><td><input name="shortChangeF"></td>
                </tr>
                <tr>
            <td>:</td><td><input name="shortPercentF"></td>
            <td>:</td><td><input name="netLongF"></td>
            <td>:</td><td><input name="netLongChangeF"></td>
            <td>:</td><td><input name="netShortF"></td>
                </tr>
                <tr>
            <td>:</td><td><input name="netShortChangeF"></td>
            <td>:</td><td><input name="netShortChangePercentF"></td>
            <td>:</td><td><input name="volumneF"></td>
            <td>:</td><td><input name="volumneChangeF"></td>
                </tr>
                <tr>
            <td>:</td><td><input name="volumePercentF"></td>
            <td>:</td><td><input name="clearPriceF"></td>
        </table>
        <input type="submit" value="提    交" >
    </form>
</div>
<div class="div1">
    <input type="button" value="添加员工" onclick="goTo('${APP_PATH}/ap805/page/ap805Go?way=add');" style="margin：15px;">
    <input type="button" value="反选" class="oppositeAp805" >
    <input type="button" value="批量删除" class="deleteBatchAp805">
    <input type="button" value="批量修改" class="updateBatchAp805">
    <input type="button" value="批量保存" class="saveBatchAp805">
    <input type="button" value="excel导出本页" class="exportExcelOnlyAp805">
    <input type="button" value="excel全部导出" class="exportExcelAllAp805">
</div>
<form style="margin-left:20px;margin-bottom: 20px" id="uploadForm" action="${APP_PATH}/ap805/importExcel2" enctype="multipart/form-data" method="post">
    <input type="file" name="file">
    <input type="button" class="uploadAp805" value="上传Excel">
</form>
<!--<input type="button" value="excel导入" class="importExcel">-->
<table style="border:1px solid #CCC;width:1600px" id="hor-zebra"  summary="Ap805 Pay Sheet">
    <thead>
        <tr >
            <td><input type="checkbox" class="allAp805" name="itemF"></td>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th >操作</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${pageInfo.list}" var="ap805" varStatus="status">
            <c:choose>
                <c:when test="${status.count %2 ==0}">
                    <tr >
                </c:when>
                <c:otherwise>
                    <tr class="odd">
                </c:otherwise>
            </c:choose>
                <td><input type="checkbox" name="item"  value="${ap805.dateF}"></td>
                    <td name="dateF">${ap805.dateF}</td>
                    <td name="rankF">${ap805.rankF}</td>
                    <td name="nameF">${ap805.nameF}</td>
                    <td name="longF">${ap805.longF}</td>
                    <td name="longChangeF">${ap805.longChangeF}</td>
                    <td name="longPercentF">${ap805.longPercentF}</td>
                    <td name="shoftF">${ap805.shoftF}</td>
                    <td name="shortChangeF">${ap805.shortChangeF}</td>
                    <td name="shortPercentF">${ap805.shortPercentF}</td>
                    <td name="netLongF">${ap805.netLongF}</td>
                    <td name="netLongChangeF">${ap805.netLongChangeF}</td>
                    <td name="netShortF">${ap805.netShortF}</td>
                    <td name="netShortChangeF">${ap805.netShortChangeF}</td>
                    <td name="netShortChangePercentF">${ap805.netShortChangePercentF}</td>
                    <td name="volumneF">${ap805.volumneF}</td>
                    <td name="volumneChangeF">${ap805.volumneChangeF}</td>
                    <td name="volumePercentF">${ap805.volumePercentF}</td>
                    <td name="clearPriceF">${ap805.clearPriceF}</td>
                <td>
                    <a  href="${APP_PATH}/ap805/page/ap805Go?way=update&dateF=${ap805.dateF}">修改</a>
                    &nbsp;
                    <a   href="${APP_PATH}/ap805/batchDelete/${ap805.dateF}">删除</a>
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
        <a href="${APP_PATH }/ap805/list?pn=1">首页</a>&emsp;

        <c:if test="${pageInfo.hasPreviousPage }">
            <a href="${APP_PATH }/ap805/list?pn=${pageInfo.pageNum-1}"
                > <span aria-hidden="true">&laquo;</span>
            </a>&emsp;
        </c:if>


        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
            <c:if test="${page_Num == pageInfo.pageNum }">
                <B style="color:royalblue">${page_Num }</B>&emsp;
            </c:if>

            <c:if test="${page_Num != pageInfo.pageNum }">
                <a href="${APP_PATH }/ap805/list?pn=${page_Num }">${page_Num }</a>&emsp;
            </c:if>

        </c:forEach>
        <c:if test="${pageInfo.hasNextPage }">
            <a href="${APP_PATH }/ap805/list?pn=${pageInfo.pageNum+1 }"
                aria-label="Next"> <span aria-hidden="true">&raquo;</span>
            </a>&emsp;
        </c:if>
        <a href="${APP_PATH }/ap805/list?pn=${pageInfo.pages}">末页</a>
    </div>



<script src="${APP_PATH}/js/ap805.js">

</script>
</body>
</html>