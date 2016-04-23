package src.java;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author fkfkf
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author rage
 */
public class Conn {

    /**
     * @param args the command line arguments
     */
    public Conn() throws Exception {
        String driverName = "oracle.jdbc.OracleDriver";
        String server = "localhost";
        String port = "1521";
        String sid = "XE";
        String url;
        String username = "laba";
        String password = "1721";
        url = "jdbc:oracle:thin:@" + server + ":" + port + ":" + sid;

        Locale.setDefault(new Locale("EN", "US"));

        try  {
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", username, password);
            Class.forName(driverName);
            Statement st = connection.createStatement();

//            ResultSet rs = st.executeQuery("select * from emp");
//            while (rs.next()) {//следующая строка
//                //rs.getТип(i); получить значение i столбца
//                System.out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + " ");
//            }
        } catch (SQLException ex) {
            //
            System.out.println(ex);
        } catch (ClassNotFoundException ex) {
            System.out.println("fd");
            //
        }
    }
}
