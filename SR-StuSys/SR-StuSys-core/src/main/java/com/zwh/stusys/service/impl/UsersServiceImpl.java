package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Users;
import com.zwh.stusys.entity.UsersExample;
import com.zwh.stusys.entity.UsersExample.Criteria;
import com.zwh.stusys.mapper.UsersMapper;
import com.zwh.stusys.service.UsersService;

@Service("usersService")
public class UsersServiceImpl implements UsersService{

	@Autowired
	private UsersMapper Mapper;
	
	@Override
	public List<Users> searchAllUsers() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}

	@Override
	public Users searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Users> searchAllUsersPage(Users user, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllUsersPage(user, start, length);
	}

	@Override
	public int searchCount(Users user) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(user);
	}

	@Override
	public int addUsers(Users user) {
		// TODO Auto-generated method stub
		int result = 0;
		UsersExample example = new UsersExample();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(user.getUsername());
		List<Users> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			result = -1;//重名
		} else {
			result = Mapper.insert(user);
		}
		return result;
	}

	@Override
	public int updateUsers(Users user) {
		// TODO Auto-generated method stub
		int result = 0;
		UsersExample example = new UsersExample();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(user.getUsername());
		List<Users> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			if(list.get(0).getId().equals(user.getId())) {
				result = Mapper.updateByPrimaryKey(user);
			} else {
				result = -1;
			}
		} else {
			result = Mapper.updateByPrimaryKey(user);
		}
		return result;
	}

	@Override
	public int deleteUsers(int id) {
		// TODO Auto-generated method stub
		return Mapper.deleteByPrimaryKey(id);
	}

	@Override
	public Users login(Users user) {
		// TODO Auto-generated method stub
		return Mapper.login(user);
	}

	@Override
	public Users searchByname(String name) {
		// TODO Auto-generated method stub
		UsersExample example = new UsersExample();
		Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(name);
		List<Users> list = Mapper.selectByExample(example);
		return list.get(0);
	}

}
