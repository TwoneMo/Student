package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Roles;



public interface RoleService {

	public List<Roles> searchAllRoles();
	
	public Roles searchById(int id);
	
	public Roles searchByTrueId(String rid);
	
	public List<Roles> searchAllRolesPage(int start,int length);
	
	public int searchCount();
	
	public int addRole();
	
	public int updateRole();
	
	public int deleteRole();
	
}
