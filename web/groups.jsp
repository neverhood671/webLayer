<%-- 
    Document   : groups
    Created on : 19.04.2016, 18:22:24
    Author     : Настя
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="src.java.dbobjects.Group"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    Map<String, String> filteredParams = new HashMap<>();
    filteredParams.put("groupnum", "GroupNum");
    filteredParams.put("chiefId", "ChiefID");
    filteredParams.put("profession", "Profession");
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
            List<Group> groups = factory.getDao(connection, Group.class).getAll();
            pageContext.setAttribute("groups", groups);
        } else {
            List<Group> groups = factory.getDao(connection, Group.class).getAllWithParameter(filter);
            pageContext.setAttribute("groups", groups);
            pageContext.setAttribute("filter", filter);
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" 
              rel="stylesheet" type="text/css"/>
        <title>Groups</title>
    </head>
    <body>
        <h1>Groups</h1>
        <form name="SearchForm" action="groups.jsp">
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
            <form name="Create" action="createGroupPage.jsp">
                <input type="submit" value="Create" name="Create" />
            </form>
        </div>
        <table class="order-table">
            <tr>
                <th class="order-table-header">GroupNum</th>
                <th class="order-table-header">ChiefID</th>
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
                    <td><c:out value="${row.id}"/></td>
                    <td><c:out value="${row.chiefId}"/></td>
                    <td><c:out value="${row.profession}"/></td>
                    <td><form name="updateRowForm" action="SeeDetailsGroup.jsp" method="GET">
                            <input type="hidden" name="GroupNum" value="${row.id}"/>
                            <input type="hidden" name="ChiefID" value="${row.chiefId}"/>
                            <input type="hidden" name="Profession" value="${row.profession}"/>
                            <input type="submit" name="selectButton" value="details"/>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
