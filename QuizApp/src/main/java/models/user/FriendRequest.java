package models.user;

public class FriendRequest {
    int id;
    String username;

    public FriendRequest(int id, String username) {
        this.id = id;
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }
}
