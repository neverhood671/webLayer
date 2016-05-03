<%-- 
    Document   : SeeDetailsStudent
    Created on : 25.04.2016, 8:34:02
    Author     : fkfkf
--%>
<%@page import="java.util.List"%>
<%@page import="src.java.dbobjects.Student"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  Map<String, String> filteredParams = new HashMap<>();
    filteredParams.put("id", "ID");
    pageContext.setAttribute("filteredParams", filteredParams);
    OracleDaoContextFactory factory = new OracleDaoContextFactory();
    Connection connection = factory.getContext();
    Map<String, String> filter = new HashMap<>();
    filter.put("id", request.getParameter("id"));
    List<Student> students = factory.getDao(connection, Student.class).getAllWithParameter(filter);
    pageContext.setAttribute("teachers", students);
    pageContext.setAttribute("filter", filter);
    Student stud = students.get(0);
    String id = "" + (stud.getId());
    String name = "" + stud.getName();
    String birhtday = "" + stud.getBirhtday();
    String groupnum = "" + stud.getGroup();
    String sal = "" + stud.getSal();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DetailsStudent</title>
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>info about student</h1>
        <table class="order-table">          
            <tbody>
                <tr>
                    <td>Id</td>
                    <td> <input type="text" name="id" value="<%=id%>" readonly/> </td>
                </tr>
                <tr>
                    <td>Имя</td>
                    <td> <input type="text" name="studentName" value="<%=name%>" readonly/> </td>
                </tr>
                <tr>
                    <td>День Рождения</td>
                    <td> <input type="text" name="studentBirthday" value="<%=birhtday%>" readonly/> </td>
                </tr>
                <tr>
                    <td>Группа</td>
                    <td> <input type="text" name="studentGroup" value="<%=groupnum%> " readonly/>  
                    <td>
                        <form name="SeeStudentsGroup" action="students.jsp">
                            <input type="hidden" name="GroupNumber" value="<%=groupnum%> "/>
                            <input type="submit" value="SeeStudents" name="Students"/>  
                        </form> 
                    </td>
                </tr>
                <tr>
                    <td>Стипендия</td>
                    <td> <input type="text" name="studentSalary" value="<%=sal%>" readonly/> </td>
                </tr>
            </tbody>
        </table>
        <form name="modify" action="createStudentPage.jsp">
            <input type="hidden" name="ID" value="<%=id%>"/>
            <input type="hidden" name="Name" value="<%=name%>"/>
            <input type="hidden" name="Birhtday" value="<%=birhtday%>"/>
            <input type="hidden" name="Group" value="<%=groupnum%>"/>
            <input type="hidden" name="Salary" value="<%=sal%>"/>
            <input type="submit" value="Modify" name="ModifyButton" />
        </form>
        <form name="Return" action="startPage.jsp">
            <input type="submit" value="MainMenu" name="MainMenuButton" />
        </form>
    </body>
</html>
