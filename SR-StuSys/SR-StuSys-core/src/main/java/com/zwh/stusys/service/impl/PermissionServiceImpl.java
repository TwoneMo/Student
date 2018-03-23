package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Permissions;
import com.zwh.stusys.entity.PermissionsExample;
import com.zwh.stusys.entity.PermissionsExample.Criteria;
import com.zwh.stusys.mapper.PermissionsMapper;
import com.zwh.stusys.service.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl implements PermissionService{

	@Autowired
	private PermissionsMapper Mapper;
	
	@Override
	public List<Permissions> searchAllPermissions() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Permissions searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Permissions searchByTrueId(String pid) {
		// TODO Auto-generated method stub
		return Mapper.selectByTrueKey(pid);
	}

	@Override
	public List<Permissions> searchAllPermissionsPage(Permissions permission, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllPermissionsPage(permission, start, length);
	}

	@Override
	public int searchCount(Permissions permission) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(permission);
	}

	@Override
	public int addPermissions(Permissions permission) {
		// TODO Auto-generated method stub
		int result = 0;
		PermissionsExample example = new PermissionsExample();
		Criteria criteria = example.createCriteria();
		criteria.andPnameEqualTo(permission.getPname());
		List<Permissions> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			result = -1;
		} else {
			Mapper.insert(permission);
		}
		return result;
	}

	@Override
	public int updatePermissions(Permissions permission) {
		// TODO Auto-generated method stub
		int result = 0;
		PermissionsExample example = new PermissionsExample();
		Criteria criteria = example.createCriteria();
		criteria.andPnameEqualTo(permission.getPname());
		List<Permissions> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			if(list.get(0).getId().equals(permission.getId())) {
				result = Mapper.updateByPrimaryKey(permission);
			} else {
				result = -1;
			}
		} else {
			result = Mapper.updateByPrimaryKey(permission);
		}
		return result;
	}

	@Override
	public int deletePermissions(int id) {
		// TODO Auto-generated method stub
		return Mapper.deleteByPrimaryKey(id);
	}

}
