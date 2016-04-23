package src.java.oracle;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import src.java.dbobjects.*;
import src.java.dao.*;

public class OracleDaoContextFactory implements DaoFactory<Connection> {

    private Map<Class, DaoCreator> creators;

    @Override
    public Connection getContext() throws PersistException {
        Locale.setDefault(new Locale("EN", "US"));
        //try load from context
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/XE");
            return ds.getConnection();
        } catch (NamingException | SQLException ex) {
            throw new PersistException(ex);
        }
    }

    @Override
    public GenericDao getDao(Connection connection, Class dtoClass) throws PersistException {
        DaoCreator creator = creators.get(dtoClass);
        if (creator == null) {
            throw new PersistException("Dao object for " + dtoClass + " not found.");
        }
        return creator.create(connection);
    }

    public OracleDaoContextFactory() {

        creators = new HashMap<>();
        creators.put(Group.class, new DaoCreator<Connection>() {
            @Override
            public GenericDao create(Connection connection) {
                return new OracleGroupDao(connection);
            }
        });
        creators.put(Student.class, new DaoCreator<Connection>() {
            @Override
            public GenericDao create(Connection connection) {
                return new OracleStudentDao(connection);
            }
        });
        creators.put(Teacher.class, new DaoCreator<Connection>() {
            @Override
            public GenericDao create(Connection connection) {
                return new OracleTeacherDao(connection);
            }
        });
    }
}
