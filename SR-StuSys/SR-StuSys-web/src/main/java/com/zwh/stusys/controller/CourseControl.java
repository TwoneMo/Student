package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Course;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.CourseService;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.utils.AjaxResult;
import com.zwh.stusys.utils.DataTables;

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
	
	@RequestMapping("doShowCourse_json.do")
	@ResponseBody
	private DataTables doShowCourse_json(Course course, int start, int length) {
		// TODO Auto-generated method stub
		List<Course> list = cs.searchAllCoursePage(course, start, length);
		int searchCount = cs.searchCount(course);
		DataTables tables = new DataTables();
		tables.setData(list);
		tables.setRecordsFiltered(searchCount);
		tables.setRecordsTotal(searchCount);
		return tables;
	}
	
	@RequestMapping("toAdd.do")
	private String toAdd() {
		// TODO Auto-generated method stub
		return "WebJsp/Course/CourseOfAdd";
	}
	
	@RequestMapping("doAdd.do")
	@ResponseBody
	private AjaxResult doAdd(Course course) {
		// TODO Auto-generated method stub
		System.out.println(course.toString());
		AjaxResult ajaxResult = new AjaxResult();
		int result = cs.addCourse(course);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("课程添加成功");
		} else if(result==0){
			ajaxResult.setMessage("课程添加失败");
		} else {//result==0
			ajaxResult.setMessage("课程添加失败，该课程已经存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toEdit.do")
	private String toEdit(int id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Course course = cs.searchById(id);
		request.setAttribute("course", course);
		return "WebJsp/Course/CourseOfEdit";
	}
	
	@RequestMapping("doEdit.do")
	@ResponseBody
	private AjaxResult doEdit(Course course) {
		// TODO Auto-generated method stub
		System.out.println(course.toString());
		AjaxResult ajaxResult = new AjaxResult();
		int result = cs.updateCourse(course);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("课程修改成功");
		} else if(result==0){
			ajaxResult.setMessage("课程修改失败");
		} else {//result==0
			ajaxResult.setMessage("课程修改失败，该课程名称重复");
		}
		return ajaxResult;
	}
	
	@RequestMapping("doDel.do")
	@ResponseBody
	private AjaxResult doDel(int id) {
		// TODO Auto-generated method stub
		AjaxResult ajaxResult = new AjaxResult();
		int result = cs.deleteCourse(id);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("课程删除成功");
		} else {
			ajaxResult.setMessage("课程不存在或课程删除失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toInfo.do")
	private String toInfo(int id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Course course = cs.searchById(id);
		request.setAttribute("course", course);
		return "WebJsp/Course/CourseOfInfo";
	}
}
