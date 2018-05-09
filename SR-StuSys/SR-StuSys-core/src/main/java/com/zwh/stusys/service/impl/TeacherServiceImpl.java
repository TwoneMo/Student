package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.TeachExample;
import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.entity.TeacherExample;
import com.zwh.stusys.entity.TeacherExample.Criteria;
import com.zwh.stusys.mapper.TeachMapper;
import com.zwh.stusys.mapper.TeacherMapper;
import com.zwh.stusys.service.TeacherService;

@Service("teacherService")
public class TeacherServiceImpl implements TeacherService {

	@Autowired
	private TeacherMapper Mapper;
	
	@Autowired
	private TeachMapper tm;
	
	@Override
	public List<Teacher> searchAllTeacher() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Teacher searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Teacher searchByTrueId(String tid) {
		// TODO Auto-generated method stub
		return Mapper.selectByTrueKey(tid);
	}

	@Override
	public List<Teacher> searchAllTeacherPage(Teacher teacher, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllTeacherPage(teacher, start, length);
	}

	@Override
	public int searchCount(Teacher teacher) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(teacher);
	}

	@Override
	public int addTeacher(Teacher teacher) {
		// TODO Auto-generated method stub
		int result = 0;
		result = Mapper.insert(teacher);
		return result;
	}

	@Override
	public int updateTeacher(Teacher teacher) {
		// TODO Auto-generated method stub
		int result = 0;
		result = Mapper.updateByPrimaryKeySelective(teacher);
		return result;
	}

	@Override
	public int deleteTeacher(int id) {
		// TODO Auto-generated method stub
		int result = 0;
		Teacher teacher = Mapper.selectByPrimaryKey(id);
		TeachExample example = new TeachExample();
		com.zwh.stusys.entity.TeachExample.Criteria criteria = example.createCriteria();
		criteria.andTidEqualTo(teacher.getTid());
		int tflag = tm.deleteByExample(example);
		if(tflag > 0) {
			result = Mapper.deleteByPrimaryKey(id);
		}
		return result;
	}

	@Override
	public Teacher searchByUid(int uid) {
		// TODO Auto-generated method stub
		TeacherExample example = new TeacherExample();
		Criteria criteria = example.createCriteria();
		criteria.andUidEqualTo(uid);
		return Mapper.selectByExample(example).get(0);
	}

}
