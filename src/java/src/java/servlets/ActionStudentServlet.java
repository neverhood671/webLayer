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
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "CreateStudentServlet", urlPatterns = {"/CreateStudentServlet"})
public class ActionStudentServlet extends HttpServlet {

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

        Student student = null;
        try {
            String studentName = request.getParameter("Name");
            String studentBirthday = request.getParameter("Birhtday");
            String studentGroup = request.getParameter("Group");
            String studentSalary = request.getParameter("Salary");
            if (StringUtils.isEmpty(studentName) || StringUtils.isEmpty(studentBirthday)
                    || StringUtils.isEmpty(studentGroup) || StringUtils.isEmpty(studentSalary)) {
                throw new RuntimeException("Incorrect values");
            }
            student = new Student();
            student.setName(studentName);
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            student.setBirhtday(format.parse(studentBirthday));
            student.setGroup(Integer.parseInt(studentGroup));
            student.setSal(Integer.parseInt(studentSalary));
        } catch (Exception ex) {
            request.setAttribute("error", "Incorrect values");
            forward(request, response);
        }
        DaoFactory<Connection> daoFactory = new OracleDaoContextFactory();
        Connection con = null;
        try {
            con = daoFactory.getContext();
            if (request.getParameter("Action").equals("Save")
                    || request.getParameter("ID").equals("null")) {
                if (StringUtils.isEmpty(request.getParameter("ID"))) {
                    try {
                        daoFactory.getDao(con, Group.class).getByPK(student.getGroup());
                        daoFactory.getDao(con, Student.class).persist(student);
                    } catch (Exception e) {
                        request.setAttribute("error", "Incorrect value of Group");
                        forward(request, response);
                        return;
                    }
                } else {
                    String id = request.getParameter("ID");
                    student.setId(Integer.parseInt(id));
                    daoFactory.getDao(con, Student.class).update(student);
                }
            } else if (request.getParameter("Action").equals("Delete")) {
                String id = request.getParameter("ID");
                student.setId(Integer.parseInt(id));
                daoFactory.getDao(con, Student.class).delete(student);
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
        response.sendRedirect("students.jsp");
    }

    private void forward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/createStudentPage.jsp");
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
