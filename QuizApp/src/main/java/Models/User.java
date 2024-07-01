package Models;

import java.util.ArrayList;

public class User {
    public String userName;
    public String password;
    public ArrayList<String> friends;
    public ArrayList<String> friendRequests;

    public User(String userName, String password){
        this.userName = userName;
        this.password = password;
    }
}
