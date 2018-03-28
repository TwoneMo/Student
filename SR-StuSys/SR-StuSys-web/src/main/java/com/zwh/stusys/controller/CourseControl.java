package com.zwh.stusys.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.CourseService;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.service.TeacherService;

@Controller
@RequestMapping("/course/")
public class CourseControl {

	@Autowired
	private CourseService cs;
	
	@Autowired
	private StudentService ss;
	
	@Autowired
	private TeacherService ts;
	
	@RequestMapping("toShowCourse.do")
	private String toShowCourse(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Users myuser = (Users) session.getAttribute("myuser");
		String rid = myuser.getRid();
		if(rid!=null&&!"".equals(rid)) {
			if("002".equals(rid)) {
				request.setAttribute("student", ss.searchByUid(myuser.getId()));
			} else {
				request.setAttribute("other", ts.searchByUid(myuser.getId()));
			}
		}
		return "WebJsp/Course/CourseOfShow";
	}
}
