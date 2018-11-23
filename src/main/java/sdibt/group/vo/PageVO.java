package sdibt.group.vo;


import java.io.Serializable;
import java.util.List;


/**
 * 分页可视化
 * @author JacksonWang
 *
 */
public class PageVO implements Serializable {
	
	private int curPage;//当前页号
	private int pages;//总页数
	private int pageSize=5;//每页数据条数
	private List data = null;//每页显示的数据
	private int total;//信息总数
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPages() {
		return pages;
	}
	public void setPages(int pages) {
		this.pages = pages;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public List getData() {
		return data;
	}
	public void setData(List data) {
		this.data = data;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}

}