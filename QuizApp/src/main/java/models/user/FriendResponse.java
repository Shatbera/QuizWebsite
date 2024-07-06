package models.user;

public class FriendResponse {
    int id;
    String username;

    public FriendResponse(int id, String username) {
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
