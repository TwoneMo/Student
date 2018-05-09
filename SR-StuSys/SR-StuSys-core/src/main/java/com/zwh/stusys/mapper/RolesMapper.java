package com.zwh.stusys.mapper;

import com.zwh.stusys.entity.Roles;
import com.zwh.stusys.entity.RolesExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface RolesMapper {
    long countByExample(RolesExample example);

    int deleteByExample(RolesExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Roles record);

    int insertSelective(Roles record);

    List<Roles> selectByExample(RolesExample example);

    Roles selectByPrimaryKey(Integer id);
    
    Roles selectByTrueKey(String id);

    int updateByExampleSelective(@Param("record") Roles record, @Param("example") RolesExample example);

    int updateByExample(@Param("record") Roles record, @Param("example") RolesExample example);

    int updateByPrimaryKeySelective(Roles record);

    int updateByPrimaryKey(Roles record);
    
    List<Roles> searchAllRolesPage(@Param("role") Roles record,@Param("start") int start,@Param("length") int length);
    
    int searchCount(Roles role);
}