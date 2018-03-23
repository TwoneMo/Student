package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Rolepermission;

public interface RolepermissionService {

	public List<Rolepermission> searchAllRolepermission();
	
	public Rolepermission searchById(int id);
	
	public List<Rolepermission> searchAllRolepermissionPage(Rolepermission rolepermission, int start,int length);
	
	public int searchCount(Rolepermission rolepermission);
	
	public int addRolepermission(Rolepermission rolepermission);
	
	public int updateRolepermission(Rolepermission rolepermission);
	
	public int deleteRolepermission(int id);
	
}
