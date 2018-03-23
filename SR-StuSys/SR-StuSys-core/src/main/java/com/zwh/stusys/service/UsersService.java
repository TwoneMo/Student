package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Users;

public interface UsersService {

	public List<Users> searchAllUsers();
	
	public Users searchById(int id);
	
	public List<Users> searchAllUsersPage(Users user,int start,int length);
	
	public int searchCount(Users user);
	
	public int addUsers(Users user);
	
	public int updateUsers(Users user);
	
	public int deleteUsers(int id);
	
	public Users login(Users user);
	
	public Users searchByname(String name);
	
}
