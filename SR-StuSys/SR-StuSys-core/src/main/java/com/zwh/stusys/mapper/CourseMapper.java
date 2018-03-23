package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Course;
import com.zwh.stusys.entity.CourseExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CourseMapper {
    long countByExample(CourseExample example);

    int deleteByExample(CourseExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Course record);

    int insertSelective(Course record);

    List<Course> selectByExample(CourseExample example);

    Course selectByPrimaryKey(Integer id);
    
    Course selectByTrueKey(String courseid);

    int updateByExampleSelective(@Param("record") Course record, @Param("example") CourseExample example);

    int updateByExample(@Param("record") Course record, @Param("example") CourseExample example);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);
    
    List<Course> searchAllCoursePage(@Param("course") Course course,@Param("start") int start,@Param("length") int length);
    
    int searchCount(Course course);
}