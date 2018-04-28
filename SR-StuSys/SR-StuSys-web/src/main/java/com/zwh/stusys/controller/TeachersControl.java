package com.zwh.stusys.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.service.UsersService;
import com.zwh.stusys.utils.AjaxResult;

@Controller
@RequestMapping("/teachers/")
public class TeachersControl {

	@Autowired
	private TeacherService ts;
	
	@Autowired
	private UsersService us;
	
	@RequestMapping("doEditSelf.do")
	@ResponseBody
	private AjaxResult doEdittSelf(Teacher teacher) {
		// TODO Auto-generated method stub
		AjaxResult ajaxResult = new AjaxResult();
		int result = 0;
		System.out.println(teacher.toString());
		result = ts.updateTeacher(teacher);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("修改成功");
		} else {//result==0
			ajaxResult.setMessage("修改失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toAdd.do")
	private String toAdd(String username, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Users user = us.searchByname(username);
		request.setAttribute("user", user);
		return "/WebJsp/Teacher/TeacherOfAdd";
	}
	
	@RequestMapping("doAdd.do")
	@ResponseBody
	private AjaxResult doAdd(Teacher teacher) {
		// TODO Auto-generated method stub
		System.out.println(teacher.toString());
		AjaxResult ajaxResult = new AjaxResult();
		int result = ts.addTeacher(teacher);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("教师添加成功");
		} else {//result==0
			ajaxResult.setMessage("教师添加失败");
		}
		return ajaxResult;
	}
}
