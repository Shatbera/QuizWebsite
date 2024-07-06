package models.user;

import util.Utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Message {
    private String text;
    private String sendTime;

    public Message(String text, Timestamp sendTime) {
        this.text = text;
        this.sendTime = Utils.formatTimestamp(sendTime);
    }

    public String getText() {
        return text;
    }

    public String getSendTime() {
        return sendTime;
    }
}
