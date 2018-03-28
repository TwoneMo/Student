package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Teach;

public interface TeachService {

	public List<Teach> searchAllTeach();
	
	public Teach searchById(int id);
	
	public List<Teach> searchAllTeachPage(Teach teach, int start, int length);
	
	public int searchCount(Teach teach);
	
	public int addTeach(Teach teach);
	
	public int updateTeach(Teach teach);
	
	public int deleteTeach(int id);
	
}
