<%-- 
    Document   : students
    Created on : 11.04.2016, 21:32:17
    Author     : fkfkf
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.springframework.util.StreamUtils"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.java.dbobjects.Student"%>
<%@page import="java.util.List"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    Map<String, String> filteredParams = new HashMap<>();
    filteredParams.put("id", "ID");
    filteredParams.put("name", "Name");
    filteredParams.put("birhtday", "Birhtday");
    filteredParams.put("groupnum", "Groupnum");
    filteredParams.put("sal", "Sal");
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
            List<Student> students = factory.getDao(connection, Student.class).getAll();
            pageContext.setAttribute("students", students);
        } else {
            List<Student> students = factory.getDao(connection, Student.class).getAllWithParameter(filter);
            pageContext.setAttribute("students", students);
            pageContext.setAttribute("filter", filter);
        }

    }
%>
<!DOCTYPE html>
<html>
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
            <form name="start" action="startPage.jsp">
                <input type="submit" value="Return" name="Return" />
            </form>
            <form name="Delete" action="DeleteStudentServlet">
                <input type="submit" value="Delete" name="Delete" />
            </form>  
            <form name="Create" action="createStudentPage.jsp">
                <input type="submit" value="Create" name="Create" />
            </form>
        </div>
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
                    <td>
                        <form name="updateRowForm" action="createStudentPage.jsp" method="GET">
                            <input type="checkbox" name="checkButton" value="${status.count}"> 
                        </form>
                    </td>
                    <td><c:out value="${row.id}"/></td>
                    <td><c:out value="${row.name}"/></td>
                    <td><c:out value="${row.birhtday}"/></td>
                    <td><c:out value="${row.group}"/></td>
                    <td><c:out value="${row.sal}"/></td>
                    <td>
                        <form name="updateRowForm" action="createStudentPage.jsp" method="GET">

                            <input type="hidden" name="ID" value="${row.id}"/>
                            <input type="hidden" name="Name" value="${row.name}"/>
                            <input type="hidden" name="Birhtday" value="${row.birhtday}"/>
                            <input type="hidden" name="Group" value="${row.group}"/>
                            <input type="hidden" name="Salary" value="${row.sal}"/>
                            <input type="submit" name="selectButton" value="see details"/>
                        </form>
                    </td>

                </tr>
            </c:forEach>
        </table>

    </body>
</html>

