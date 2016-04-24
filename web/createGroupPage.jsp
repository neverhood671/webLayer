<%@page import="src.java.dbobjects.Teacher"%>
<%@page import="src.java.dbobjects.Group"%>
<%@page import="java.util.List"%>
<%@page import="src.java.dbobjects.Student"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
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
        <h1>Создать запись в таблице Groups:</h1>
        <form name="Save" action="CreateGroupServlet">
            <table>          
                <tbody>
                    <tr>
                        <td>ChiefID</td>
                        <td> <input type="text" name="chiefId" value="<%=request.getParameter("CheifID")%>" /> </td>
                    </tr>
                    <tr>
                        <td>Profession</td>
                        <td> <input type="text" name="profession" value="<%=request.getParameter("Profession")%>"/> </td>
                    </tr>
                </tbody>
            </table>
            <div class="buttonPanel">
                <input type="hidden" name="GroupNum" value="<%=request.getParameter("GroupNum")%>"/> 
                <input type="submit" value="Save" name="Action"/>
                <!--<input type="submit" value="Update" name="Action"/>-->
                <input type="submit" value="Delete" name="Action"/>
            </div>
        </form>
        <form name="Return" action="groups.jsp">
            <input type="submit" value="Return" name="ReturnButton" />
        </form>
    </body>
</html>
