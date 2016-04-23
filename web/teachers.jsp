<%-- 
    Document   : teachers
    Created on : 19.04.2016, 18:24:11
    Author     : Настя
--%>

<%@page import="org.springframework.util.StringUtils"%>
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
            List<Student> teachers = factory.getDao(connection, Teacher.class).getAllWithParameter(param, paramVal);
            pageContext.setAttribute("teachers", teachers);
        } else {
            List<Student> teachers = factory.getDao(connection, Teacher.class).getAll();
            pageContext.setAttribute("teachers", teachers);
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
        <title>Teachers</title>
    </head>
    <body>
        <h1>Teachers</h1>
        <form name="SearchForm" action="teachers.jsp">
            <strong>Select parameters:</strong> 
            <table border="0">
                <tbody>
                    <tr>
                        <td><select name="search_elem">
                                <option> ID </option>
                                <option>Name</option>
                                <option>Subject</option>
                                <option>BossID</option>
                                <option>PhoneNumber</option>
                                <option>Profession</option>
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
                <th class="order-table-header">Subject</th>
                <th class="order-table-header">BossID</th>
                <th class="order-table-header">PhoneNumber</th>
                <th class="order-table-header">Details</th>

            </tr>
            <%
                int odd = 0;
            %>
            <c:forEach var="row" items="${teachers}">
                <%
                    String style = odd % 2 == 0 ? "order-table-odd-row" : "order-table-even-row";
                    odd++;
                %>
                <tr class="<%=style%>">
                    <td><form name="updateRowForm" action="createTeachPage.jsp" method="GET">
                            <input type="checkbox" name="checkButton" value="${status.count}"> 
                        </form</td>
                    <td><c:out value="${row.id}"/></td>
                    <td><c:out value="${row.name}"/></td>
                    <td><c:out value="${row.subject}"/></td>
                    <td><c:out value="${row.bossId}"/></td>
                    <td><c:out value="${row.phoneNumber}"/></td>
                    <td><form name="updateRowForm" action="createStudentPage.jsp" method="GET">
                            <input type="hidden" name="ID" value="${row.id}"</input>
                            <input type="hidden" name="Name" value="${row.name}"</input>
                            <input type="hidden" name="Subject" value="${row.subject}"</input>
                            <input type="hidden" name="BossID" value="${row.bossId}"</input>
                            <input type="hidden" name="BossID" value="${row.phoneNumber}"</input>
                            <input type="submit" name="selectButton" value="see details"</input>
                        </form></td>

                </tr>
            </c:forEach>

            <form name="Return" action="startPage.jsp">
                <input type="submit" value="Return" name="Return" />
            </form>
            <form name="Delete" action="DeleteStudentServlet">
                <input type="submit" value="Delete" name="Delete" />
            </form>  
            <form name="Create" action="createTeachPage.jsp">
                <input type="submit" value="Create" name="Create" />
            </form>
    </body>
</html>

