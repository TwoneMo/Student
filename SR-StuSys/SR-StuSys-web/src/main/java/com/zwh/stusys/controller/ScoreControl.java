package com.zwh.stusys.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Score;
import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.ScoreService;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.service.TeachService;
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
	private TeacherService teas;
	
	@Autowired TeachService ts;
	
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
				Teacher teacher = teas.searchByUid(myuser.getId());
				request.setAttribute("other", teacher);
				if("003".equals(rid)) {
					request.setAttribute("teach", ts.searchTeachByTid(teacher.getTid()));
				}
			}
		}
		return "WebJsp/Score/ScoreOfShow";
	}
	
	@RequestMapping("doShowScore_json.do")
	@ResponseBody
	private DataTables doShowScore_json(Score score, int start, int length) {
		// TODO Auto-generated method stub
		List<Score> list = ss.searchAllScorePage(score, start, length);
		DataTables tables = new DataTables();
		int count = ss.searchCount(score);
		tables.setData(list);
		tables.setRecordsTotal(count);
		tables.setRecordsFiltered(count);
		return tables;
	}
	
	@RequestMapping("doShowScore_jsonOfTea.do")
	@ResponseBody
	private DataTables doShowScore_jsonOfTea(Teach teach, int start, int length) {
		// TODO Auto-generated method stub
		DataTables tables = new DataTables();
		List<Score> list = ss.searchAllScorePageByTid(teach, start, length);
		int count = ss.searchCountByTid(teach);
		tables.setData(list);
		tables.setRecordsTotal(count);
		tables.setRecordsFiltered(count);
		return tables;
	}
	
	@RequestMapping("toadd.do")
	private String toadd(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return "WebJsp/Score/ScoreOfAdd";
	}
	
}
