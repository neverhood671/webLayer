<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<%  Map<String, String> filteredParams = new HashMap<>();
    filteredParams.put("GroupNum", "GROUPNUM");
    pageContext.setAttribute("filteredParams", filteredParams);

    OracleDaoContextFactory factory = new OracleDaoContextFactory();
    Connection connection = factory.getContext();
    Map<String, String> filter = new HashMap<>();
    filter.put("GroupNum", request.getParameter("GroupNum"));
    List<Group> groups = factory.getDao(connection, Group.class).getAllWithParameter(filter);
    pageContext.setAttribute("groups", groups);
    pageContext.setAttribute("filter", filter);
    Group group = groups.get(0);
    String id = "" + (group.getId());
    String chiefId = "" + group.getChiefId();
    String profession = "" + group.getProfession();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>Info about group</h1>
        <table class="order-table">          
            <tr>
                <td>GroupID</td>
                <td> 
                    <input type="text" name="GroupNum" value="<%=id%>" readonly/>
                </td>
                <td>
                    <form name="SeeStudentForm" action="students.jsp" method="GET">
                        <input type="hidden" name="GroupNumber" value="<%=id%>"/>
                        <input type="submit" name="SeeStudentsButton" value="Students"/>
                    </form>
                </td>
            </tr>
            <tr>
                <td>ChiefID</td>
                <td> 
                    <input type="text" name="chiefId" value="<%=chiefId%>" readonly/>
                </td>
                <td> 
                    <form name="SeeDetailsTeacher" action="SeeDetailsTeacher.jsp">
                        <input type="hidden" name="ID" value="<%=chiefId%>"/>
                        <input type="submit" name="SeeChiefButton" value="Chief"/>
                    </form>
                </td>
            </tr>
            <tr>
                <td>Profession</td>
                <td> <input type="text" name="profession" value="<%=profession%>" readonly/> </td>
            </tr>
        </table>
        <form name="modify" action="createGroupPage.jsp">
            <input type="hidden" name="GroupNum" value="<%=id%>"/>
            <input type="hidden" name="ChiefID" value="<%=chiefId%>"/>
            <input type="hidden" name="Profession" value="<%=profession%>"/>
            <input type="submit" value="Modify" name="ModifyButton" />
        </form>
        <form name="return" action="startPage.jsp">
            <input type="submit" value="MainMenu" name="MainMenuButton" />
        </form>
    </body>
</html>
