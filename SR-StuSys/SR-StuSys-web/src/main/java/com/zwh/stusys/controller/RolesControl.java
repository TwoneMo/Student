package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Roles;
import com.zwh.stusys.service.RoleService;
import com.zwh.stusys.utils.AjaxResult;
import com.zwh.stusys.utils.DataTables;


@Controller
@RequestMapping("/roles/")
public class RolesControl {

	@Autowired
	private RoleService rs;
	
	@RequestMapping("toadd.do")
	public String toadd(){
		return "WebJsp/Role/RoleOfAdd";
	}

	@RequestMapping("doadd.do")
	@ResponseBody
	public AjaxResult doadd(Roles role){
		int result = 0;
		AjaxResult ajaxResult = new AjaxResult();
		result = rs.addRole(role);
		ajaxResult.setTag(result);
		if(result > 0){
			ajaxResult.setMessage("添加成功");
		}else if(result == 0){
			ajaxResult.setMessage("添加失败");
		}else{
			ajaxResult.setMessage("添加失败，名字已存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toShow.do")
	public String doShow(HttpServletRequest request){
		return "WebJsp/Role/RoleOfShow";
	}
	
	@RequestMapping("doshow_json.do")
	@ResponseBody
	public DataTables doshow_json(Roles role,int start,int length){
		System.out.println("start:"+start+"length:"+length);
		List<Roles> list = rs.searchAllRolesPage(role, start, length);
		int count = rs.searchCount(role);
		DataTables table = new DataTables();
		table.setData(list);
		table.setRecordsTotal(count);
		table.setRecordsFiltered(count);
		return table;
	}
	
	@RequestMapping("toedit.do")
	public String toedit(HttpServletRequest request, int id){
		Roles role = rs.searchById(id);
		request.setAttribute("role", role);
		return "WebJsp/Role/RoleOfEdit";
	}
	
	@RequestMapping("doedit.do")
	@ResponseBody
	public AjaxResult doedit(Roles role){
		AjaxResult ajaxResult = new AjaxResult();
		int result = 0;
		result = rs.updateRole(role);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("修改成功");
		}else if(result==0){
			ajaxResult.setMessage("修改失败");
		}else{
			ajaxResult.setMessage("修改失败，名字已存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("dodel.do")
	@ResponseBody
	public AjaxResult dodel(HttpServletResponse response, int id){
		int result = 0;
		result=rs.deleteRole(id);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setTag(result);
		if(result > 0){
			ajaxResult.setMessage("删除成功");
		}else if(result == 0){
			ajaxResult.setMessage("删除失败");
		}else{
			ajaxResult.setMessage("有用户拥有该角色，删除失败");
		}
		return ajaxResult;
	}
}
