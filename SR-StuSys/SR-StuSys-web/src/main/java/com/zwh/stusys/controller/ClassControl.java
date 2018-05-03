package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Class;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.ClassService;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.utils.AjaxResult;
import com.zwh.stusys.utils.DataTables;

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
	
	@RequestMapping("doShowClass_json.do")
	@ResponseBody
	private DataTables doShowClass_json(Class myclass, int start, int length) {
		// TODO Auto-generated method stub
		List<Class> list = cs.searchAllClassPage(myclass, start, length);
		int count = cs.searchCount(myclass);
		DataTables tables = new DataTables();
		tables.setData(list);
		tables.setRecordsFiltered(count);
		tables.setRecordsTotal(count);
		return tables;
	}
		
	@RequestMapping("toAdd.do")
	private String toAdd() {
		// TODO Auto-generated method stub
		return "WebJsp/Class/ClassOfAdd";
	}
	
	@RequestMapping("doAdd.do")
	@ResponseBody
	private AjaxResult doAdd(Class myclass) {
		// TODO Auto-generated method stub
		System.out.println(myclass.toString());
		AjaxResult ajaxResult = new AjaxResult();
		int result = cs.addClass(myclass);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("班级添加成功");
		} else if(result==0){
			ajaxResult.setMessage("班级添加失败");
		} else {//result==0
			ajaxResult.setMessage("班级添加失败，该班级已经存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toEdit.do")
	private String toEdit(int id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Class myclass = cs.searchById(id);
		request.setAttribute("class", myclass);
		return "WebJsp/Class/ClassOfEdit";
	}
	
	@RequestMapping("doEdit.do")
	@ResponseBody
	private AjaxResult doEdit(Class myclass) {
		// TODO Auto-generated method stub
		System.out.println(myclass.toString());
		AjaxResult ajaxResult = new AjaxResult();
		int result = cs.updateClass(myclass);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("班级修改成功");
		} else if(result==0){
			ajaxResult.setMessage("班级修改失败");
		} else {//result==0
			ajaxResult.setMessage("班级修改失败，该班级名称重复");
		}
		return ajaxResult;
	}
	
	@RequestMapping("doDel.do")
	@ResponseBody
	private AjaxResult doDel(int id) {
		// TODO Auto-generated method stub
		AjaxResult ajaxResult = new AjaxResult();
		int result = cs.deleteClass(id);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("班级删除成功");
		} else {
			ajaxResult.setMessage("班级不存在或班级删除失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toInfo.do")
	private String toInfo(int id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		Class myclass = cs.searchById(id);
		request.setAttribute("classid", myclass.getClassid());
		return "WebJsp/Student/StudentOfShow";
	}
}
