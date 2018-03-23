package com.zwh.stusys.utils;

public class AjaxResult {
	private Object tag;
	private String message;
	public Object getTag() {
		return tag;
	}
	public void setTag(Object tag) {
		this.tag = tag;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "AjaxResult [tag=" + tag + ", message=" + message + "]";
	}
	public AjaxResult(Object tag, String message) {
		super();
		this.tag = tag;
		this.message = message;
	}
	public AjaxResult() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
