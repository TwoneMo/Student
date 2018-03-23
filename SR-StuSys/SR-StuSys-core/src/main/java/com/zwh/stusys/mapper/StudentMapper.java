package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Student;
import com.zwh.stusys.entity.StudentExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface StudentMapper {
    long countByExample(StudentExample example);

    int deleteByExample(StudentExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Student record);

    int insertSelective(Student record);

    List<Student> selectByExample(StudentExample example);

    Student selectByPrimaryKey(Integer id);
    
    Student selectByTrueKey(String sid);

    int updateByExampleSelective(@Param("record") Student record, @Param("example") StudentExample example);

    int updateByExample(@Param("record") Student record, @Param("example") StudentExample example);

    int updateByPrimaryKeySelective(Student record);

    int updateByPrimaryKey(Student record);
    
    List<Student> searchAllstudentsPage(@Param("student") Student student,@Param("start") int start,@Param("length") int length);
    
    int searchCount(Student student);
}