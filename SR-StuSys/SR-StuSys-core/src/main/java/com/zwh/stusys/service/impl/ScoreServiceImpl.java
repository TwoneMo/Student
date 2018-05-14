package com.zwh.stusys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Course;
import com.zwh.stusys.entity.CourseExample;
import com.zwh.stusys.entity.Score;
import com.zwh.stusys.entity.ScoreExample;
import com.zwh.stusys.entity.ScoreExample.Criteria;
import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.mapper.CourseMapper;
import com.zwh.stusys.mapper.ScoreMapper;
import com.zwh.stusys.service.ScoreService;

@Service("scoreService")
public class ScoreServiceImpl implements ScoreService {

	@Autowired
	private ScoreMapper Mapper;
	
	@Autowired
	private CourseMapper cm;
	
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
		System.out.println(score);
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
		return Mapper.deleteByPrimaryKey(id);
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

	@Override
	public Score maxScore(Teach teach) {
		// TODO Auto-generated method stub
		double maxscore = 0;
		Score maxScore = null;
		List<Score> list = Mapper.searchAllScoreBytid(teach);
		if(list != null && list.size() != 0){
			for(Score s : list){
				if(s.getScore() > maxscore){
					maxScore = s;
					maxscore = s.getScore();
				}
			}
		}
		return maxScore;	
	}

	@Override
	public Score minScore(Teach teach) {
		// TODO Auto-generated method stub
		double minscore = 0;
		Score minScore = null;
		List<Score> list = Mapper.searchAllScoreBytid(teach);
		if(list != null && list.size() != 0){
			minscore = list.get(0).getScore();
			minScore = list.get(0);
			for(Score s : list){
				if(s.getScore() < minscore){
					minScore = s;
					minscore = s.getScore();
				}
			}
		}
		return minScore;
	}

	@Override
	public double avgScore(Teach teach) {
		// TODO Auto-generated method stub
		double avgsocre = 0;
		double sumscore = 0;
		List<Score> list = Mapper.searchAllScoreBytid(teach);
		if(list != null && list.size() != 0){
			for(Score s : list){
				sumscore = sumscore + s.getScore();
			}
			avgsocre = (double)sumscore/list.size();
		}
		return avgsocre;
	}

	@Override
	public double passRate(Teach teach) {
		// TODO Auto-generated method stub
		double passRate = 0;
		int passCount = 0;
		List<Score> slist = Mapper.searchAllScoreBytid(teach);
		CourseExample example = new CourseExample();
		com.zwh.stusys.entity.CourseExample.Criteria criteria = example.createCriteria();
		criteria.andCourseidEqualTo(teach.getCourseid());
		List<Course> list = cm.selectByExample(example);
		if(list != null && list.size() != 0){
			double passScore = list.get(0).getScore() * 0.6;
			if(slist != null && slist.size() != 0){
				for(Score s : slist){
					if(s.getScore() > passScore){
						passCount++;
					}
				}
				passRate = (double)passCount/slist.size();
			}
		}
		return passRate;
	}

}
