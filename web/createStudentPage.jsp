<%-- 
    Document   : updateObjectPage
    Created on : 05.04.2016, 14:51:29
    Author     : Настя
--%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CreateStudent</title>
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
        <h1>Создать запись в таблице Students:</h1>
        <form name="Save" action="CreateStudentServlet">
            <table class="order-table">          
                <tbody>
                    <%  String nameStr = "";
                        String birhtdayStr = "";
                        String groupnumStr = "";
                        String salStr = "";
                        String idStr = "";
                        if (request.getParameter("ID") != null) {
                            nameStr = request.getParameter("Name");
                            birhtdayStr = request.getParameter("Birhtday");
                            groupnumStr = request.getParameter("Group");
                            salStr = request.getParameter("Salary");
                            idStr = request.getParameter("ID");
                        }%>
                    <tr>
                        <td>Имя</td>
                        <td>
                            <input type="text" name="Name" value="<%=nameStr%>" />
                        </td>
                    </tr>
                    <tr>
                        <td>День Рождения</td>
                        <td>
                            <input type="date" name="Birhtday" value="<%=birhtdayStr%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Группа</td>
                        <td>
                            <input type="text" name="Group" value="<%=groupnumStr%>" />  
                        </td>
                    </tr>
                    <tr>
                        <td>Стипендия</td>
                        <td>
                            <input type="text" name="Salary" value="<%=salStr%>" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="buttonPanel">
                <input type="hidden" name="ID" value="<%=idStr%>" />    
                <input type="submit" value="Save" name="Action"/>
                <input type="submit" value="Delete" name="Action"/>
            </div>
        </form>
        <form name="Return" action="students.jsp">
            <input type="submit" value="Return" name="ReturnButton" />
        </form>
    </body>
</html>
