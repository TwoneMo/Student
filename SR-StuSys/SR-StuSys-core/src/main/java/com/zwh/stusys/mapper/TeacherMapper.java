package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Teacher;
import com.zwh.stusys.entity.TeacherExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TeacherMapper {
    long countByExample(TeacherExample example);

    int deleteByExample(TeacherExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Teacher record);

    int insertSelective(Teacher record);

    List<Teacher> selectByExample(TeacherExample example);

    Teacher selectByPrimaryKey(Integer id);
    
    Teacher selectByTrueKey(String tid);

    int updateByExampleSelective(@Param("record") Teacher record, @Param("example") TeacherExample example);

    int updateByExample(@Param("record") Teacher record, @Param("example") TeacherExample example);

    int updateByPrimaryKeySelective(Teacher record);

    int updateByPrimaryKey(Teacher record);
    
    List<Teacher> searchAllTeacherPage(@Param("teacher") Teacher teacher,@Param("start") int start,@Param("length") int length);
    
    int searchCount(Teacher teacher);
}