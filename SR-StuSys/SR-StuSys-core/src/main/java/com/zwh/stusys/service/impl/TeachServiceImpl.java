package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.entity.TeachExample;
import com.zwh.stusys.entity.TeachExample.Criteria;
import com.zwh.stusys.mapper.TeachMapper;
import com.zwh.stusys.service.TeachService;

@Service("teachService")
public class TeachServiceImpl implements TeachService{

	@Autowired
	private TeachMapper Mapper;
	
	@Override
	public List<Teach> searchAllTeach() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Teach searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Teach> searchAllTeachPage(Teach teach, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllTeachPage(teach, start, length);
	}

	@Override
	public int searchCount(Teach teach) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(teach);
	}

	@Override
	public int addTeach(Teach teach) {
		// TODO Auto-generated method stub
		int result = 0;
		TeachExample example = new TeachExample();
		Criteria criteria = example.createCriteria();
		criteria.andClassidEqualTo(teach.getClassid());
		criteria.andTidEqualTo(teach.getTid());
		criteria.andCourseidEqualTo(teach.getCourseid());
		List<Teach> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			result = -1;
		} else {
			result = Mapper.insert(teach);
		}
		return result;
	}

	@Override
	public int updateTeach(Teach teach) {
		// TODO Auto-generated method stub
		return Mapper.updateByPrimaryKey(teach);
	}

	@Override
	public int deleteTeach(int id) {
		// TODO Auto-generated method stub
		return Mapper.deleteByPrimaryKey(id);
	}

}
