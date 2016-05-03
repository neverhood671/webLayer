/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.util.StringUtils;
import src.java.beans.XmlWorker;
import src.java.dao.Identified;
import src.java.dao.PersistException;
import src.java.dbobjects.Student;
import src.java.oracle.OracleDaoContextFactory;

/**
 *
 * @author Настя
 */
@WebServlet(name = "NewServlet", urlPatterns = {"/NewServlet"})
public class NewServlet extends HttpServlet {

//    @EJB
    protected XmlWorker instanceName;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Map<String, String> filteredParams = new HashMap<>();
            filteredParams.put("id", "ID");
            filteredParams.put("name", "Name");
            filteredParams.put("birhtday", "Birhtday");
            filteredParams.put("groupnum", "Groupnum");
            filteredParams.put("sal", "Sal");

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
//                XmlWorker instanceName = (XmlWorker) new InitialContext().lookup("java:comp/env/ejb/XmlWorker");
                if (filter.isEmpty()) {
                    List<Identified> students = factory.getDao(connection, Student.class).getAll();
                    res = instanceName.convertToHtml(students);
                } else {
                    List<Identified> students = factory.getDao(connection, Student.class).getAllWithParameter(filter);
                    res = instanceName.convertToHtml(students);
                }
                out.println(res);
            }
        } catch (SQLException | PersistException ex) {
            Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
