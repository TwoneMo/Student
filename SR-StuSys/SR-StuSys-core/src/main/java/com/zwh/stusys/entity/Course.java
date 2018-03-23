package com.zwh.stusys.entity;

public class Course {
    private Integer id;

    private String courseid;

    private String cname;

    private Integer score;

    private Integer credit;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCourseid() {
        return courseid;
    }

    public void setCourseid(String courseid) {
        this.courseid = courseid == null ? null : courseid.trim();
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname == null ? null : cname.trim();
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getCredit() {
        return credit;
    }

    public void setCredit(Integer credit) {
        this.credit = credit;
    }

	@Override
	public String toString() {
		return "Course [id=" + id + ", courseid=" + courseid + ", cname=" + cname + ", score=" + score + ", credit="
				+ credit + "]";
	}
}