package src.java.oracle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import org.springframework.util.StringUtils;
import src.java.dao.*;
import src.java.dbobjects.*;

public class OracleGroupDao extends AbstractJDBCDao<Group, Integer> {

    private static List<String> GROUP_PARAMS = Arrays.asList(new String[]{"groupnum", "chiefId", "profession"});

    private class PersistGroup extends Group {

        @Override
        public void setId(int id) {
            super.setId(id);
        }
    }

    @Override
    public String getSelectQuery() {
        return "SELECT * FROM GROUPS order by groupnum";
    }

    @Override
    public String getSelectQueryLastId() {
        return "SELECT group_num FROM dual";
    }

    @Override
    public String getCreateQuery() {
        return "INSERT INTO GROUPS (groupnum, chiefId, profession) \n"
                + "VALUES (group_num.nextval, ?, ?)";
    }

    @Override
    public String getSelectQueryWithParameters(String param) {
        return "SELECT * FROM GROUPS WHERE " + param + " = ?";
    }

    @Override
    public String getUpdateQuery() {
        return "UPDATE GROUPS SET chiefId= ?, profession = ? WHERE groupnum= ?";
    }

    @Override
    public String getDeleteQuery() {
        return "DELETE FROM GROUPS WHERE groupnum= ?";
    }

    @Override
    public Group create() throws PersistException {
        Group g = new Group();
        return persist(g);
    }

    public OracleGroupDao(Connection connection) {
        super(connection);
    }

    @Override
    protected List<Group> parseResultSet(ResultSet rs) throws PersistException {
        LinkedList<Group> result = new LinkedList<>();
        try {
            while (rs.next()) {
                PersistGroup group = new PersistGroup();
                group.setId(rs.getInt("groupnum"));
                group.setChiefId(rs.getInt("chiefid"));
                group.setProfession(rs.getString("profession"));
                result.add(group);
            }
        } catch (Exception e) {
            throw new PersistException(e);
        }
        return result;
    }

    @Override
    protected void prepareStatementForInsert(PreparedStatement statement, Group object) throws PersistException {
        try {

            statement.setInt(1, object.getChiefId());
            statement.setString(2, object.getProfession());
        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

    @Override
    protected void prepareStatementForUpdate(PreparedStatement statement, Group object) throws PersistException {
        try {

            statement.setInt(1, object.getChiefId());
            statement.setString(2, object.getProfession());
            statement.setInt(3, object.getId());
            //statement.setInt(4, object.getId());
        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

    

}
