package src.java.dao;

/**
 * Фабрика объектов для работы с базой данных
 * @param <Context>
 */
public interface DaoFactory<Context> {

    interface DaoCreator<Context> {

        GenericDao create(Context context);
    }

    /**
     * Возвращает подключение к базе данных
     *
     * @return
     * @throws src.java.dao.PersistException
     */
    Context getContext() throws PersistException;

    /**
     * Возвращает объект для управления персистентным состоянием объекта
     *
     * @param context
     * @param dtoClass
     * @return
     * @throws PersistException
     */
    GenericDao getDao(Context context, Class dtoClass) throws PersistException;
}
