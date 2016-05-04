<%-- 
    Document   : SeeDetailsTeacher
    Created on : 25.04.2016, 8:33:47
    Author     : fkfkf
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="src.java.dbobjects.Teacher"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Map<String, String> filteredParams = new HashMap<>();
    filteredParams.put("id", "ID");
    pageContext.setAttribute("filteredParams", filteredParams);
    OracleDaoContextFactory factory = new OracleDaoContextFactory();
    Connection connection = factory.getContext();
    Map<String, String> filter = new HashMap<>();
    filter.put("id", request.getParameter("ID"));
    List<Teacher> teachers = factory.getDao(connection, Teacher.class).getAllWithParameter(filter);
    pageContext.setAttribute("teachers", teachers);
    pageContext.setAttribute("filter", filter);
    Teacher teach = teachers.get(0);
    String id = "" + (teach.getId());
    String name = "" + teach.getName();
    String subject = "" + teach.getSubject();
    String boss_Id = "" + teach.getBossId();
    String phoneNumber = "" + teach.getPhoneNumber();
%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Info about teacher</title>
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1></h1>
        <table class="order-table">          
            <tbody>
                <tr>
                    <td>Id</td>
                    <td> <input type="text" name="ID" value="<%=id%>" readonly/> </td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td> <input type="text" name="Name" value="<%=name%>" readonly/> </td>
                </tr>
                <tr>
                    <td>Subject</td>
                    <td> <input type="text" name="Subject" value="<%=subject%>" readonly/> </td>
                </tr>
                <tr>
                    <td>BossId</td>
                    <td> <input type="text" name="BossId" value="<%=boss_Id%>" readonly/> </td>
                </tr>
                <tr>
                    <td>PhoneNumber</td>
                    <td> <input type="text" name="PhoneNumber" value="<%=phoneNumber%>" readonly/> </td>
                </tr>
            </tbody>
        </table>
        <form name="modify" action="createTeachPage.jsp">
            <input type="hidden" name="ID" value="<%=id%>"/>
            <input type="hidden" name="Name" value="<%=name%>"/>
            <input type="hidden" name="Subject" value="<%=subject%>"/>
            <input type="hidden" name="BossID" value="<%=boss_Id%>"/>
            <input type="hidden" name="PhoneNumber" value="<%=phoneNumber%>"/>
            <input type="submit" value="Modify" name="Modify" />
        </form>
        <form name="return" action="startPage.jsp">     
            <input type="submit" value="MainMenu" name="MainMenuButton" />
        </form>
    </body>
</html>