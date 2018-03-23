package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Class;
import com.zwh.stusys.entity.ClassExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ClassMapper {
    long countByExample(ClassExample example);

    int deleteByExample(ClassExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Class record);

    int insertSelective(Class record);

    List<Class> selectByExample(ClassExample example);

    Class selectByPrimaryKey(Integer id);
    
    Class selectByTrueKey(String classid);

    int updateByExampleSelective(@Param("record") Class record, @Param("example") ClassExample example);

    int updateByExample(@Param("record") Class record, @Param("example") ClassExample example);

    int updateByPrimaryKeySelective(Class record);

    int updateByPrimaryKey(Class record);
    
    List<Class> searchAllClassPage(@Param("myclass") Class myclass,@Param("start") int start,@Param("length") int length);
    
    int searchCount(Class myclass);
}