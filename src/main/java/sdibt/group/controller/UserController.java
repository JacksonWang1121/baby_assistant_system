package sdibt.group.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;

import sdibt.group.entity.FunctionTree;
import sdibt.group.entity.Kindergarten;
import sdibt.group.entity.Permission;
import sdibt.group.entity.User;
import sdibt.group.service.IKindergartenService;
import sdibt.group.service.IRoleService;
import sdibt.group.service.IUserService;
import sdibt.group.util.PasswordHelper;
/**
 * 
 * Title:UserController
 * @author chidianwei
 * package:sdibt.group.controller
 * date:2018年7月12日 上午9:21:41
 * version:1.0
 */
@Controller
@RequestMapping("/user")
public class UserController {
	@Resource 
	private IUserService userService;
	@Resource
	private IRoleService roleService;
	@Resource
	private IKindergartenService kindergartenService;

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

	public void setRoleService(IRoleService roleService) {
		this.roleService = roleService;
	}

	public void setKindergartenService(IKindergartenService kindergartenService) {
		this.kindergartenService = kindergartenService;
	}
	
	/**
	 * 根据用户名查找用户
	 */
	@RequestMapping("/findByUsername")
	@ResponseBody
	public User findByUsername(String username){
		System.out.println("username = "+username);
		return this.userService.findByUsername(username);
	}

	/**
	 * 登录
	 * @param request
	 * @return
	 */
	@RequestMapping("/doLogin")
    public String doLogin(String username, String password, HttpSession session){
        System.out.println("登录用户:"+username);
        try {
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			Subject currentUser = SecurityUtils.getSubject();
			//该方法会直接进入userrealm的getauteninfo进行用户名密码验证
			currentUser.login(token);
			
			//根据username查询用户记录
			User user = this.userService.findByUsername(username);
			//将用户记录存放到session作用域中
			session.setAttribute("user", user);
			
			//获取用户绑定的角色
			Map role = this.userService.findRoleByUsername(username);
			System.out.println("UserController::doLogin-role = "+role.get("description"));
			//将用户的角色信息存放到session作用域中
			session.setAttribute("role", role);
			
			//若登录用户的角色为家长或教师，则返回登录页面
			if ("parent".equals(role.get("role")) || "teacher".equals(role.get("role"))) {
				return "redirect:/login.jsp?msg=noPermission";
			}
			
			//若用户为园长，则从幼儿园表中查询kindergartenId
			if ("principal".equals(role.get("role"))) {
				int userId = Integer.parseInt(user.getId()+"");
				//根据园长id查询幼儿园信息
				Kindergarten kindergarten = this.kindergartenService.findKindergarten(userId);
				//将幼儿园id存放到session作用域中
				session.setAttribute("kindergartenId", kindergarten.getId());
			}
		} catch (AuthenticationException e) {
			//登录失败
			//e.printStackTrace();
			return "redirect:/login.jsp?msg=loginFailed";
		}
        return "redirect:/user/main";
    }

	/**
	 * 退出登录
	 * @param request
	 * @return
	 */
	@RequestMapping("/doLogout")
	public String doLogout(HttpServletRequest request){
		HttpSession session = request.getSession();
		//让session失效
		session.invalidate();
		System.out.println("用户退出系统");
		return "redirect:/login.jsp";
	}

	/**
	 * 查询所有权限
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping("/main")
	public String main(HttpServletRequest request){
		//获取session
		HttpSession session = request.getSession();
		//从session作用域中获取username
		String username=(String) session.getAttribute("username");
		Set<Permission> permissions = userService.findPermissionsObject(username);
		//将查询出的用户的权限做成tree
		List<FunctionTree> treeList = new ArrayList<FunctionTree>();
		for (Permission permission : permissions) {
			FunctionTree tree = new FunctionTree();
			tree.setId(Integer.parseInt(permission.getId()+""));
			tree.setText(permission.getDescription());
			tree.setHref(permission.getUrl());
			tree.setSelectable(true);
			//若为一级功能，直接添加到treeList集合中
			//否则遍历treeList，将二级功能添加到对应的父功能中
			if (permission.getParentId() == 0) {
				treeList.add(tree);
			} else {
				for (FunctionTree ftree : treeList) {
					if (ftree.getId() == permission.getParentId()) {
						//判断nodes集合是否为空
						List<FunctionTree> nodes = null;
						if (ftree.getNodes() == null) {
							nodes = new ArrayList<FunctionTree>();
						} else {
							nodes = ftree.getNodes();
						}
						nodes.add(tree);
						ftree.setNodes(nodes);
						//System.out.println("子功能<"+tree.getText()+">添加到父功能<"+ftree.getText()+">中");
						break;
					}
				}
			}
		}
		JSONArray json = (JSONArray) JSON.toJSON(treeList);
//		System.out.println(json);
		request.setAttribute("permissions", json);
		System.out.println("查询用户<"+username+">的权限");
		return "index";
	}
	
	/**
     * 查询所有用户
     * @return
     */
	@RequestMapping("/listUsers")
    public String listUsers(Map map) {
		List<Map> users = this.userService.listUsers();
		map.put("users", users);
    	return "user_manage";
    }

	/**
	 * 保存用户
	 */
	@RequestMapping("/saveUser")
	public String saveUser(User user, String roleId){
		System.out.println("id = "+user.getId()+",username = "+user.getUsername()
				+",password = "+user.getPassword()+",locked = "+user.getLocked()
				+",roleId = "+roleId);
		//密码加密并生成盐
		PasswordHelper ph=new PasswordHelper();
	    ph.encryptPassword(user);
		Map map=new HashMap();
		map.put("username", user.getUsername());
		map.put("password", user.getPassword());
		map.put("salt", user.getSalt());
		map.put("locked", user.getLocked());
		this.userService.saveUser(user);
		//若选择了角色类型，则新增用户绑定角色
		if (!"".equals(roleId)) {
			System.out.println("新增用户绑定角色");
			User findUser = this.userService.findByUsername(user.getUsername());
			Map role = new HashMap();
			role.put("userId", findUser.getId());
			role.put("roleId", roleId);
			this.roleService.bindRole(role);
		}
		return "forward:/user/listUsers";
	}

	/**
	 * 修改用户
	 */
	@RequestMapping("/updateUser")
	public String updateUser(User user){
		System.out.println("id = "+user.getId()+",username = "+user.getUsername()
				+",password = "+user.getPassword()+",locked = "+user.getLocked());
		//this.userService.updateUser(user);
		return "forward:/user/listUsers"; 
	}
	
}
