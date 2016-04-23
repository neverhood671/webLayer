package src.java.oracle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import src.java.dbobjects.*;
import src.java.dao.*;

public class OracleDaoFactory implements DaoFactory<Connection> {

    private Map<Class, DaoCreator> creators;
    String driver = "oracle.jdbc.OracleDriver";
    String server = "localhost";
    String port = "1521";
    String sid = "XE";
    String user = "laba";
    String password = "1721";
    String url = "jdbc:oracle:thin:@" + server + ":" + port + ":" + sid;

    @Override
    public Connection getContext() throws PersistException {

        //try load from context
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/XE");
            return ds.getConnection();
        } catch (NamingException | SQLException ignored) {
        }

        Locale.setDefault(new Locale("EN", "US"));
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            throw new PersistException(e);
        }
        return connection;
    }

    @Override
    public GenericDao getDao(Connection connection, Class dtoClass) throws PersistException {
        DaoCreator creator = creators.get(dtoClass);
        if (creator == null) {
            throw new PersistException("Dao object for " + dtoClass + " not found.");
        }
        return creator.create(connection);
    }

    public OracleDaoFactory() {
        try {
            Class.forName(driver);//Регистрируем драйвер
        } catch (ClassNotFoundException e) {
            e.printStackTrace();  //todo use Log
        }

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
