package com.zwh.stusys.entity;

public class Roles {
    private Integer id;

    private String rid;

    private String rname;

    private String roleinfo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid == null ? null : rid.trim();
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname == null ? null : rname.trim();
    }

    public String getRoleinfo() {
        return roleinfo;
    }

    public void setRoleinfo(String roleinfo) {
        this.roleinfo = roleinfo == null ? null : roleinfo.trim();
    }

	@Override
	public String toString() {
		return "Roles [id=" + id + ", rid=" + rid + ", rname=" + rname + ", roleinfo=" + roleinfo + "]";
	}
}