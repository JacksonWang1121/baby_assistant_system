package sdibt.group.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import sdibt.group.entity.Website;

/**
 * 微官网业务逻辑接口层
 * @author JacksonWang
 *
 */
public interface IWebsiteService {

	/**
	 * 查询微官网
	 * @param schoolId
	 * @return
	 */
	public Website findWebsite(int schoolId);
	
	/**
	 * 录入微官网
	 * @param website
	 */
	public boolean saveWebsite(Website website);
	
	/**
	 * 修改微官网
	 * @param website
	 */
	public boolean updateWebsite(Website website);

}
