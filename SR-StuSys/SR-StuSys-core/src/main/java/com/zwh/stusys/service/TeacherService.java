package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Teacher;

public interface TeacherService {

	public List<Teacher> searchAllTeacher();
	
	public Teacher searchById(int id);
	
	public Teacher searchByTrueId(String tid);
	
	public List<Teacher> searchAllTeacherPage(Teacher teacher, int start,int length);
	
	public int searchCount(Teacher teacher);
	
	public int addTeacher(Teacher teacher);
	
	public int updateTeacher(Teacher teacher);
	
	public int deleteTeacher(int id);
	
	public Teacher searchByUid(int uid);
}
