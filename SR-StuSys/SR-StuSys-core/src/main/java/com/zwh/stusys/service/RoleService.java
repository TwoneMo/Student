package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Roles;



public interface RoleService {

	public List<Roles> searchAllRoles();
	
	public Roles searchById(int id);
	
	public Roles searchByTrueId(String rid);
	
	public List<Roles> searchAllRolesPage(Roles role, int start, int length);
	
	public int searchCount(Roles role);
	
	public int addRole(Roles role);
	
	public int updateRole(Roles role);
	
	public int deleteRole(int id);
	
}
