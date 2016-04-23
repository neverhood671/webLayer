<%-- 
    Document   : students
    Created on : 11.04.2016, 21:32:17
    Author     : fkfkf
--%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.springframework.util.StreamUtils"%>
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
        if (!StringUtils.isEmpty(param) && !StringUtils.isEmpty(paramVal)) {
             List<Student> students = factory.getDao(connection, Student.class).getAllWithParameter(param, paramVal);
            pageContext.setAttribute("students", students);
        } else {
            List<Student> students = factory.getDao(connection, Student.class).getAll();
            pageContext.setAttribute("students", students);
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
        <title>Students</title>
    </head>
    <body>
        <h1>Students</h1>
        <form name="SearchForm" action="students.jsp">
            <strong>Select parameters:</strong> 
            <table border="0">
                <tbody>
                    <tr>
                        <td><select name="search_elem">
                                <option>ID</option>
                                <option>Name</option>
                                <option>Birhtday</option>
                                <option>Groupnum</option>
                                <option>Sal</option>
                            </select></td>
                        <td> <input type="text" name="value" value="" /> </td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="Search" name="Search" />
        </form>
        <table class="order-table">
            <tr>
                <th class="order-table-header">Select</th>
                <th class="order-table-header">ID</th>
                <th class="order-table-header">Name</th>
                <th class="order-table-header">Birhtday</th>
                <th class="order-table-header">Group</th>
                <th class="order-table-header">Sal</th>
                <th class="order-table-header">Details</th>

            </tr>
            <%
                int odd = 0;
            %>
            <c:forEach var="row" items="${students}">
                <%
                    String style = odd % 2 == 0 ? "order-table-odd-row" : "order-table-even-row";
                    odd++;
                %>
                <tr class="<%=style%>">
                    <td><form name="updateRowForm" action="createStudentPage.jsp" method="GET">
                            <input type="checkbox" name="checkButton" value="${status.count}"> 
                        </form</td>
                    <td><c:out value="${row.id}"/></td>
                    <td><c:out value="${row.name}"/></td>
                    <td><c:out value="${row.birhtday}"/></td>
                    <td><c:out value="${row.group}"/></td>
                    <td><c:out value="${row.sal}"/></td>
                    <td><form name="updateRowForm" action="createStudentPage.jsp" method="GET">

                            <input type="hidden" name="ID" value="${row.id}"</input>
                            <input type="hidden" name="Name" value="${row.name}"</input>
                            <input type="hidden" name="Birhtday" value="${row.birhtday}"</input>
                            <input type="hidden" name="Group" value="${row.group}"</input>
                            <input type="hidden" name="Salary" value="${row.sal}"</input>
                            <input type="submit" name="selectButton" value="see details"</input>
                        </form></td>

                </tr>
            </c:forEach>

            <form name="start" action="startPage.jsp">
                <input type="submit" value="Return" name="Return" />
            </form>
            <form name="Delete" action="DeleteStudentServlet">
                <input type="submit" value="Delete" name="Delete" />
            </form>  
            <form name="Create" action="createStudentPage.jsp">
                <input type="submit" value="Create" name="Create" />
            </form>
    </body>
</html>

