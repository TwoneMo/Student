package com.zwh.stusys.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Student;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.utils.AjaxResult;

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
}
