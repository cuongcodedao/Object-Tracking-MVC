package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAOUtils {
    static final String DB_URL = "jdbc:mysql://localhost/objecttracking";
    static final String USER = "root";
//    static final String PASS = "123456";
    static final String PASS = "Nmdung04@";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}
