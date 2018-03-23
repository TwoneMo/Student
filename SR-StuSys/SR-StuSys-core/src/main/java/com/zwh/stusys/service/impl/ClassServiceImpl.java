package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Class;
import com.zwh.stusys.entity.ClassExample;
import com.zwh.stusys.entity.ClassExample.Criteria;
import com.zwh.stusys.mapper.ClassMapper;
import com.zwh.stusys.service.ClassService;

@Service("classService")
public class ClassServiceImpl implements ClassService {

	@Autowired
	private ClassMapper Mapper;
	
	@Override
	public List<Class> searchAllClass() {
		// TODO Auto-generated method stu
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Class searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Class searchByTrueId(String classid) {
		// TODO Auto-generated method stub
		return Mapper.selectByTrueKey(classid);
	}

	@Override
	public List<Class> searchAllClassPage(Class myclass, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllClassPage(myclass, start, length);
	}

	@Override
	public int searchCount(Class myclass) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(myclass);
	}

	@Override
	public int addClass(Class myclass) {
		// TODO Auto-generated method stub
		int result = 0;
		ClassExample example = new ClassExample();
		Criteria criteria = example.createCriteria();
		criteria.andClassnameEqualTo(myclass.getClassname());
		List<Class> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			result = -1;//重名
		} else {
			result = Mapper.insert(myclass);
		}
		return result;
	}

	@Override
	public int updateClass(Class myclass) {
		// TODO Auto-generated method stub
		int result = 0;
		ClassExample example = new ClassExample();
		Criteria criteria = example.createCriteria();
		criteria.andClassnameEqualTo(myclass.getClassname());
		List<Class> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			if(list.get(0).getId().equals(myclass.getId())) {
				result = Mapper.updateByPrimaryKey(myclass);
			} else {
				result = -1;
			}
		} else {
			result = Mapper.updateByPrimaryKey(myclass);
		}
		return result;
	}

	@Override
	public int deleteClass(int id) {
		// TODO Auto-generated method stub
		return Mapper.deleteByPrimaryKey(id);
	}

}
