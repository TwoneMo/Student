package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Permissions;
import com.zwh.stusys.entity.Roles;
import com.zwh.stusys.service.PermissionService;
import com.zwh.stusys.service.RoleService;
import com.zwh.stusys.service.RolepermissionService;
import com.zwh.stusys.utils.AjaxResult;


@Controller
@RequestMapping("/permission/")
public class PermissionControl {

	@Autowired
	private PermissionService ps;
	
	@Autowired
	private RolepermissionService rps;
	
	@Autowired
	private RoleService rs;
	
	@RequestMapping("doallot.do")
	public String doallot(HttpServletRequest request,int id){
		Roles role = rs.searchById(id);
		request.setAttribute("rid", role.getRid());
		return "WebJsp/Permission/PermissionOfAllot";
	}
	
	@RequestMapping("doallot_json.do")
	@ResponseBody
	public List<Permissions> doallot_json(String rid){
		List<Permissions> list = rps.selectroleid(rid);
		return list;
	}
	
	@RequestMapping("doshow.do")
	public String doShow(){
		return "WebJsp/Permission/PermissionOfShow";
	}
	
	@RequestMapping("doshow_json.do")
	@ResponseBody
	public List<Permissions> doshow_json(){
		List<Permissions> list = ps.searchAllPermissions();
		return list;
	}
	
	@RequestMapping("getpermissionbyparentid.do")
	@ResponseBody
	public List<Permissions> getpermissionByParentid(@RequestParam(defaultValue="0") int id){
		List<Permissions> list = ps.getPermissionByParentid(id);
		return list;
	}
	
	@RequestMapping("dispatchpermission.do")
	@ResponseBody
	public AjaxResult dispatchPermission(int[] pids,String rid){
		AjaxResult ajaxResult = new AjaxResult();
		int result = 0;
		result=rps.dispatchPermission(pids, rid);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("分配成功");
		}else{
			ajaxResult.setMessage("分配失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("toadd.do")
	public String toadd(HttpServletRequest request,int parentid,String tId){
		request.setAttribute("parentid", parentid);
		request.setAttribute("tId", tId);
		return "WebJsp/Permission/PermissionOfAdd";
	}

	@RequestMapping("doadd.do")
	@ResponseBody
	public AjaxResult doadd(Permissions permission){
		int result = 0;
		AjaxResult ajaxResult = new AjaxResult();
		result = ps.addPermissions(permission);
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

	@RequestMapping("toedit.do")
	public String toedit(HttpServletRequest request, int id, String tId){
		Permissions permission = ps.searchById(id);
		request.setAttribute("permission", permission);
		request.setAttribute("tId", tId);
		return "WebJsp/Permission/PermissionOfEdit";
	}
	
	@RequestMapping("doedit.do")
	@ResponseBody
	public AjaxResult doedit(Permissions permission){
		AjaxResult ajaxResult = new AjaxResult();
		int result = 0;
		result = ps.updatePermissions(permission);
		ajaxResult.setTag(result);
		if(result > 0){
			ajaxResult.setMessage("修改成功");
		}else if(result == 0){
			ajaxResult.setMessage("修改失败");
		}else{
			ajaxResult.setMessage("修改失败，名字已存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("dodel.do")
	@ResponseBody
	public AjaxResult dodel(int id, String parentid){
		int result = 0;
		result=ps.deletePermissions(id);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setTag(result);
		Permissions permission = ps.searchById(Integer.valueOf(parentid));
		if(permission != null){
			ajaxResult.setMessage(permission.getParentid()+"");
		}else{
			ajaxResult.setMessage("");
		}
		/*if(result>0){
			//ajaxResult.setMessage("删除成功");
		}else if(result==0){
			//ajaxResult.setMessage("删除失败");
		}else{
			//ajaxResult.setMessage("有角色拥有该权限,删除失败");
		}*/
		return ajaxResult;
	}
	
	@RequestMapping("domove.do")
	@ResponseBody
	public AjaxResult domove(int id,int oldParentid,int newParentid){
		int result = 0;
		result=ps.movePermission(id, oldParentid, newParentid);
		AjaxResult ajaxResult = new AjaxResult();
		ajaxResult.setTag(result);
		return ajaxResult;
	}
}
