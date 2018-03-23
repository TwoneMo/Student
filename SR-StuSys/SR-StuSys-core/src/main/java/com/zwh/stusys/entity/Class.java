package com.zwh.stusys.entity;

public class Class {
    private Integer id;

    private String classid;

    private String classname;

    private String classinfo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClassid() {
        return classid;
    }

    public void setClassid(String classid) {
        this.classid = classid == null ? null : classid.trim();
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname == null ? null : classname.trim();
    }

    public String getClassinfo() {
        return classinfo;
    }

    public void setClassinfo(String classinfo) {
        this.classinfo = classinfo == null ? null : classinfo.trim();
    }

	@Override
	public String toString() {
		return "Class [id=" + id + ", classid=" + classid + ", classname=" + classname + ", classinfo=" + classinfo
				+ "]";
	}
}