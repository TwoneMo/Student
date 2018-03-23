package com.zwh.stusys.service;

import java.util.List;

import com.zwh.stusys.entity.Score;


public interface ScoreService {

	public List<Score> searchAllScore();
	
	public Score searchById(int id);
	
	public List<Score> searchAllScorePage(Score score, int start,int length);
	
	public int searchCount(Score score);
	
	public int addScore(Score score);
	
	public int updateScore(Score score);
	
	public int deleteScore(int id);
	
}
