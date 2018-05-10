package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Permissions;

public interface PermissionService {

	public List<Permissions> searchAllPermissions();
	
	public Permissions searchById(int id);
	
	public Permissions searchByTrueId(String pid);
	
	public List<Permissions> searchAllPermissionsPage(Permissions permission, int start,int length);
	
	public int searchCount(Permissions permission);
	
	public int addPermissions(Permissions permission);
	
	public int updatePermissions(Permissions permission);
	
	public int deletePermissions(int id);
	
	public List<Permissions> getPermissionByParentid(int parentid);
	
	public int movePermission(int id,int oldParentid,int newParentid);
	
}
