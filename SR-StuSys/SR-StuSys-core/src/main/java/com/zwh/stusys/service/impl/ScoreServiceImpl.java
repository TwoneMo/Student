package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Score;
import com.zwh.stusys.entity.ScoreExample;
import com.zwh.stusys.entity.ScoreExample.Criteria;
import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.mapper.ScoreMapper;
import com.zwh.stusys.service.ScoreService;

@Service("scoreService")
public class ScoreServiceImpl implements ScoreService {

	@Autowired
	private ScoreMapper Mapper;
	
	@Override
	public List<Score> searchAllScore() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}
	
	@Override
	public Score searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Score> searchAllScorePage(Score score, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllScorePage(score, start, length);
	}

	@Override
	public int searchCount(Score score) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(score);
	}

	@Override
	public int addScore(Score score) {
		// TODO Auto-generated method stub
		int result = 0;
		ScoreExample example = new ScoreExample();
		Criteria criteria = example.createCriteria();
		criteria.andSidEqualTo(score.getSid());
		criteria.andCourseidEqualTo(score.getCourseid());
		List<Score> list = Mapper.selectByExample(example);
		if(list != null && list.size() > 0) {
			result = -1;
		} else {
			result = Mapper.insert(score);
		}
		return result;
	}

	@Override
	public int updateScore(Score score) {
		// TODO Auto-generated method stub
		return Mapper.updateByPrimaryKey(score);
	}

	@Override
	public int deleteScore(int id) {
		// TODO Auto-generated method stub
		return deleteScore(id);
	}

	@Override
	public List<Score> searchAllScorePageByTid(Teach teach, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllScorePageBytid(teach, start, length);
	}

	@Override
	public int searchCountByTid(Teach teach) {
		// TODO Auto-generated method stub
		return Mapper.searchCountBytid(teach);
	}

}
