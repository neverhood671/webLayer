/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.util.StringUtils;
import src.java.dao.DaoFactory;
import src.java.dao.PersistException;
import src.java.dbobjects.Group;
import src.java.dbobjects.Student;
import src.java.oracle.OracleDaoContextFactory;

/**
 *
 * @author Настя
 */
@WebServlet(name = "CreateGroupServlet", urlPatterns = {"/CreateGroupServlet"})
public class ActionGroupServlet extends HttpServlet {

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

        Group group = null;
        try {
            int chiefId = Integer.parseInt(request.getParameter("chiefId"));
            String profession = request.getParameter("profession");
            if (StringUtils.isEmpty(chiefId) || StringUtils.isEmpty(profession)) {
                throw new RuntimeException("Incorrect values");
            }
            group = new Group();
            group.setChiefId(chiefId);
            group.setProfession(profession);
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }

        DaoFactory<Connection> daoFactory = new OracleDaoContextFactory();
        Connection con = null;
        try {
            con = daoFactory.getContext();
            if (request.getParameter("Action").equals("Save")) {
                if (StringUtils.isEmpty(request.getParameter("GroupNum"))) {
                    daoFactory.getDao(con, Group.class).persist(group);
                } else {
                    String id = request.getParameter("GroupNum");
                    group.setId(Integer.parseInt(id));
                    daoFactory.getDao(con, Group.class).update(group);
                } /*else if (request.getParameter("Action").equals("Update")) {
                 String id = request.getParameter("GroupNum");
                 group.setId(Integer.parseInt(id));
                 daoFactory.getDao(con, Group.class).update(group);*/

            } else if (request.getParameter("Action").equals("Delete")) {
                String id = request.getParameter("GroupNum");
                group.setId(Integer.parseInt(id));
                daoFactory.getDao(con, Group.class).delete(group);
            }
        } catch (PersistException ex) {
            throw new RuntimeException(ex);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            }
        }

        response.sendRedirect(
                "groups.jsp");
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
