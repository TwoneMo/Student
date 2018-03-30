package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Student;

public interface StudentService {

	public List<Student> searchAllStudent();
	
	public Student searchById(int id);
	
	public Student searchByTrueId(String sid);
	
	public List<Student> searchAllStudentPage(Student student,int start,int length);
	
	public int searchCount(Student student);
	
	public int addStudent(Student student);
	
	public int updateStudent(Student student);
	
	public int deleteStudent(int id);
	
	public Student searchByUid(int uid);
	
	public List<Student> searchStudentByClassid(String classid);
}
