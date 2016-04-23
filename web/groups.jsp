<%-- 
    Document   : groups
    Created on : 19.04.2016, 18:22:24
    Author     : Настя
--%>

<%@page import="org.springframework.util.StringUtils"%>
<%@page import="src.java.dbobjects.Group"%>
<%@page import="src.java.dbobjects.Teacher"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.java.dbobjects.Student"%>
<%@page import="java.util.List"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    OracleDaoContextFactory factory = new OracleDaoContextFactory();
    try (Connection connection = factory.getContext()) {
        String param = request.getParameter("search_elem");
        String paramVal = request.getParameter("value");
        if (param != null && !StringUtils.isEmpty(paramVal)) {
            List<Student> groups = factory.getDao(connection, Group.class).getAllWithParameter(param, paramVal);
            pageContext.setAttribute("groups", groups);
        } else {
            List<Student> groups = factory.getDao(connection, Group.class).getAll();
            pageContext.setAttribute("groups", groups);
        }
    }
%>
<!DOCTYPE html>
<html>
    <style>
        .order-table-odd-row{
            text-align:center;
            background:none repeat scroll 0 0 #ccffff;
            border-top:1px solid #BBBBBB;}
        .tr:hover {background-color: #C0BCC7;}
        .td:hover {background-color: #C0BCC7;}
    </style>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" rel="stylesheet" type="text/css"/>
        <title>Groups</title>
    </head>
    <body>
        <h1>Groups</h1>
        <form name="SearchForm" action="groups.jsp">
            <strong>Select parameters:</strong> 
            <table border="0">
                <tbody>
                    <tr>
                        <td><select name="search_elem">
                                <option>GroupNum</option>
                                <option>ChiefId</option>
                                <option>Profession</option>
                            </select></td>
                        <td><input type="text" name="value" value="" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Search" name="Search" />
        </form>
        <table class="order-table">
            <tr>
                <th class="order-table-header">Select</th>
                <th class="order-table-header">GroupNum</th>
                <th class="order-table-header">CheifID</th>
                <th class="order-table-header">Profession</th>
                <th class="order-table-header">Details</th>

            </tr>

            <%
                int odd = 0;
            %>
            <c:forEach var="row" items="${groups}">
                <%
                    String style = odd % 2 == 0 ? "order-table-odd-row" : "order-table-even-row";
                    odd++;
                %>
                <tr class="<%=style%>">
                    <td><form name="updateRowForm" action="createGroupPage.jsp" method="GET">
                            <input type="checkbox" name="checkButton" value="${status.count}"> 
                        </form</td>
                    <td><c:out value="${row.id}"/></td>
                    <td><c:out value="${row.chiefId}"/></td>
                    <td><c:out value="${row.profession}"/></td>
                    <td><form name="updateRowForm" action="createGroupPage.jsp" method="GET">
                            <input type="hidden" name="GroupNum" value="${row.id}"</input>
                            <input type="hidden" name="CheifID" value="${row.chiefId}"</input>
                            <input type="hidden" name="Profession" value="${row.profession}"</input>
                            <input type="submit" name="selectButton" value="see details"</input>
                        </form></td>

                </tr>
            </c:forEach>

            <form name="start" action="startPage.jsp">
                <input type="submit" value="Return" name="Return" />
            </form>
            <form name="Delete" action="deleteGroupServlet">
                <input type="submit" value="Delete" name="Delete" />
            </form>  
            <form name="Create" action="createGroupPage.jsp">
                <input type="submit" value="Create" name="Create" />
            </form>

    </body>
</html>
