/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;
import org.springframework.util.StringUtils;
import src.java.dao.DaoFactory;
import src.java.dao.PersistException;
import src.java.dbobjects.Group;
import src.java.dbobjects.Teacher;
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
            int chiefId = Integer.parseInt(request.getParameter("ChiefID"));
            String profession = request.getParameter("Profession");
            if (StringUtils.isEmpty(chiefId) || StringUtils.isEmpty(profession)) {
                throw new RuntimeException("Incorrect values");
            }
            group = new Group();
            group.setChiefId(chiefId);
            group.setProfession(profession);
        } catch (Exception ex) {
            request.setAttribute("error", "Incorrect type of values");
            forward(request, response);
            return;
        }

        DaoFactory<Connection> daoFactory = new OracleDaoContextFactory();
        Connection con = null;
        try {
            con = daoFactory.getContext();
            if (request.getParameter("Action").equals("Save")) {
                if (StringUtils.isEmpty(request.getParameter("GroupNum"))
                        || request.getParameter("GroupNum").equals("null")) {
                    try {
                        daoFactory.getDao(con, Teacher.class).getByPK(group.getChiefId());
                        daoFactory.getDao(con, Group.class).persist(group);
                    } catch (Exception e) {
                        request.setAttribute("error", "Incorrect value of ChiefID");
                        forward(request, response);
                        return;
                    }
                } else {
                    String id = request.getParameter("GroupNum");
                    group.setId(Integer.parseInt(id));
                    daoFactory.getDao(con, Group.class).update(group);
                }
            } else if (request.getParameter("Action").equals("Delete")) {
                String id = request.getParameter("GroupNum");
                group.setId(Integer.parseInt(id));
                daoFactory.getDao(con, Group.class).delete(group);
            }
        } catch (PersistException ex) {
            request.setAttribute("error", "Illegal action for this element");
            forward(request, response);
            return;
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            }
        }
        response.sendRedirect("groups.jsp");
    }

    private void forward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/createGroupPage.jsp");
        dispatcher.forward(request, response);
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
