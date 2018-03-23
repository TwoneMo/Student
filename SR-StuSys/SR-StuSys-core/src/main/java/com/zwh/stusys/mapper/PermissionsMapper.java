package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Permissions;
import com.zwh.stusys.entity.PermissionsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PermissionsMapper {
    long countByExample(PermissionsExample example);

    int deleteByExample(PermissionsExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Permissions record);

    int insertSelective(Permissions record);

    List<Permissions> selectByExample(PermissionsExample example);

    Permissions selectByPrimaryKey(Integer id);
    
    Permissions selectByTrueKey(String pid);

    int updateByExampleSelective(@Param("record") Permissions record, @Param("example") PermissionsExample example);

    int updateByExample(@Param("record") Permissions record, @Param("example") PermissionsExample example);

    int updateByPrimaryKeySelective(Permissions record);

    int updateByPrimaryKey(Permissions record);
    
    List<Permissions> searchAllPermissionsPage(@Param("permissions") Permissions permissions,@Param("start") int start,@Param("end") int end);
    
    int searchCount(Permissions permissions);
}