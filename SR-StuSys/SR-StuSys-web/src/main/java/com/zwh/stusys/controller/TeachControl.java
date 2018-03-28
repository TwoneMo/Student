package com.zwh.stusys.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.service.TeachService;
import com.zwh.stusys.utils.DataTables;

@Controller
@RequestMapping("/teach/")
public class TeachControl {

	@Autowired
	private TeachService ts;
	
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
}
