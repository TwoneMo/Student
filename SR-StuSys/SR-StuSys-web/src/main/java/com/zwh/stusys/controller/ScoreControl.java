package com.zwh.stusys.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Class;
import com.zwh.stusys.entity.Course;
import com.zwh.stusys.entity.Score;
import com.zwh.stusys.entity.Student;
import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.entity.Users;
import com.zwh.stusys.service.ClassService;
import com.zwh.stusys.service.CourseService;
import com.zwh.stusys.service.ScoreService;
import com.zwh.stusys.service.StudentService;
import com.zwh.stusys.service.TeachService;
import com.zwh.stusys.service.TeacherService;
import com.zwh.stusys.utils.AjaxResult;
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
	
	@Autowired 
	private TeachService ts;
	
	@Autowired
	private CourseService cs;
	
	@Autowired
	private ClassService cls;
	
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
				List<Teach> tlist = ts.searchTeachByTid(teacher.getTid());
				List<Course> allcourse = cs.searchAllCourse();
				List<Class> allclass = cls.searchAllClass();
				if("003".equals(rid)) {
					List<Course> tcourse = new ArrayList<Course>();
					List<Class> tclass = new ArrayList<Class>();
					for(Course co : allcourse){
						int flagco = 0;
						for(Teach t : tlist){
							if(co.getCname().equals(t.getCourse().getCname())){
								flagco = 1;
								break;
							}
						}
						if(flagco == 1){
							tcourse.add(co);
						}
					}
					for(Class cl : allclass){
						int flagcl = 0;
						for(Teach t : tlist){
							if(cl.getClassname().equals(t.getMyclass().getClassname())){
								flagcl = 1;
								break;
							}
						}
						if(flagcl == 1){
							tclass.add(cl);
						}
					}
					
					request.setAttribute("tcourse",tcourse );
					request.setAttribute("tclass",tclass );
				}else {
					request.setAttribute("allcourse", allcourse);
					request.setAttribute("allclass", allclass);					
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
		System.out.println("-------------------"+ teach);
		DataTables tables = new DataTables();
		List<Score> list = ss.searchAllScorePageByTid(teach, start, length);
		int count = ss.searchCountByTid(teach);
		tables.setData(list);
		tables.setRecordsTotal(count);
		tables.setRecordsFiltered(count);
		return tables;
	}
	@RequestMapping("toadd.do")
	private String toadd(HttpServletRequest request){
		HttpSession session = request.getSession();
		Users myuser = (Users) session.getAttribute("myuser");
		Teacher teacher = teas.searchByUid(myuser.getId());
		List<Teach> teach = ts.searchTeachByTid(teacher.getTid());
		List<Course> list = new ArrayList<Course>();
		int flag = 0;
		for(Teach t : teach){
			flag = 0;
			Course course = cs.searchByTrueId(t.getCourseid());
			for(Course c : list){
				if(course.getCourseid().equals(c.getCourseid())){
					flag = 1;
				}
			}
			if(flag == 0){
				list.add(course);
			}
		}
		request.setAttribute("courses", list);
		return "WebJsp/Score/ScoreOfAdd";
	}
	@RequestMapping("doadd.do")
	@ResponseBody
	private AjaxResult doadd(Score score, HttpServletRequest request){
		int result = 0;
		AjaxResult ajaxResult = new AjaxResult();
		HttpSession session = request.getSession();
		Users myuser = (Users) session.getAttribute("myuser");
		Teacher teacher = teas.searchByUid(myuser.getId());
		List<Teach> teachList = ts.searchTeachByTid(teacher.getTid());
		//校验是否有教学关系
		int classFlag = 0;
		Student student = stus.searchByTrueId(score.getSid());
		if(student != null){
			for(Teach t : teachList){
				if(t.getCourseid().equals(score.getCourseid())){
					if(student.getClassid().equals(t.getClassid())){
						classFlag = 1;
						break;
					}
				}
			}
		}
		if(classFlag == 0){
			ajaxResult.setTag(result);
			ajaxResult.setMessage("添加失败，该学生不属于教授该课程的班级");
		}else {
			result = ss.addScore(score);
			ajaxResult.setTag(result);
			if(result>0){
				ajaxResult.setMessage("添加成功");
			}else if(result==0){
				ajaxResult.setMessage("添加失败");
			}else{
				ajaxResult.setMessage("添加失败，成绩已存在");
			}
		}
		return ajaxResult;
	}
	@RequestMapping("toedit.do")
	private String toedit(int id, HttpServletRequest request){
		Score score = ss.searchById(id);
		request.setAttribute("score", score);
		return "WebJsp/Score/ScoreOfEdit";
	}
	@RequestMapping("doedit.do")
	@ResponseBody
	private AjaxResult doedit(Score score){
		int result = 0;
		AjaxResult ajaxResult = new AjaxResult();
		result = ss.updateScore(score);
		ajaxResult.setTag(result);
		if(result > 0){
			ajaxResult.setMessage("成绩修改成功");
		}else{
			ajaxResult.setMessage("成绩修改失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("dodel.do")
	@ResponseBody
	private AjaxResult dodel(int id, HttpServletRequest request){
		int result = 0;
		AjaxResult ajaxResult = new AjaxResult();
		result = ss.deleteScore(id);
		ajaxResult.setTag(result);
		if(result > 0){
			ajaxResult.setMessage("成绩删除成功");
		}else{
			ajaxResult.setMessage("成绩删除失败");
		}
		return ajaxResult;
	}
	
	@RequestMapping("maxScore.do")
	@ResponseBody
	private AjaxResult maxScore(Teach teach){
		AjaxResult ajaxResult = new AjaxResult();
		Score maxScore = ss.maxScore(teach);
		if(maxScore != null){
			ajaxResult.setTag(1);
			ajaxResult.setMessage("本课程该班级最高分者："+maxScore.getStudent().getSname()+",得分："+maxScore.getScore());
		}else{
			ajaxResult.setTag(0);
			ajaxResult.setMessage("本课程该班级暂无成绩");
		}
		return ajaxResult;
	}
	
	@RequestMapping("minScore.do")
	@ResponseBody
	private AjaxResult minScore(Teach teach){
		AjaxResult ajaxResult = new AjaxResult();
		Score minScore = ss.minScore(teach);
		if(minScore != null){
			ajaxResult.setTag(1);
			ajaxResult.setMessage("本课程该班级最低分者："+minScore.getStudent().getSname()+",得分："+minScore.getScore());
		}else{
			ajaxResult.setTag(0);
			ajaxResult.setMessage("本课程该班级暂无成绩");
		}
		return ajaxResult;
	}
	
	@RequestMapping("avgScore.do")
	@ResponseBody
	private AjaxResult avgScore(Teach teach){
		AjaxResult ajaxResult = new AjaxResult();
		double avgScore = ss.avgScore(teach);
		if(avgScore != 0){
			ajaxResult.setTag(1);
			ajaxResult.setMessage("本课程该班级平均分为："+String.format("%.2f",avgScore));
		}else{
			ajaxResult.setTag(0);
			ajaxResult.setMessage("本课程该班级暂无成绩");
		}
		return ajaxResult;
	}
	
	@RequestMapping("passRate.do")
	@ResponseBody
	private AjaxResult passRate(Teach teach){
		AjaxResult ajaxResult = new AjaxResult();
		double passRate = ss.passRate(teach);
		if(passRate != 0){
			ajaxResult.setTag(1);
			ajaxResult.setMessage("本课程该班级及格率为："+String.format("%.2f",(passRate*100))+"%");
		}else{
			ajaxResult.setTag(0);
			ajaxResult.setMessage("本课程该班级暂无成绩或及格率为0%");
		}
		return ajaxResult;
	}
	
}
