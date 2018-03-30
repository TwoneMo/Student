package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Student;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.utils.AjaxResult;
import com.zwh.stusys.utils.DataTables;

@Controller
@RequestMapping("/students/")
public class StudentsControl {

	@Autowired
	private StudentService ss;
	
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
}
