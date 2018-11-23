package sdibt.group.entity;

import java.util.List;
import java.util.Map;

public class FunctionTree {
	
	private int id;
	private String text;
	private String href;
	//指定列表树的节点是否可选择。设置为false将使节点展开，并且不能被选择
	private boolean selectable;
	/*state: {
	    checked:true,
	    disabled:true,
	    expanded:true,
	    selected:true
	 }*/
	private Map<String, Boolean> state;
	private List<FunctionTree> nodes;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public boolean isSelectable() {
		return selectable;
	}
	public void setSelectable(boolean selectable) {
		this.selectable = selectable;
	}
	public Map<String, Boolean> getState() {
		return state;
	}
	public void setState(Map<String, Boolean> state) {
		this.state = state;
	}
	public List<FunctionTree> getNodes() {
		return nodes;
	}
	public void setNodes(List<FunctionTree> nodes) {
		this.nodes = nodes;
	}

}
