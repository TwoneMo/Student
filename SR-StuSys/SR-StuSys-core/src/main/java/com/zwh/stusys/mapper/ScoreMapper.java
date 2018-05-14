package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Score;
import com.zwh.stusys.entity.ScoreExample;
import com.zwh.stusys.entity.Teach;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ScoreMapper {
    long countByExample(ScoreExample example);

    int deleteByExample(ScoreExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Score record);

    int insertSelective(Score record);

    List<Score> selectByExample(ScoreExample example);

    Score selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Score record, @Param("example") ScoreExample example);

    int updateByExample(@Param("record") Score record, @Param("example") ScoreExample example);

    int updateByPrimaryKeySelective(Score record);

    int updateByPrimaryKey(Score record);
    
    List<Score> searchAllScorePage(@Param("score") Score score,@Param("start") int start,@Param("length") int length);
    
    int searchCount(Score score);
    
    List<Score> searchAllScorePageBytid(@Param("teach") Teach teach,@Param("start") int start,@Param("length") int length);
    
    int searchCountBytid(Teach teach);
    
    List<Score> searchAllScoreBytid(Teach teach);
}