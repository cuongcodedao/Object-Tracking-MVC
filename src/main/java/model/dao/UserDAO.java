package model.dao;

import model.bean.Project;
import model.bean.User;

import java.sql.*;

public class UserDAO {
    static final String DB_URL = "jdbc:mysql://localhost/objecttracking";
    static final String USER = "root";
//    static final String PASS = "123456";
    static final String PASS = "Nmdung04@";
    private Connection conn;

    public UserDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public User login(String username, String password) {
        PreparedStatement st = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM user WHERE username = ? and password = ?";
        User user = null;

        if (conn != null) {
            try {
                st = conn.prepareStatement(sql);
                st.setString(1, username);
                st.setString(2, password);
                rs = st.executeQuery();

                if (rs.next()) {
                    int id = rs.getInt("id");
                    String username1 = rs.getString("username");
                    String password1 = rs.getString("password");
                    user = new User(id, username1, password1);

                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (st != null) st.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return user;
    }
    public boolean register(String username, String password) {
        PreparedStatement st = null;
        String sql = "insert into user (username, password) values (?, ?)";

        if (conn != null) {
            try {
                st = conn.prepareStatement(sql);
                st.setString(1, username);
                st.setString(2, password);
                st.executeUpdate();
                return true;
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (st != null) st.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }
}
