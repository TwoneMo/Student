package com.zwh.stusys.entity;

public class Permissions {
    private Integer id;

    private String pid;

    private String pname;

    private String url;

    private String parentid;

    private String isparent;

    private String ismenu;
    
    private boolean checked=false;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid == null ? null : pid.trim();
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname == null ? null : pname.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid == null ? null : parentid.trim();
    }

    public String getIsparent() {
        return isparent;
    }

    public void setIsparent(String isparent) {
        this.isparent = isparent == null ? null : isparent.trim();
    }

    public String getIsmenu() {
        return ismenu;
    }

    public void setIsmenu(String ismenu) {
        this.ismenu = ismenu == null ? null : ismenu.trim();
    }
    
    public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
}