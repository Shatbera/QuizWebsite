package models.user;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Message {
    private String text;
    private String sendTime;

    public Message(String text, Timestamp sendTime) {
        this.text = text;
        this.sendTime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(sendTime);
    }

    public String getText() {
        return text;
    }

    public String getSendTime() {
        return sendTime;
    }
}
