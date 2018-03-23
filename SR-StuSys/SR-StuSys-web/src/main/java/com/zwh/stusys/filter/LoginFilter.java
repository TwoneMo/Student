package com.zwh.stusys.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("-------��½��֤��������-------");
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpSession session = request.getSession();
		String uri = request.getRequestURI();
		uri = uri.toLowerCase();
		System.out.println(uri);
		if(uri.indexOf("css")==-1&&uri.indexOf("js")==-1&& uri.indexOf("login")==-1&& uri.indexOf("zc")==-1){
			String Username = (String)session.getAttribute("sUserName");
			if(Username == null){
	    		PrintWriter out = response.getWriter();
	    		String path = request.getContextPath();
	    		out.print("<script>alert('�Բ������ȵ�½��');location.href='"+path+"/admin/users/tologin.do'</script>");/**/
			}else{
	    		chain.doFilter(request, response);
	    	}
		}else{
			chain.doFilter(request, response);
		}
		
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("-------��½��֤���˳�ʼ��-------");
	}

}
