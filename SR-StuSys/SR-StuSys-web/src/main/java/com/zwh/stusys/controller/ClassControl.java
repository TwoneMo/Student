package com.zwh.stusys.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.ClassService;
import com.zwh.stusys.service.TeacherService;

@Controller
@RequestMapping("/class/")
public class ClassControl {

	@Autowired
	private ClassService cs;
	
	@Autowired
	private TeacherService ts;
	
	@RequestMapping("toShowClass.do")
	private String toShowClass(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Users myuser = (Users) session.getAttribute("myuser");
		request.setAttribute("other", ts.searchByUid(myuser.getId()));
		return "WebJsp/Class/ClassOfShow";
	}
}
