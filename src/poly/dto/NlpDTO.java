package poly.dto;

public class NlpDTO {
    private String word;
    private String word_root;
    private String polarity;

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public String getWord_root() {
        return word_root;
    }

    public void setWord_root(String word_root) {
        this.word_root = word_root;
    }

    public String getPolarity() {
        return polarity;
    }

    public void setPolarity(String polarity) {
        this.polarity = polarity;
    }
}
