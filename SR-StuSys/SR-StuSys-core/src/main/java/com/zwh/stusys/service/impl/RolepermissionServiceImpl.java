package com.zwh.stusys.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwh.stusys.entity.Permissions;
import com.zwh.stusys.entity.Rolepermission;
import com.zwh.stusys.entity.RolepermissionExample;
import com.zwh.stusys.entity.RolepermissionExample.Criteria;
import com.zwh.stusys.mapper.PermissionsMapper;
import com.zwh.stusys.mapper.RolepermissionMapper;
import com.zwh.stusys.service.RolepermissionService;

@Service("rolepermissionService")
public class RolepermissionServiceImpl implements RolepermissionService {

	@Autowired
	private RolepermissionMapper Mapper;
	
	@Autowired PermissionsMapper pm;
	
	@Override
	public List<Rolepermission> searchAllRolepermission() {
		// TODO Auto-generated method stub
		return Mapper.selectByExample(null);
	}

	@Override
	public Rolepermission searchById(int id) {
		// TODO Auto-generated method stub
		return Mapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Rolepermission> searchAllRolepermissionPage(Rolepermission rolepermission, int start, int length) {
		// TODO Auto-generated method stub
		return Mapper.searchAllRolepermissionPage(rolepermission, start, length);
	}

	@Override
	public int searchCount(Rolepermission rolepermission) {
		// TODO Auto-generated method stub
		return Mapper.searchCount(rolepermission);
	}

	@Override
	public int addRolepermission(Rolepermission rolepermission) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateRolepermission(Rolepermission rolepermission) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteRolepermission(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Permissions> selectroleid(String rid) {
		// TODO Auto-generated method stub
		List<Permissions> permission = pm.selectByExample(null);
		List<Rolepermission> list = Mapper.getmypermission(rid);
		for(Permissions p : permission){
			for(Rolepermission rp : list){
				if(p.getPname().equals(rp.getPermissions().getPname())){
					p.setChecked(true);
				}
			}
		}
		return permission;
	}

	@Override
	public List<Permissions> getmypermission(String rid) {
		// TODO Auto-generated method stub
		List<Rolepermission> list = Mapper.getmypermission(rid);
		List<Permissions> permissions = new ArrayList<Permissions>();
		for(Rolepermission rp:list){
			Permissions permission = rp.getPermissions();
			permissions.add(permission);
		}
		return permissions;
	}

	@Override
	public int dispatchPermission(int[] pids, String rid) {
		// TODO Auto-generated method stub
		RolepermissionExample example = new RolepermissionExample();
		Criteria criteria = example.createCriteria();
		criteria.andRidEqualTo(rid);
		int result = -1;
		result = Mapper.deleteByExample(example);
		if(result >= 0){
			for(int i=0; i < pids.length; i++){
				Rolepermission rp = new Rolepermission();
				Permissions per = pm.selectByPrimaryKey(pids[i]);
				rp.setPid(per.getPid());
				rp.setRid(rid);
				result=Mapper.insert(rp);
			}
		}
		return result;
	}

}
