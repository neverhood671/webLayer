package src.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Абстрактный класс предоставляющий базовую реализацию CRUD операций с
 * использованием JDBC.
 *
 * @param <T> тип объекта персистенции
 * @param <PK> тип первичного ключа
 */
public abstract class AbstractJDBCDao<T extends Identified<PK>, PK extends Integer> implements GenericDao<T, PK> {

    private Connection connection;

    /**
     * Возвращает sql запрос для получения всех записей.
     * <p/>
     * SELECT * FROM [Table]
     */
    public abstract String getSelectQuery();

    /**
     * Возвращает sql запрос для вставки новой записи в базу данных.
     * <p/>
     * INSERT INTO [Table] ([column, column, ...]) VALUES (?, ?, ...);
     */
    public abstract String getCreateQuery();

    /**
     * Возвращает sql запрос для обновления записи.
     * <p/>
     * UPDATE [Table] SET [column = ?, column = ?, ...] WHERE id = ?;
     */
    public abstract String getSelectQueryLastId();

    public abstract String getSelectQueryWithParameters(List<String> param);

    public abstract String getUpdateQuery();

    /**
     * Возвращает sql запрос для удаления записи из базы данных.
     * <p/>
     * DELETE FROM [Table] WHERE id= ?;
     */
    public abstract String getDeleteQuery();

    /**
     * Разбирает ResultSet и возвращает список объектов соответствующих
     * содержимому ResultSet.
     */
    protected abstract List<T> parseResultSet(ResultSet rs) throws PersistException;

    /**
     * Устанавливает аргументы insert запроса в соответствии со значением полей
     * объекта object.
     */
    protected abstract void prepareStatementForInsert(PreparedStatement statement, T object) throws PersistException;

    /**
     * Устанавливает аргументы update запроса в соответствии со значением полей
     * объекта object.
     */
    protected abstract void prepareStatementForUpdate(PreparedStatement statement, T object) throws PersistException;

    @Override
    public T persist(T object) throws PersistException {
        try {
            T persistInstance;
            // Добавляем запись
            String sql = getCreateQuery();
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                prepareStatementForInsert(statement, object);

                int count = statement.executeUpdate();
                if (count != 1) {
                    throw new PersistException("On persist modify more then 1 record: " + count);
                }
            } catch (Exception e) {
                throw new PersistException(e);
            }
            String sql1 = getSelectQueryLastId();
            PreparedStatement statement1 = connection.prepareStatement(sql);
            // Получаем только что вставленную запись
            ResultSet rs1 = statement1.executeQuery(sql1);
            int id = rs1.getInt(0);

            sql = getSelectQuery() + " WHERE id =" + id;
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                ResultSet rs = statement.executeQuery();
                List<T> list = parseResultSet(rs);
                if ((list == null) || (list.size() != 1)) {
                    throw new PersistException("Exception on findByPK new persist data.");
                }
                persistInstance = list.iterator().next();
            } catch (Exception e) {
                throw new PersistException(e);
            }
            return persistInstance;
        } catch (SQLException ex) {
            Logger.getLogger(AbstractJDBCDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public T getByPK(Integer key) throws PersistException {
        List<T> list;
        String sql = getSelectQuery();
        sql += " WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, key);
            ResultSet rs = statement.executeQuery();
            list = parseResultSet(rs);
        } catch (Exception e) {
            throw new PersistException(e);
        }
        if (list == null || list.size() == 0) {
            throw new PersistException("Record with PK = " + key + " not found.");
        }
        if (list.size() > 1) {
            throw new PersistException("Received more than one record.");
        }
        return list.iterator().next();
    }

    @Override
    public void update(T object) throws PersistException {
        String sql = getUpdateQuery();
        try (PreparedStatement statement = connection.prepareStatement(sql);) {
            prepareStatementForUpdate(statement, object); // заполнение аргументов запроса оставим на совесть потомков
            int count = statement.executeUpdate();
            if (count != 1) {
                throw new PersistException("On update modify more then 1 record: " + count);
            }
        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

    @Override
    public void delete(T object) throws PersistException {
        String sql = getDeleteQuery();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            try {
                statement.setObject(1, object.getId());
            } catch (Exception e) {
                throw new PersistException(e);
            }
            int count = statement.executeUpdate();
            if (count != 1) {
                throw new PersistException("On delete modify more then 1 record: " + count);
            }
            statement.close();
        } catch (Exception e) {
            throw new PersistException(e);
        }
    }

    @Override
    public List<T> getAll() throws PersistException {
        List<T> list;
        String sql = getSelectQuery();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            list = parseResultSet(rs);
        } catch (Exception e) {
            throw new PersistException(e);
        }
        return list;
    }

    /**
     *
     * @param param
     * @param value
     * @return
     * @throws PersistException
     */
    @Override
    public List<T> getAllWithParameter(Map<String, String> param) throws PersistException {
        List<T> result;
        List<String> sqlParams = new ArrayList<>();
        for (String paramName : param.keySet()) {
            if (isParamCorrect(paramName)) {
                sqlParams.add(paramName);
            }
        }
        String sql = getSelectQueryWithParameters(sqlParams);
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            int i = 0;
            for (String paramName : sqlParams) {
                statement.setString(++i, param.get(paramName));
            }
            ResultSet rs = statement.executeQuery();
            result = parseResultSet(rs);
        } catch (Exception e) {
            throw new PersistException(e);
        }
        return result;
    }

    protected abstract boolean isParamCorrect(String param);

    public AbstractJDBCDao(Connection connection) {
        this.connection = connection;
    }

    protected String getParamListToSQLString(List<String> param) {
        if (param.isEmpty()) {
            return "";
        }
        StringBuilder str = new StringBuilder();
        for (String paramName : param) {
            str.append(" ").append(paramName).append(" = ? and");
        }
        return str.substring(0, str.length() - 4);
    }

}
