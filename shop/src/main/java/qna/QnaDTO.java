package qna;

public class QnaDTO {
    private int qnum;
    private int mnum;
    private String qtitle;
    private String qcontent;

    public int getQnum() {
        return qnum;
    }
    public void setQnum(int qnum) {
        this.qnum = qnum;
    }

    public int getMnum() {
        return mnum;
    }
    public void setMnum(int mnum) {
        this.mnum = mnum;
    }

    public String getQtitle() {
        return qtitle;
    }
    public void setQtitle(String qtitle) {
        this.qtitle = qtitle;
    }

    public String getQcontent() {
        return qcontent;
    }
    public void setQcontent(String qcontent) {
        this.qcontent = qcontent;
    }
}