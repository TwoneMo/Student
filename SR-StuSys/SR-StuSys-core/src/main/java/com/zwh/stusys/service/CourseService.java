package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Course;

public interface CourseService {

	public List<Course> searchAllCourse();
	
	public Course searchById(int id);
	
	public Course searchByTrueId(String courseid);
	
	public List<Course> searchAllCoursePage(Course course, int start,int length);
	
	public int searchCount(Course course);
	
	public int addCourse(Course course);
	
	public int updateCourse(Course course);
	
	public int deleteCourse(int id);
	
}
