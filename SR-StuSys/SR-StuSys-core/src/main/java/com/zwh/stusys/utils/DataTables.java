package com.zwh.stusys.utils;

import java.util.List;

public class DataTables {
	private int recordsTotal;
	private int recordsFiltered;
	private List data;
	public int getRecordsTotal() {
		return recordsTotal;
	}
	public void setRecordsTotal(int recordsTotal) {
		this.recordsTotal = recordsTotal;
	}
	public int getRecordsFiltered() {
		return recordsFiltered;
	}
	public void setRecordsFiltered(int recordsFiltered) {
		this.recordsFiltered = recordsFiltered;
	}
	public List getData() {
		return data;
	}
	public void setData(List data) {
		this.data = data;
	}
	public DataTables(int recordsTotal, int recordsFiltered, List data) {
		super();
		this.recordsTotal = recordsTotal;
		this.recordsFiltered = recordsFiltered;
		this.data = data;
	}
	@Override
	public String toString() {
		return "DataTables [recordsTotal=" + recordsTotal + ", recordsFiltered=" + recordsFiltered + ", data=" + data
				+ "]";
	}
	public DataTables() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
