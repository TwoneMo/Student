package com.zwh.stusys.interceptor;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.zwh.stusys.entity.Permissions;




public class LoginHandlerInterceptor implements HandlerInterceptor{
	//过滤器拦截所有路径，而这个拦截器只是拦截control
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception exception)
			throws Exception {
		//dispatcherservlet进行视图返回渲染之后，即整个请求结束后。
		System.out.println(request.getRequestURI()+"参数:"+request.getQueryString());
		System.out.println("-------------------afterComletion------------------");
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView modelAndView)
			throws Exception {
		//在controller方法执行之后，但dispatcherservlet进行视图返回渲染之前，即请求处理之后
		System.out.println(request.getRequestURI()+"参数:"+request.getQueryString());
		System.out.println("-------------------postHandle------------------");
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		/*//请求执行前
		System.out.println(request.getRequestURI()+"参数:"+request.getQueryString());
		System.out.println("-------------------preHandle------------------");
		return true;//返回true继续执行下一个interceptor，若返回false则请求结束，后续的interceptor和controller都不会执行
*/		
		System.out.println(request.getRequestURL()+":"+request.getQueryString());
		System.out.println("-------------preHandle----------");
		ServletContext application = request.getSession().getServletContext();
		HttpSession session = request.getSession();
		List<Permissions> permission= (List<Permissions>) session.getAttribute("mypermission");
		System.out.println(permission+"----------------------permission---------------------");
		List<Permissions> allPermission= (List<Permissions>) application.getAttribute("allPermission");
		System.out.println(allPermission+"---------------------allPermission----------------------");
		if(permission!=null&&allPermission!=null){
			for (Permissions permission1 : allPermission) {
				System.out.println("request:"+request.getRequestURI());
				if(permission1.getUrl().trim().equals(request.getRequestURI())){
					for (Permissions permission2 : permission) {
						if(permission2.getUrl().trim().equals(request.getRequestURI())){
							return true;
						}
					}
					PrintWriter out = response.getWriter();
					out.print("<script>alert('权限不够，不能访问!')");
					out.close();
					return false;
				}
			}
		}
	return true;
	}

}
