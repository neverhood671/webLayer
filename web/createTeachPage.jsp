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
    </head>
    <body>
        <h1>Создать запись в таблице Teachers:</h1>
        <form name="Save" action="CreateTeacherServlet">
            <table border="1">          
                <tbody>
                    <tr>
                        <td>Name</td>
                        <td> <input type="text" name="teacherName" value="<%=request.getParameter("Name")%>" /> </td>
                    </tr>
                    <tr>
                        <td>Subject</td>
                        <td> <input type="text" name="subject" value="<%=request.getParameter("Subject")%>"/> </td>
                    </tr>
                    <tr>
                        <td>BossId</td>
                        <td> <input type="text" name="bossId" value="<%=request.getParameter("BossID")%>" /> </td>
                    </tr>
                    <tr>
                        <td>PhoneNumber</td>
                        <td> <input type="text" name="phoneNumber" value="<%=request.getParameter("BossID")%>" /> </td>
                    </tr>
                <input type="hidden" name="ID" value="<%=request.getParameter("ID")%>" />
                </tbody>
            </table>
            <input type="submit" value="Save" name="Action"/>
            <!--<input type="submit" value="Update" name="Action"/>-->
            <input type="submit" value="Delete" name="Action"/>

        </form



        <form name="Return" action="teachers.jsp">
            <input type="submit" value="Return" name="ReturnButton" />

        </form>
    </body>
</html>
