<%-- 
    Document   : startpage
    Created on : 05.04.2016, 14:50:37
    Author     : Настя
--%>

<%@page import="src.java.dbobjects.Group"%>
<%@page import="src.java.dbobjects.Teacher"%>
<%@page import="src.java.dbobjects.Student"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InformSystem</title>
    </head>
    <body>
        <h1>Добро пожаловать!</h1>
        <form name="helpPage" action="helpPage.jsp">
            <input type="submit" value="Help" name="Help"  />
        </form> 
        <h2>      
            <a href="teachers.jsp" target="_parent">Teachers</a>
        </h2>
        <h2> 
            <a href="students.jsp" target="_parent">Students</a>
        </h2>
        <h2> 
            <a href="groups.jsp" target="_parent">Groups</a>
        </h2>
    </body>
</html>
