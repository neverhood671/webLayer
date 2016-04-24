<%-- 
    Document   : updateObjectPage
    Created on : 05.04.2016, 14:51:29
    Author     : Настя
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CreateStudent</title>
        <link href="${pageContext.servletContext.contextPath}/resources/css/table-style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>Создать запись в таблице Students:</h1>
        <form name="Save" action="CreateStudentServlet">
            <table>          
                <tbody>
                    <tr>
                        <td>Имя</td>
                        <td> <input type="text" name="studentName" value="<%=request.getParameter("Name")%>" /> </td>
                    </tr>
                    <tr>
                        <td>День Рождения</td>
                        <td> <input type="text" name="studentBirthday" value="<%=request.getParameter("Birhtday")%>"/> </td>
                    </tr>
                    <tr>
                        <td>Группа</td>
                        <td> <input type="text" name="studentGroup" value="<%=request.getParameter("Group")%>" /> </td>
                    </tr>
                    <tr>
                        <td>Стипендия</td>
                        <td> <input type="text" name="studentSalary" value="<%=request.getParameter("Salary")%>" /> </td>
                    </tr>

                </tbody>
            </table>
            <div class="buttonPanel">
                <input type="hidden" name="ID" value="<%=request.getParameter("ID")%>" />    
                <input type="submit" value="Save" name="Action"/>
                <!--<input type="submit" value="Update" name="Action"/>-->
                <input type="submit" value="Delete" name="Action"/>
            </div>
        </form>
        <form name="Return" action="students.jsp">
            <input type="submit" value="Return" name="ReturnButton" />

        </form>
    </body>
</html>
