package com.zonda.service.plugin.regionselect;

import java.util.List;

import com.zonda.util.PageData;

/**
 * 地市选择插件接口类
 * 
 * @author fh313596790qq(青苔) 修改时间：2015.11.2
 */
public interface RegionSelectManager {

	/**
	 * 通过父级地市获取数据
	 * 
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findByParentRegion(PageData pd) throws Exception;

}