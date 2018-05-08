package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Class;
import com.zwh.stusys.entity.Student;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.ClassService;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.service.UsersService;
import com.zwh.stusys.utils.AjaxResult;
import com.zwh.stusys.utils.DataTables;

@Controller
@RequestMapping("/students/")
public class StudentsControl {

	@Autowired
	private StudentService ss;
	
	@Autowired
	private UsersService us;
	
	@Autowired
	private ClassService cs;
	
	@RequestMapping("doEditSelf.do")
	@ResponseBody
	private AjaxResult doEditsSelf(Student student) {
		// TODO Auto-generated method stub
		AjaxResult ajaxResult = new AjaxResult();
		int result = 0;
		System.out.println(student.toString());
		result = ss.updateStudent(student);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("修改成功");
		} else {//result==0
			ajaxResult.setMessage("修改失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toShowStudent.do")
	private String toShowStudent(String classid, HttpServletRequest request) {
		// TODO Auto-generated method stub
		request.setAttribute("classid", classid);
		return "/WebJsp/Student/StudentOfShow";
	}
	
	@RequestMapping("doShowStudent_json.do")
	@ResponseBody
	private DataTables doShowStudent_json(Student student, int start, int length) {
		// TODO Auto-generated method stub
		List<Student> list = ss.searchAllStudentPage(student, start, length);
		int count = ss.searchCount(student);
		DataTables tables = new DataTables();
		tables.setData(list);
		tables.setRecordsFiltered(count);
		tables.setRecordsTotal(count);
		return tables;
	}
	
	@RequestMapping("toShowStuByid.do")
	private String toShowStuByid(String id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Student stu = ss.searchById(Integer.valueOf(id));
		request.setAttribute("stu", stu);
		return "WebJsp/Student/StudentOfInfo";
	}
	
	@RequestMapping("toAdd.do")
	private String toAdd(String username, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Users user = us.searchByname(username);
		List<Class> classlist = cs.searchAllClass();
		request.setAttribute("classlist", classlist);
		request.setAttribute("user", user);
		return "/WebJsp/Student/StudentOfAdd";
	}
	
	@RequestMapping("doAdd.do")
	@ResponseBody
	private AjaxResult doAdd(Student student) {
		// TODO Auto-generated method stub
		System.out.println(student);
		int result = ss.addStudent(student);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setTag(result);
		if(result > 0) {
			ajaxResult.setMessage("学生添加成功");
		}else {
			ajaxResult.setMessage("学生添加失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toAddC.do")
	private String toAddC(String classid, HttpServletRequest request) {
		// TODO Auto-generated method stub
		List<Student> list = ss.searchClassidOfNull();
		request.setAttribute("classid", classid);
		request.setAttribute("NoClassStu", list);
		return "/WebJsp/Student/StudentOfAddC";
	}
	
	@RequestMapping("doAddC.do")
	@ResponseBody
	private AjaxResult doAddC(Student student) {
		// TODO Auto-generated method stub
		System.out.println(student);
		int result = ss.updateStudent(student);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setTag(result);
		if(result > 0) {
			ajaxResult.setMessage("学生已添加至该班级");
		}else {
			ajaxResult.setMessage("学生添加至该班级失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toEditC.do")
	private String toEditC(int id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Student cstu = ss.searchById(id);
		List<Class> classlist = cs.searchAllClass();
		request.setAttribute("classlist", classlist);
		request.setAttribute("cstu", cstu);
		return "/WebJsp/Student/StudentOfEditC";
	}
	
	@RequestMapping("doEditC.do")
	@ResponseBody
	private AjaxResult doEditC(Student student) {
		// TODO Auto-generated method stub
		System.out.println(student);
		int result = ss.updateStudent(student);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setTag(result);
		if(result > 0) {
			ajaxResult.setMessage("学生的班级信息修改成功");
		}else {
			ajaxResult.setMessage("学生的班级信息修改失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("doDelC.do")
	@ResponseBody
	private AjaxResult doDelC(int id) {
		// TODO Auto-generated method stub
		Student student = new Student();
		student.setId(id);
		int result = ss.setClassidToNull(student);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setTag(result);
		if(result > 0) {
			ajaxResult.setMessage("学生的班级信息删除成功");
		}else {
			ajaxResult.setMessage("学生的班级信息删除失败");
		}
		return ajaxResult;
	}
}
