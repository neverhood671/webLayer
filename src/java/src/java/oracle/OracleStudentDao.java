package src.java.oracle;

import src.java.dao.*;
import src.java.dbobjects.*;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.List;

public class OracleStudentDao extends AbstractJDBCDao<Student, Integer> {

    private class PersistStudent extends Student {

        @Override
        public void setId(int id) {
            super.setId(id);
        }
    }

    @Override
    public String getSelectQuery() {
        return "SELECT * FROM STUDENTS order by id";
    }

    @Override
    public String getCreateQuery() {
        return "INSERT INTO STUDENTS (id, name, birhtday, groupnum, sal) "
                + "VALUES (STUD_ID.NEXTVAL, ?, ?, ?, ?)";
    }

    @Override
    public String getSelectQueryLastId() {
        return "SELECT stud.currval FROM STUDENTS dual ";
    }

    @Override
    public String getSelectQueryWithParameters(String param) {
        return "SELECT * FROM STUDENTS where " + param + " = ?";
    }

    @Override
    public String getUpdateQuery() {
        return "UPDATE STUDENTS \n"
                + "SET name = ?, birhtday  = ?, groupnum = ?, sal = ? \n"
                + "WHERE id = ?";
    }

    @Override
    public String getDeleteQuery() {
        return "DELETE FROM STUDENTS WHERE id= ?";
    }

    @Override
    public Student create() throws PersistException {
        Student s = new Student();
        return persist(s);
    }

    public OracleStudentDao(Connection connection) {
        super(connection);
    }

    @Override
    protected List<Student> parseResultSet(ResultSet rs) throws PersistException {
        LinkedList<Student> result = new LinkedList<>();
        try {
            while (rs.next()) {
                PersistStudent student = new PersistStudent();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setBirhtday(rs.getDate("birhtday"));
                student.setGroup(rs.getInt("groupnum"));
                student.setSal(rs.getInt("sal"));
                result.add(student);
            }
        } catch (Exception e) {
            throw new PersistException(e);
        }
        return result;
    }

    @Override
    protected void prepareStatementForUpdate(PreparedStatement statement, Student object) throws PersistException {
        try {
            //Date sqlDate = convert(object.getEnrolmentDate());

            statement.setString(1, object.getName());
            statement.setDate(2, new java.sql.Date(object.getBirhtday().getTime()));
            // statement.setDate(3, sqlDate);
            statement.setInt(3, object.getGroup());
            statement.setInt(4, object.getSal());
            statement.setInt(5, object.getId());
            // statement.setInt(5, object.getId());
        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

    @Override
    protected void prepareStatementForInsert(PreparedStatement statement, Student object) throws PersistException {
        try {
            //  Date sqlDate = convert(object.getEnrolmentDate());
//            statement.setInt(1, object.getId());
            statement.setString(1, object.getName());
            statement.setDate(2, new java.sql.Date(object.getBirhtday().getTime()));
            statement.setInt(3, object.getGroup());
            statement.setInt(4, object.getSal());
        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

    protected java.sql.Date convert(java.util.Date date) {
        if (date == null) {
            return null;
        }
        return new java.sql.Date(date.getTime());
    }
}
