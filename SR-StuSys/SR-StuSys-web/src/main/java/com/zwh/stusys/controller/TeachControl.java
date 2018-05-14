package com.zwh.stusys.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Class;
import com.zwh.stusys.entity.Course;
import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.service.ClassService;
import com.zwh.stusys.service.TeachService;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.utils.AjaxResult;
import com.zwh.stusys.utils.DataTables;

@Controller
@RequestMapping("/teach/")
public class TeachControl {

	@Autowired
	private TeachService ts;
	
	@Autowired
	private TeacherService teas;
	
	@Autowired
	private ClassService cs;
	
	@RequestMapping("doShowTeach_json.do")
	@ResponseBody
	private DataTables doShowCourse_json(Teach teach, int start, int length) {
		// TODO Auto-generated method stub
		List<Teach> list = ts.searchAllTeachPage(teach, start, length);
		int searchCount = ts.searchCount(teach);
		DataTables tables = new DataTables();
		tables.setData(list);
		tables.setRecordsFiltered(searchCount);
		tables.setRecordsTotal(searchCount);
		return tables;
	}
	
	@RequestMapping("doShowClass_json.do")
	@ResponseBody
	private DataTables doShowClass_json(Teach teach, int start, int length) {
		// TODO Auto-generated method stub
		List<Teach> tlist = ts.searchAllTeachPage(teach, start, length);
		List<Teach> list = new ArrayList<Teach>();
		int flag = 0;
		int searchCount = 0;
		for(Teach t : tlist){
			flag = 0;
			Class classt = cs.searchByTrueId(t.getClassid());
			for(Teach c : list){
				if(classt.getClassname().equals(c.getMyclass().getClassname())){
					flag = 1;
				}
			}
			if(flag == 0){
				list.add(t);
				searchCount++;
			}
		}
		
		DataTables tables = new DataTables();
		tables.setData(list);
		tables.setRecordsFiltered(searchCount);
		tables.setRecordsTotal(searchCount);
		return tables;
	}
	
	@RequestMapping("toAdd.do")
	private String toAdd(String courseid, HttpServletRequest request) {
		// TODO Auto-generated method stub
		List<Teacher> teacher_list = teas.searchAllTeacher();
		List<Class> class_list = cs.searchAllClass();
		request.setAttribute("courseid", courseid);
		request.setAttribute("teacher_list", teacher_list);
		request.setAttribute("class_list", class_list);
		return "WebJsp/Teach/TeachOfAdd";
	}
	
	@RequestMapping("doAdd.do")
	@ResponseBody
	private AjaxResult doAdd(Teach teach) {
		// TODO Auto-generated method stub
		System.out.println(teach.toString());
		AjaxResult ajaxResult = new AjaxResult();
		int result = ts.addTeach(teach);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("教学信息添加成功");
		} else if(result==0){
			ajaxResult.setMessage("教学信息添加失败");
		} else {//result==0
			ajaxResult.setMessage("教学信息添加失败，该教学信息已经存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toEdit.do")
	private String toEdit(int id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		List<Teacher> teacher_list = teas.searchAllTeacher();
		List<Class> class_list = cs.searchAllClass();
		Teach teach = ts.searchById(id);
		request.setAttribute("teach", teach);
		request.setAttribute("teacher_list", teacher_list);
		request.setAttribute("class_list", class_list);
		return "WebJsp/Teach/TeachOfEdit";
	}
	
	@RequestMapping("doEdit.do")
	@ResponseBody
	private AjaxResult doEdit(Teach teach) {
		// TODO Auto-generated method stub
		System.out.println(teach.toString());
		AjaxResult ajaxResult = new AjaxResult();
		int result = ts.updateTeach(teach);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("教学信息修改成功");
		} else if(result==0){
			ajaxResult.setMessage("教学信息修改失败");
		} else {//result==0
			ajaxResult.setMessage("教学信息修改失败，该教学信息已经存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("doDel.do")
	@ResponseBody
	private AjaxResult doDel(int id) {
		// TODO Auto-generated method stub
		AjaxResult ajaxResult = new AjaxResult();
		int result = ts.deleteTeach(id);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("教学信息删除成功");
		} else {
			ajaxResult.setMessage("教学信息删除失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toScore.do")
	private String toScore(int id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Teach teach_score = ts.searchById(id);
		request.setAttribute("teach_score", teach_score);
		return "WebJsp/Score/ScoreOfInfo";
	}
}
