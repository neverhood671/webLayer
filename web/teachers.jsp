<%--
    Document   : teachers
    Created on : 19.04.2016, 18:24:11
    Author     : Настя
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="src.java.dbobjects.Teacher"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    Map<String, String> filteredParams = new HashMap<>();
    filteredParams.put("id", "ID");
    filteredParams.put("name", "Name");
    filteredParams.put("subject", "Subject");
    filteredParams.put("boss_Id", "BossID");
    filteredParams.put("phoneNumber", "PhoneNumber");
    pageContext.setAttribute("filteredParams", filteredParams);

    OracleDaoContextFactory factory = new OracleDaoContextFactory();
    try (Connection connection = factory.getContext()) {
        Map<String, String> filter = new HashMap<>();
        for (String paramName : filteredParams.keySet()) {
            String paramVal = request.getParameter(paramName);
            if (!StringUtils.isEmpty(paramVal)) {
                filter.put(paramName, paramVal);
            }
        }
        if (filter.isEmpty()) {
            List<Teacher> teachers = factory.getDao(connection, Teacher.class).getAll();
            pageContext.setAttribute("teachers", teachers);
        } else {
            List<Teacher> teachers = factory.getDao(connection, Teacher.class).getAllWithParameter(filter);
            pageContext.setAttribute("teachers", teachers);
            pageContext.setAttribute("filter", filter);
        }
    }
%>
<!DOCTYPE html>
<html>
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
                <tr>
                    <c:forEach var="entry" items="${filteredParams.entrySet()}">
                        <td>
                            ${entry.getValue()}
                        </td>
                        <td>
                            <input type="text" name="${entry.getKey()}" value="${filter.get(entry.getKey())}" />
                        </td>
                    </c:forEach>
                </tr>
            </table>
            <input type="submit" value="Search" name="Search" />
        </form>
        <div class="buttonPanel">
            <form name="Return" action="startPage.jsp">
                <input type="submit" value="Return" name="Return" />
            </form>
            <form name="Delete" action="DeleteStudentServlet">
                <input type="submit" value="Delete" name="Delete" />
            </form>  
            <form name="Create" action="createTeachPage.jsp">
                <input type="submit" value="Create" name="Create" />
            </form>
        </div>
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
                        </form>
                    </td>
                    <td><c:out value="${row.id}"/></td>
                    <td><c:out value="${row.name}"/></td>
                    <td><c:out value="${row.subject}"/></td>
                    <td><c:out value="${row.bossId}"/></td>
                    <td><c:out value="${row.phoneNumber}"/></td>
                    <td><form name="updateRowForm" action="createStudentPage.jsp" method="GET">
                            <input type="hidden" name="ID" value="${row.id}"/>
                            <input type="hidden" name="Name" value="${row.name}"/>
                            <input type="hidden" name="Subject" value="${row.subject}"/>
                            <input type="hidden" name="BossID" value="${row.bossId}"/>
                            <input type="hidden" name="PhoneNumber" value="${row.phoneNumber}"/>
                            <input type="submit" name="selectButton" value="see details"/>
                        </form></td>

                </tr>
            </c:forEach>
        </table>

    </body>
</html>

