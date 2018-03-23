package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Course;
import com.zwh.stusys.entity.CourseExample;
import com.zwh.stusys.entity.CourseExample.Criteria;
import com.zwh.stusys.mapper.CourseMapper;
import com.zwh.stusys.service.CourseService;

@Service("courseService")
public class CourseServiceImpl implements CourseService {

	@Autowired
	private CourseMapper Mapper;
	
	@Override
	public List<Course> searchAllCourse() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Course searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Course searchByTrueId(String courseid) {
		// TODO Auto-generated method stub
		return Mapper.selectByTrueKey(courseid);
	}

	@Override
	public List<Course> searchAllCoursePage(Course course, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllCoursePage(course, start, length);
	}

	@Override
	public int searchCount(Course course) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(course);
	}

	@Override
	public int addCourse(Course course) {
		// TODO Auto-generated method stub
		int result = 0;
		CourseExample example = new CourseExample();
		Criteria criteria = example.createCriteria();
		criteria.andCnameEqualTo(course.getCname());
		List<Course> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			result = -1;
		} else {
			result = Mapper.insert(course);
		}
		return result;
	}

	@Override
	public int updateCourse(Course course) {
		// TODO Auto-generated method stub
		int result = 0;
		CourseExample example = new CourseExample();
		Criteria criteria = example.createCriteria();
		criteria.andCnameEqualTo(course.getCname());
		List<Course> list = Mapper.selectByExample(example);
		if(list!=null&&list.size()>0) {
			if(list.get(0).getId().equals(course.getId())) {
				result = Mapper.updateByPrimaryKey(course);
			} else {
				result = -1;
			}
		} else {
			result = Mapper.updateByPrimaryKey(course);
		}
		return result;
	}

	@Override
	public int deleteCourse(int id) {
		// TODO Auto-generated method stub
		return Mapper.deleteByPrimaryKey(id);
	}

}
