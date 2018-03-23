package com.zwh.stusys.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.utils.AjaxResult;

@Controller
@RequestMapping("/teachers/")
public class TeachersControl {

	@Autowired
	private TeacherService ts;
	
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
}
