package models.user;

import models.enums.FriendRequestType;

public class UserProfile {
    private int id;
    private String username;
    private String email;
    private boolean isFriend;
    private FriendRequestType friendRequestType;

    public UserProfile(int id, String username, String email, boolean isFriend, FriendRequestType friendRequestType) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.isFriend = isFriend;
        this.friendRequestType = friendRequestType;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public boolean isFriend() {
        return isFriend;
    }

    public FriendRequestType getFriendRequestType() {
        return friendRequestType;
    }
}
