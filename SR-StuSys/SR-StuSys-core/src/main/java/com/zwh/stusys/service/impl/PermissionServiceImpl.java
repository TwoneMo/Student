package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Permissions;
import com.zwh.stusys.entity.PermissionsExample;
import com.zwh.stusys.entity.PermissionsExample.Criteria;
import com.zwh.stusys.entity.Rolepermission;
import com.zwh.stusys.entity.RolepermissionExample;
import com.zwh.stusys.mapper.PermissionsMapper;
import com.zwh.stusys.mapper.RolepermissionMapper;
import com.zwh.stusys.service.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl implements PermissionService{

	@Autowired
	private PermissionsMapper Mapper;
	
	@Autowired
	private RolepermissionMapper rpm;
	
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
			result = Mapper.insert(permission);
			if(result > 0){
				Permissions parentPermission = Mapper.selectByPrimaryKey(permission.getParentid());
				if(parentPermission != null && parentPermission.getIsparent() == 0){
					parentPermission.setIsparent(1);
					result = Mapper.updateByPrimaryKey(parentPermission);
				}
			}
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
				result = Mapper.updateByPrimaryKeySelective(permission);
			} else {
				result = -1;
			}
		} else {
			result = Mapper.updateByPrimaryKeySelective(permission);
		}
		return result;
	}

	@Override
	public int deletePermissions(int id) {
		// TODO Auto-generated method stub
		int result=0;
		Permissions permissions = Mapper.selectByPrimaryKey(id);
		RolepermissionExample example = new RolepermissionExample();
		com.zwh.stusys.entity.RolepermissionExample.Criteria criteria = example.createCriteria();
		criteria.andPidEqualTo(permissions.getPid());
		List<Rolepermission> list = rpm.selectByExample(example);
		if(list != null && list.size() > 0){
			return -1;
		} else {
			Integer parentid = permissions.getParentid();
			result = Mapper.deleteByPrimaryKey(id);
			if(result > 0){
				PermissionsExample example2 = new PermissionsExample();
				Criteria criteria2 = example2.createCriteria();
				criteria2.andParentidEqualTo(parentid);
				long count = Mapper.countByExample(example2);
				if(count == 0){
					Permissions parentPermission = Mapper.selectByPrimaryKey(parentid);
					if(parentPermission != null){
						parentPermission.setIsparent(0);
						result = Mapper.updateByPrimaryKey(parentPermission);
					}
				}
			}
		}
		return result;
	}

	@Override
	public List<Permissions> getPermissionByParentid(int parentid) {
		// TODO Auto-generated method stub
		PermissionsExample example = new PermissionsExample();
		Criteria criteria = example.createCriteria();
		criteria.andParentidEqualTo(parentid);
		return Mapper.selectByExample(example);
	}

	@Override
	public int movePermission(int id, int oldParentid, int newParentid) {
		// TODO Auto-generated method stub
		Permissions permission = Mapper.selectByPrimaryKey(id);
		permission.setParentid(newParentid);
		int result = 0;
		result = Mapper.updateByPrimaryKey(permission);
		if(result > 0){
			PermissionsExample example = new PermissionsExample();
			Criteria criteria = example.createCriteria();
			criteria.andParentidEqualTo(oldParentid);
			long count = Mapper.countByExample(example);
			if(count == 0){
				Permissions oldpermission = Mapper.selectByPrimaryKey(oldParentid);
				oldpermission.setIsparent(0);
				Mapper.updateByPrimaryKey(oldpermission);
			}
			Permissions newpermission = Mapper.selectByPrimaryKey(newParentid);
			if(newpermission != null && newpermission.getIsparent() == 0){
				newpermission.setIsparent(1);
				Mapper.updateByPrimaryKey(newpermission);
			}
		}
		return result;
	}

}
