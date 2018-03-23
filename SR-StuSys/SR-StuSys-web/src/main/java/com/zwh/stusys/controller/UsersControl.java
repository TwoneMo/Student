package com.zwh.stusys.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Roles;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.RoleService;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.service.UsersService;
import com.zwh.stusys.utils.AjaxResult;

@Controller
@RequestMapping("/users/")
public class UsersControl {

	@Autowired
	private UsersService us;
	
	@Autowired
	private RoleService rs;
	
	@Autowired
	private StudentService ss;
	
	@Autowired
	private TeacherService ts;
	
	@RequestMapping("tologin.do")
	public String toLogin() {
		return "WebJsp/login";
	}
	
	@RequestMapping("dologin.do")
	public String doLogin(PrintWriter out, HttpServletRequest request, HttpServletResponse response, Users user) {
		boolean flag = false;
		HttpSession session = request.getSession();
		String sUsername = (String) session.getAttribute("sUsername");
		Users myuser = us.login(user);
		if(myuser!=null||sUsername!=null) {
			flag=true;
		}
		if(flag) {
			String name = null;
			if(myuser!=null) {
				name = myuser.getUsername();				
			} else if(sUsername!=null){
				name = sUsername;
			}
			
			try {
				name = URLEncoder.encode(name,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			Cookie cookie = new Cookie("cUsername",name);
			cookie.setMaxAge(60*30);
			session.setAttribute("sUsername", name);
			if(myuser==null) {
				myuser = us.searchByname(name);
			}
			session.setAttribute("myuser", myuser);
			String rid = myuser.getRid();
			if(rid!=null&&!"".equals(rid)) {
				if("002".equals(rid)) {
					request.setAttribute("student", ss.searchByUid(myuser.getId()));
				} else {
					request.setAttribute("other", ts.searchByUid(myuser.getId()));
				}
			}
			response.addCookie(cookie);
			
			/*user = myuser;
			List<Permission> list = ps.getmypermission(user.getUserRoleid());
			session.setAttribute("permission", list);
			
			ServletContext application = session.getServletContext();
			List<Permissions> allPermission = ps.selectAll();
			application.setAttribute("allPermission", allPermission);*/
			
			return "WebJsp/index";
		} else {
			out.print("<script>alert('对不起，用户名或密码错误！');history.go(-1);</script>");
			return null;
		}
	}
	
	@RequestMapping("toCreateAccount.do")
	public String toCreateAccount(HttpServletRequest request) {
		List<Roles> list = rs.searchAllRoles();
		HttpSession session = request.getSession();
		session.setAttribute("roles", list);
//		return "WebJsp/createAccount";
		return "WebJsp/Users/UserOfAdd";
	}
	
	@RequestMapping("doCreateAccount.do")
	@ResponseBody
	public AjaxResult doCreateAccount(Users user){
		int result = 0;
		AjaxResult ajaxResult = new AjaxResult();
		result = us.addUsers(user);
		ajaxResult.setTag(result);
		if(result>0){
			ajaxResult.setMessage("注册成功");
		}else if(result==0){
			ajaxResult.setMessage("注册失败");
		}else{
			ajaxResult.setMessage("注册失败，账户已存在");
		}
		return ajaxResult;
	}
	
	@RequestMapping("outlogin.do")
	public String outLogin(HttpServletRequest request,HttpServletResponse response){
		HttpSession session = request.getSession();
		session.removeAttribute("sUsername");
		return "WebJsp/login";
	}
	
	@RequestMapping("toShowSelf.do")
	private String toShowSelf(HttpServletRequest request) {
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
		return "WebJsp/Users/UserOfShowSelf";
	}
	
	@RequestMapping("toEditPassword.do")
	private String toEditPassword() {
		// TODO Auto-generated method stub
		return "WebJsp/Users/UserOfEdit";
	}
	
	@RequestMapping("doEditPassword.do")
	@ResponseBody
	private AjaxResult doEditPassword(Users user, String oldpassword) {
		// TODO Auto-generated method stub
		AjaxResult ajaxResult = new AjaxResult();
		int result = 0;
		System.out.println(user.toString());
		System.out.println(oldpassword);
		Users trueU = us.searchById(user.getId());
		if(trueU!=null&&trueU.getUsername().equals(user.getUsername())&&trueU.getPassword().equals(oldpassword)) {
			result = us.updateUsers(user);
			ajaxResult.setTag(result);
			if(result>0){
				ajaxResult.setMessage("修改成功");
			} else {//result==0
				ajaxResult.setMessage("修改失败");
			}
		} else {
			ajaxResult.setMessage("修改失败,旧密码错误！");
		}
		
		return ajaxResult;
	}
}
