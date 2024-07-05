package models.user;

import models.enums.FriendRequestType;

public class UserProfile {
    private int id;
    private String username;
    private String email;
    private boolean isFriend;
    private Integer senderId;
    private Integer receiverId;
    private FriendRequestType friendRequestType;

    public UserProfile(int id, String username, String email, boolean isFriend, Integer senderId, Integer receiverId, FriendRequestType friendRequestType) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.isFriend = isFriend;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.friendRequestType = friendRequestType;
    }

    public String getUsername() {
        return username;
    }

    public int getId() {
        return id;
    }

    public Integer getSenderId() {
        return senderId;
    }

    public Integer getReceiverId() {
        return receiverId;
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
