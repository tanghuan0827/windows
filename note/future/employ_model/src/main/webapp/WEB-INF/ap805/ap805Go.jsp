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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${APP_PATH}/js/jquery-1.12.4.min.js" type="text/javascript">
    </script>
</head>
<style>
    input{
        margin:10px;
    }
</style>
<body>
    <div style="margin-left:50px;margin-top:30px;">
        <form id="formAddAp805" action="${APP_PATH}/ap805/${way}" method="post">
            <input type="hidden" name="dateF" value="${ap805.dateF}">

                    :<input type="text" name="rankF" value="${ap805.rankF}"><br>
                    :<input type="text" name="nameF" value="${ap805.nameF}"><br>
                    :<input type="text" name="longF" value="${ap805.longF}"><br>
                    :<input type="text" name="longChangeF" value="${ap805.longChangeF}"><br>
                    :<input type="text" name="longPercentF" value="${ap805.longPercentF}"><br>
                    :<input type="text" name="shoftF" value="${ap805.shoftF}"><br>
                    :<input type="text" name="shortChangeF" value="${ap805.shortChangeF}"><br>
                    :<input type="text" name="shortPercentF" value="${ap805.shortPercentF}"><br>
                    :<input type="text" name="netLongF" value="${ap805.netLongF}"><br>
                    :<input type="text" name="netLongChangeF" value="${ap805.netLongChangeF}"><br>
                    :<input type="text" name="netShortF" value="${ap805.netShortF}"><br>
                    :<input type="text" name="netShortChangeF" value="${ap805.netShortChangeF}"><br>
                    :<input type="text" name="netShortChangePercentF" value="${ap805.netShortChangePercentF}"><br>
                    :<input type="text" name="volumneF" value="${ap805.volumneF}"><br>
                    :<input type="text" name="volumneChangeF" value="${ap805.volumneChangeF}"><br>
                    :<input type="text" name="volumePercentF" value="${ap805.volumePercentF}"><br>
                    :<input type="text" name="clearPriceF" value="${ap805.clearPriceF}"><br>
                <%--部门:&nbsp;<select name="dId" style="width:170px;margin:8px;">
                <c:choose>
                    <c:when test="${fn:length(ap805.department.deptName)>0}">
                        <option value="${ap805.dId}">${ap805.department.deptName}</option>
                    </c:when>
                    <c:otherwise>
                        <option >-----请选择部门-----</option>
                    </c:otherwise>
                </c:choose>
                        <c:forEach items="${departmentList}" var="department">
                            <c:if test="${ap805.department.deptName!= department.deptName}">
                                <option value="${department.deptId}">${department.deptName}</option>
                            </c:if>
                        </c:forEach>
                </select><br> --%>
                &emsp;&emsp;&emsp;<input type="submit" value="提    交" >
        </form>
    </div>
</body>
<script src="${APP_PATH}/js/ap805.js">

</script>
</html>
