// shop/src/main/java/edu/sm/app/msg/Msg.java
package edu.sm.app.dto;

public class Msg {
    private String sendid;
    private String receiveid;
    private String content1;

    // Getters and Setters
    public String getSendid() { return sendid; }
    public void setSendid(String sendid) { this.sendid = sendid; }
    public String getReceiveid() { return receiveid; }
    public void setReceiveid(String receiveid) { this.receiveid = receiveid; }
    public String getContent1() { return content1; }
    public void setContent1(String content1) { this.content1 = content1; }
}