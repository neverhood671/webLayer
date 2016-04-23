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
import src.java.dbobjects.Group;
import src.java.dbobjects.Student;
import src.java.oracle.OracleDaoContextFactory;

/**
 *
 * @author Настя
 */
@ManagedBean(name = "student")
@SessionScoped
public class StudentsManagedBean implements Serializable {

    private DaoFactory<Connection> daoFactory;

    public StudentsManagedBean() {
        daoFactory = new OracleDaoContextFactory();
    }

    //connect to DB and get customer list
    public List<Group> getStudentList() throws PersistException, SQLException {

        //get database connection
        Connection con = daoFactory.getContext();
        List<Group> list = null;
        try {
            list = daoFactory.getDao(con, Student.class).getAll();
        } finally {
            con.close();
        }

        return list;
    }
}
