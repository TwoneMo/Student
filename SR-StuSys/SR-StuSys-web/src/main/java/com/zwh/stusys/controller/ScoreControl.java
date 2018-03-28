package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Score;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.ScoreService;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.utils.DataTables;

@Controller
@RequestMapping("/score/")
public class ScoreControl {

	@Autowired
	private ScoreService ss;
	
	@Autowired
	private StudentService stus;
	
	@Autowired
	private TeacherService ts;
	
	@RequestMapping("toShowScore.do")
	private String toShowScore(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Users myuser = (Users) session.getAttribute("myuser");
		String rid = myuser.getRid();
		if(rid!=null&&!"".equals(rid)) {
			if("002".equals(rid)) {
				request.setAttribute("student", stus.searchByUid(myuser.getId()));
			} else {
				request.setAttribute("other", ts.searchByUid(myuser.getId()));
			}
		}
		return "WebJsp/Score/ScoreOfShow";
	}
	
	@RequestMapping("doShowScore_json.do")
	@ResponseBody
	private DataTables doShowCourseOfStu(Score score, int start, int length) {
		// TODO Auto-generated method stub
		List<Score> list = ss.searchAllScorePage(score, start, length);
		DataTables table = new DataTables();
		int count = ss.searchCount(score);
		table.setData(list);
		table.setRecordsTotal(count);
		table.setRecordsFiltered(count);
		return table;
	}
}
