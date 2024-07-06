package models.user;

import java.text.SimpleDateFormat;
import java.util.List;

public class FriendMessage {
    private int senderId;
    private String senderUsername;
    private List<Message> messages;

    public FriendMessage(int senderId, String senderUsername, List<Message> messages) {
        this.senderId = senderId;
        this.senderUsername = senderUsername;
        this.messages = messages;
    }

    public int getSenderId() {
        return senderId;
    }

    public String getSenderUsername() {
        return senderUsername;
    }

    public List<Message> getMessages() {
        return messages;
    }
}
