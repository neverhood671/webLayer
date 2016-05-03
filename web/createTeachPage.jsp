<%@page import="src.java.dbobjects.Teacher"%>
<%@page import="src.java.dbobjects.Group"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : createTeachPage
    Created on : 18.04.2016, 13:47:08
    Author     : fkfkf
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CreateTeacher</title>
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>Создать запись в таблице Teachers:</h1>
        <form name="Save" action="CreateTeacherServlet">
            <table class="order-table">          
                <tbody>
                    <%  String nameStr = "";
                        String subStr = "";
                        String phoneNumStr = "";
                        String bossIdStr = "";
                        String idStr = "";
                        if (request.getParameter("ID") != null) {
                            nameStr = request.getParameter("Name");
                            subStr = request.getParameter("Subject");
                            phoneNumStr = request.getParameter("phoneNumber");
                            bossIdStr = request.getParameter("BossID");
                            idStr = request.getParameter("ID");
                         }%>
                    <tr>
                        <td>Name</td>
                        <td> <input type="text" name="Name" value="<%=nameStr%>" /> </td>
                    </tr>
                    <tr>
                        <td>Subject</td>
                        <td> <input type="text" name="Subject" value="<%=subStr%>"/> </td>
                    </tr>
                    <tr>
                        <td>BossId</td>
                        <td> <input type="text" name="BossID" value="<%=bossIdStr%>" /> </td>
                    </tr>
                    <tr>
                        <td>PhoneNumber</td>
                        <td> <input type="text" name="phoneNumber" value="<%=phoneNumStr%>" /> </td>
                    </tr>
                </tbody>
            </table>
            <div class="buttonPanel">
                <input type="hidden" name="ID" value="<%=idStr%>" />
                <input type="submit" value="Save" name="Action"/>
                <input type="submit" value="Delete" name="Action"/>
            </div>
        </form>
        <form name="Return" action="teachers.jsp">
            <input type="submit" value="Return" name="ReturnButton" />
        </form>
    </body>
</html>
