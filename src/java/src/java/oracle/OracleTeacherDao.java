/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.java.oracle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import src.java.dao.AbstractJDBCDao;
import src.java.dao.PersistException;
import src.java.dbobjects.Teacher;

public class OracleTeacherDao extends AbstractJDBCDao<Teacher, Integer> {

    private class PersistGroup extends Teacher {

        @Override
        public void setId(int id) {
            super.setId(id);
        }
    }

    @Override
    public String getSelectQuery() {
        return "SELECT * FROM TEACHERS";
    }

    public String getSelectQueryLastId() {
        return "SELECT teach_id FROM dual";

    }

    @Override
    public String getCreateQuery() {
        return "INSERT INTO TEACHERS (ID, NAME, SUBJECT, BOSS_ID, PHONENUMBER) \n"
                + "VALUES (teach_id.nextval, ?, ?, ?, ?)";
    }

    @Override
    public String getSelectQueryWithParameters(String param) {
        return "SELECT * FROM TEACHERS WHERE " + param + " = ?";
    }

    @Override
    public String getUpdateQuery() {
        return "UPDATE TEACHERS SET NAME= ?, SUBJECT = ?, BOSS_ID = ? PHONENUMBER = ? WHERE ID = ?";
    }

    @Override
    public String getDeleteQuery() {
        return "DELETE FROM TEACHERS WHERE ID = ?";
    }

    @Override
    public Teacher create() throws PersistException {
        Teacher g = new Teacher();
        return persist(g);
    }

    public OracleTeacherDao(Connection connection) {
        super(connection);
    }

    @Override
    protected List<Teacher> parseResultSet(ResultSet rs) throws PersistException {
        LinkedList<Teacher> result = new LinkedList<>();
        try {
            while (rs.next()) {
                PersistGroup group = new PersistGroup();
                group.setId(rs.getInt("id"));
                group.setName(rs.getString("name"));
                group.setSubject(rs.getString("subject"));
                group.setBossId(rs.getInt("boss_Id"));
                group.setPhoneNumber(rs.getInt("phoneNumber"));
                result.add(group);
            }
        } catch (Exception e) {
            throw new PersistException(e);
        }
        return result;
    }

    @Override
    protected void prepareStatementForInsert(PreparedStatement statement, Teacher object) throws PersistException {
        try {
            //statement.setInt(1, object.getId());
            statement.setString(1, object.getName());
            statement.setString(2, object.getSubject());
            statement.setInt(3, object.getBossId());
            statement.setInt(4, object.getPhoneNumber());
        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

    @Override
    protected void prepareStatementForUpdate(PreparedStatement statement, Teacher object) throws PersistException {
        try {

            statement.setString(1, object.getName());
            statement.setString(2, object.getSubject());
            statement.setInt(3, object.getBossId());
            statement.setInt(4, object.getPhoneNumber());
            statement.setInt(5, object.getId());

        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

}
