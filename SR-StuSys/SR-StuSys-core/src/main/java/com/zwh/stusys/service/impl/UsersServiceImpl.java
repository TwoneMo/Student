package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.ScoreExample;
import com.zwh.stusys.entity.Student;
import com.zwh.stusys.entity.StudentExample;
import com.zwh.stusys.entity.TeachExample;
import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.entity.TeacherExample;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.entity.UsersExample;
import com.zwh.stusys.entity.UsersExample.Criteria;
import com.zwh.stusys.mapper.ScoreMapper;
import com.zwh.stusys.mapper.StudentMapper;
import com.zwh.stusys.mapper.TeachMapper;
import com.zwh.stusys.mapper.TeacherMapper;
import com.zwh.stusys.mapper.UsersMapper;
import com.zwh.stusys.service.UsersService;

@Service("usersService")
public class UsersServiceImpl implements UsersService{

	@Autowired
	private UsersMapper Mapper;
	
	@Autowired
	private StudentMapper sm;
	
	@Autowired
	private TeacherMapper tm;
	
	@Autowired
	private ScoreMapper scorem;
	
	@Autowired
	private TeachMapper teachm;
	
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
		int result = 0;
		Users user = Mapper.selectByPrimaryKey(id);
		if(user != null) {
			if(user.getRid().equals("002")) {
				StudentExample example = new StudentExample();
				com.zwh.stusys.entity.StudentExample.Criteria criteria = example.createCriteria();
				criteria.andUidEqualTo(user.getId());
				List<Student> slist = sm.selectByExample(example);
				if(slist != null && slist.size() != 0) {
					ScoreExample example2 = new ScoreExample();
					com.zwh.stusys.entity.ScoreExample.Criteria criteria2 = example2.createCriteria();
					criteria2.andSidEqualTo(slist.get(0).getSid());
					int sflag = scorem.deleteByExample(example2);
					if(sflag > 0) {
						int stuflag = sm.deleteByPrimaryKey(slist.get(0).getId());
						if(stuflag > 0) {
							result = Mapper.deleteByPrimaryKey(id);
						}
					}
				}
				
			} else {
				TeacherExample example = new TeacherExample();
				com.zwh.stusys.entity.TeacherExample.Criteria criteria = example.createCriteria();
				criteria.andUidEqualTo(user.getId());
				List<Teacher> tlist = tm.selectByExample(example);
				if(tlist != null && tlist.size() != 0) {
					TeachExample example2 = new TeachExample();
					com.zwh.stusys.entity.TeachExample.Criteria criteria2 = example2.createCriteria();
					criteria2.andTidEqualTo(tlist.get(0).getTid());
					int tflag = teachm.deleteByExample(example2);
					if(tflag > 0) {
						int teaflag = tm.deleteByPrimaryKey(tlist.get(0).getId());
						if(teaflag > 0) {
							result = Mapper.deleteByPrimaryKey(id);
						}
					}
				}
			}
		}
		return result;
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

	@Override
	public int resetPW(int id) {
		// TODO Auto-generated method stub
		int result = 0;
		Users user = Mapper.selectByPrimaryKey(id);
		if(user != null) {
			user.setPassword("123456");
			result = Mapper.updateByPrimaryKey(user);
		}
		return result;
	}

}
