package com.zwh.stusys.entity;

public class Student {
    private Integer id;

    private String sid;

    private String sname;

    private String sex;

    private String birthday;

    private String phone;

    private String identityCard;

    private String address;

    private String email;

    private String classid;

    private Integer uid;

    private Class myclass;
    
    private Users user;
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid == null ? null : sid.trim();
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname == null ? null : sname.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday == null ? null : birthday.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getIdentityCard() {
        return identityCard;
    }

    public void setIdentityCard(String identityCard) {
        this.identityCard = identityCard == null ? null : identityCard.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getClassid() {
        return classid;
    }

    public void setClassid(String classid) {
        this.classid = classid == null ? null : classid.trim();
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

	public Class getMyclass() {
		return myclass;
	}

	public void setMyclass(Class myclass) {
		this.myclass = myclass;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Student [id=" + id + ", sid=" + sid + ", sname=" + sname + ", sex=" + sex + ", birthday=" + birthday
				+ ", phone=" + phone + ", identityCard=" + identityCard + ", address=" + address + ", email=" + email
				+ ", classid=" + classid + ", uid=" + uid + ", myclass=" + myclass + ", user=" + user + "]";
	}
	
	
}