package com.zonda.service.plugin.regionselect.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zonda.dao.DaoSupport;
import com.zonda.service.plugin.regionselect.RegionSelectManager;
import com.zonda.util.PageData;

/**
 * 类名称：regionSelectService
 * 
 * @author FH Q313596790 修改时间：2015年11月6日
 */
@Service("regionSelectService")
public class RegionSelectService implements RegionSelectManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/**
	 * 通过用户名获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> findByParentRegion(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("RegionMapper.findByParentRegion", pd);
	}

}
