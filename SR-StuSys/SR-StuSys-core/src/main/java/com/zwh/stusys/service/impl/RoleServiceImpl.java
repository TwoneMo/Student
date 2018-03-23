package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Roles;
import com.zwh.stusys.mapper.RolesMapper;
import com.zwh.stusys.service.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RolesMapper Mapper;
	
	@Override
	public List<Roles> searchAllRoles() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Roles searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Roles searchByTrueId(String rid) {
		// TODO Auto-generated method stub
		return Mapper.selectByTrueKey(rid);
	}

	@Override
	public List<Roles> searchAllRolesPage(int start, int length) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int searchCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addRole() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateRole() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteRole() {
		// TODO Auto-generated method stub
		return 0;
	}

}
