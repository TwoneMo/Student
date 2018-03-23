package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Teach;
import com.zwh.stusys.entity.TeachExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeachMapper {
    long countByExample(TeachExample example);

    int deleteByExample(TeachExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Teach record);

    int insertSelective(Teach record);

    List<Teach> selectByExample(TeachExample example);

    Teach selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Teach record, @Param("example") TeachExample example);

    int updateByExample(@Param("record") Teach record, @Param("example") TeachExample example);

    int updateByPrimaryKeySelective(Teach record);

    int updateByPrimaryKey(Teach record);
    
    List<Teach> searchAllTeachPage(@Param("teach") Teach teach,@Param("start") int start,@Param("length") int length);
    
    int searchCount(Teach teach);
}