package poly.dto;

public class RsiDTO {
    private String user_id;
    private String minute;
    private String collectTime;
    private String rsi;

    public String getCollectTime() {
        return collectTime;
    }

    public void setCollectTime(String collectTime) {
        this.collectTime = collectTime;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getMinute() {
        return minute;
    }

    public void setMinute(String minute) {
        this.minute = minute;
    }


    public String getRsi() {
        return rsi;
    }

    public void setRsi(String rsi) {
        this.rsi = rsi;
    }
}
