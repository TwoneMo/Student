package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.ScoreExample;
import com.zwh.stusys.entity.Student;
import com.zwh.stusys.entity.StudentExample;
import com.zwh.stusys.entity.StudentExample.Criteria;
import com.zwh.stusys.mapper.ScoreMapper;
import com.zwh.stusys.mapper.StudentMapper;
import com.zwh.stusys.service.StudentService;

@Service("studentService")
public class StudentServiceImpl implements StudentService {

	@Autowired
	private StudentMapper Mapper;
	
	@Autowired
	private ScoreMapper sm;
	
	@Override
	public List<Student> searchAllStudent() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Student searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Student searchByTrueId(String sid) {
		// TODO Auto-generated method stub
		return Mapper.selectByTrueKey(sid);
	}

	@Override
	public List<Student> searchAllStudentPage(Student student,int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllstudentsPage(student, start, length);
	}

	@Override
	public int searchCount(Student student) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(student);
	}

	@Override
	public int addStudent(Student student) {
		// TODO Auto-generated method stub
		int result = 0;
		result = Mapper.insert(student);
		return result;
	}

	@Override
	public int updateStudent(Student student) {
		// TODO Auto-generated method stub
		int result = 0;
		result = Mapper.updateByPrimaryKeySelective(student);
		return result;
	}

	@Override
	public int deleteStudent(int id) {
		// TODO Auto-generated method stub
		int result = 0;
		Student student = Mapper.selectByPrimaryKey(id);
		ScoreExample example = new ScoreExample();
		com.zwh.stusys.entity.ScoreExample.Criteria criteria = example.createCriteria();
		criteria.andSidEqualTo(student.getSid());
		int sflag = sm.deleteByExample(example);
		if(sflag > 0) {
			result = Mapper.deleteByPrimaryKey(id);
		}
		return result;
	}

	@Override
	public Student searchByUid(int uid) {
		// TODO Auto-generated method stub
		StudentExample example = new StudentExample();
		Criteria criteria = example.createCriteria();
		criteria.andUidEqualTo(uid);
		return Mapper.selectByExample(example).get(0);
	}

	@Override
	public List<Student> searchStudentByClassid(String classid) {
		// TODO Auto-generated method stub
		StudentExample example = new StudentExample();
		Criteria criteria = example.createCriteria();
		criteria.andClassidEqualTo(classid);
		return Mapper.selectByExample(example);
	}

	@Override
	public int setClassidToNull(Student student) {
		// TODO Auto-generated method stub
		return Mapper.setClassidToNull(student);
	}

	@Override
	public List<Student> searchClassidOfNull() {
		// TODO Auto-generated method stub
		return Mapper.searchClassidOfNull();
	}

}
