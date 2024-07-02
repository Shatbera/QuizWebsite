package Models.user;

import config.DatabaseConfig;
import util.PasswordHashUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class User {
    private int id;
    private String userName;
    private ArrayList<String> friends;
    private ArrayList<String> friendRequests;
    private static Connection dbConnection = DatabaseConfig.getConnection();
    public User(int id, String userName){
        this.userName = userName;
        this.id = id;
    }

    public static User getUser(int id) {
        String query = "select u from mydatabase.user u where u.id = " + id;
        try {
            ResultSet resultSet = dbConnection.prepareStatement(query).executeQuery();
            if(!resultSet.next()) {
                return null;
            }
            return new User(resultSet.getInt("id"),
                    resultSet.getString("username"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static User getAuthenticatedUser(String username, String password) {
        String query = "select u from mydatabase.user u where u.username = " + username
                       + " and u.password = " + PasswordHashUtil.hashPassword(password);
        try {
            ResultSet resultSet = dbConnection.prepareStatement(query).executeQuery();
            if(!resultSet.next()) {
                return null;
            }
            return new User(resultSet.getInt("id"),
                    resultSet.getString("username"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
