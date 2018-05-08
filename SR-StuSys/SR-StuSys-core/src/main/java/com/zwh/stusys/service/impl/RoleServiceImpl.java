package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.RolepermissionExample;
import com.zwh.stusys.entity.Roles;
import com.zwh.stusys.entity.RolesExample;
import com.zwh.stusys.entity.RolesExample.Criteria;
import com.zwh.stusys.entity.UsersExample;
import com.zwh.stusys.mapper.RolepermissionMapper;
import com.zwh.stusys.mapper.RolesMapper;
import com.zwh.stusys.mapper.UsersMapper;
import com.zwh.stusys.service.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RolesMapper Mapper;
	
	@Autowired
	private UsersMapper um;
	
	@Autowired
	private RolepermissionMapper rpm;
	
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
	public List<Roles> searchAllRolesPage(Roles role, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllRoles(role, start, length);
	}

	@Override
	public int searchCount(Roles role) {
		// TODO Auto-generated method stub
		int result = 0;
		result = Mapper.searchCount(role);
		return result;
	}

	@Override
	public int addRole(Roles role) {
		// TODO Auto-generated method stub
		int result = 0;
		RolesExample example = new RolesExample();
		Criteria criteria = example.createCriteria();
		criteria.andRnameEqualTo(role.getRname());
		List<Roles> list = Mapper.selectByExample(example);
		if(list != null && list.size() != 0){
			result = -1;
		} else {
			result = Mapper.insert(role);
		}
		return result;
	}

	@Override
	public int updateRole(Roles role) {
		// TODO Auto-generated method stub
		int result = 0;
		RolesExample example = new RolesExample();
		Criteria criteria = example.createCriteria();
		criteria.andRnameEqualTo(role.getRname());
		List<Roles> list = Mapper.selectByExample(example);
		if(list != null && list.size() != 0){
			if(list.get(0).getId().equals(role.getId())){
				result = Mapper.insert(role);
			} else {
				result = -1;
			}
		} else {
			result = Mapper.insert(role);
		}
		return result;
	}

	@Override
	public int deleteRole(int id) {
		// TODO Auto-generated method stub
		int result=0;
		Roles role = Mapper.selectByPrimaryKey(id);
		RolepermissionExample example2 = new RolepermissionExample();
		com.zwh.stusys.entity.RolepermissionExample.Criteria criteria2 = example2.createCriteria();
		criteria2.andRidEqualTo(role.getRid());
		
		UsersExample example = new UsersExample();
		com.zwh.stusys.entity.UsersExample.Criteria criteria = example.createCriteria();
		criteria.andRidEqualTo(role.getRid());
		long count = um.countByExample(example);
		if(count>0){
			result=-1;
		}else{
			int flag = -1;
			flag=rpm.deleteByExample(example2);
			if(flag>=0){
				result = Mapper.deleteByPrimaryKey(id);
			}
		}
		return result;
	}

}
