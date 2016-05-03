<%-- 
    Document   : xml
    Created on : 02.05.2016, 12:48:41
    Author     : Настя
--%>

<%@page import="javax.ejb.EJB"%>
<%@page import="src.java.beans.XmlWorker"%>
<%@page import="src.java.beans.XmlWorkerBean"%>
<%@page import="src.java.dao.Identified"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.ejb.embeddable.EJBContainer"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="java.sql.Connection"%>
<%@page import="src.java.oracle.OracleDaoContextFactory"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="src.java.dbobjects.Student"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Map<String, String> filteredParams = new HashMap<>();
    filteredParams.put("id", "ID");
    filteredParams.put("name", "Name");
    filteredParams.put("birhtday", "Birhtday");
    filteredParams.put("groupnum", "Groupnum");
    filteredParams.put("sal", "Sal");
    pageContext.setAttribute("filteredParams", filteredParams);

    OracleDaoContextFactory factory = new OracleDaoContextFactory();
    try (Connection connection = factory.getContext()) {
        Map<String, String> filter = new HashMap<>();
        for (String paramName : filteredParams.keySet()) {
            String paramVal = request.getParameter(paramName);
            String parametr = request.getParameter("GroupNumber");
            if (parametr != null) {
                filter.put("groupnum", request.getParameter("GroupNumber"));
            }
            if (!StringUtils.isEmpty(paramVal)) {
                filter.put(paramName, paramVal);
            }
        }
        String res = "";
//        XmlWorker instanceName = (XmlWorker) new InitialContext().lookup("java:comp/env/ejb/XmlWorker");
        if (filter.isEmpty()) {
            List<Identified> students = factory.getDao(connection, Student.class).getAll();
            pageContext.setAttribute("students", students);
//            res = instanceName.convertToHtml(students);
        } else {
            List<Identified> students = factory.getDao(connection, Student.class).getAllWithParameter(filter);
            pageContext.setAttribute("students", students);
            pageContext.setAttribute("filter", filter);
//            res = instanceName.convertToHtml(students);
        }
        pageContext.setAttribute("res", res);

    }
%>

${res}
