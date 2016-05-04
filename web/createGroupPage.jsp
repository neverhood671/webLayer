<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.springframework.util.StreamUtils"%>
<%@page import="src.java.dbobjects.Teacher"%>
<%@page import="src.java.dbobjects.Group"%>
<%@page import="java.util.List"%>
<%@page import="src.java.dbobjects.Student"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : createGroupPage
    Created on : 18.04.2016, 14:12:38
    Author     : fkfkf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CreateGroup</title>
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            String errorMessage = (String) request.getAttribute("error");
            if (!StringUtils.isEmpty(errorMessage)) {
        %>
        <div class="errorText"><%=errorMessage%></div>
        <%
            }
        %>
        <h1>Создать запись в таблице Groups:</h1>
        <form name="Save" action="CreateGroupServlet">
            <table>          
                <tbody>
                    <%  String cheifIdStr = "";
                        String professionStr = "";
                        String groupnumStr = "";
                        if (request.getParameter("GroupNum") != null) {
                            cheifIdStr = request.getParameter("ChiefID");
                            professionStr = request.getParameter("Profession");
                            groupnumStr = request.getParameter("GroupNum");
                        }%>
                    <tr>
                        <td>ChiefID</td>
                        <td> <input type="text" name="ChiefID" value="<%=cheifIdStr%>" /> </td>
                    </tr>
                    <tr>
                        <td>Profession</td>
                        <td> <input type="text" name="Profession" value="<%=professionStr%>"/> </td>
                    </tr>
                </tbody>
            </table>
            <div class="buttonPanel">
                <input type="hidden" name="GroupNum" value="<%=groupnumStr%>"/> 
                <input type="submit" value="Save" name="Action"/>
                <input type="submit" value="Delete" name="Action"/>
            </div>
        </form>
        <form name="Return" action="groups.jsp">
            <input type="submit" value="Return" name="ReturnButton" />
        </form>
    </body>
</html>
