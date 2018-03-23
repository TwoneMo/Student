package com.zwh.stusys.service;

import java.util.List;
import com.zwh.stusys.entity.Class;

public interface ClassService {
	
	public List<Class> searchAllClass();
	
	public Class searchById(int id);
	
	public Class searchByTrueId(String classid);
	
	public List<Class> searchAllClassPage(Class myclass, int start,int length);
	
	public int searchCount(Class myclass);
	
	public int addClass(Class myclass);
	
	public int updateClass(Class myclass);
	
	public int deleteClass(int id);
	
	
}
