/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.beans;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import src.java.dao.DaoFactory;
import src.java.dao.PersistException;
import src.java.dbobjects.Teacher;
import src.java.oracle.OracleDaoContextFactory;

/**
 *
 * @author Настя
 */
@ManagedBean(name = "teacher")
@SessionScoped
public class TeachersManagedBean implements Serializable {

    private DaoFactory<Connection> daoFactory;

    public TeachersManagedBean() {
        daoFactory = new OracleDaoContextFactory();
    }

    //connect to DB and get customer list
    public List<Teacher> getTeacherList() throws PersistException, SQLException {

        //get database connection
        Connection con = daoFactory.getContext();
        List<Teacher> list = null;
        try {
            list = daoFactory.getDao(con, Teacher.class).getAll();
        } finally {
            con.close();
        }

        return list;
    }
}
