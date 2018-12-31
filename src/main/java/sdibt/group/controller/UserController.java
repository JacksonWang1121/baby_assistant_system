package sdibt.group.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.server.ExportException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
import sdibt.group.vo.PageVO;
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
public class UserController extends HttpServlet{
	

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
	   /**
     * 是否存在用户
     * @return
     */
	 @RequestMapping("/isExistsUsername")
	  @ResponseBody
	  public String isExistsUsername(String username) {
		  //是否存在用户?
	  boolean result=this.userService.isExistUsername(username);
		  if(result){
			  return  "true";
		  }
		 return "false";
		  
	  }
	   /**
	     * 园长注册
	     * @return
	     */
	  @RequestMapping("/principalRegister")
	  @ResponseBody
	  public String principalRegister(User user,String kindergartenName){
		
		 
	
		  PasswordHelper passwordHelper=new PasswordHelper();
		  passwordHelper.encryptPassword(user);	 
		  
		  System.out.println(user.getUsername());
		  boolean  result=this.userService.principalRegister(user,kindergartenName);
		  return "1";
	  }
	  @RequestMapping("/teacherRegister")
	  @ResponseBody
	  public String teacherRegister(User user , int classId){
        boolean  result=this.userService.teacherRegister(user,classId);
		return "1";
	  }
	  @RequestMapping("/listTeacher")
	  public String listTeacher(HttpSession session,Map map,String curPage, String pageSize){
		  int kindergartenId = (int) session.getAttribute("kindergartenId");
		  int page,pageCount;
	      //若curPage小于或等于0，则默认设置为1
	      		if (curPage == null) {
	      			page = 1;
	      		}else{
	      			page = Integer.valueOf(curPage);
	      		}
	      		//若pageSize小于或等于0，则默认设置为50	    
	      			pageCount =3;      		      		
        PageVO  pv=this.userService.listTeacher(kindergartenId,page,pageCount);
        map.put("pv", pv);
		return "teacherManage";
	  }
	  
	  @RequestMapping("/listTeacher1")
	  @ResponseBody
	  public PageVO listTeacher1(HttpSession session,Map map,String curPage, String pageSize){
		  int kindergartenId = (int) session.getAttribute("kindergartenId");
		  int page,pageCount;
	      //若curPage小于或等于0，则默认设置为1
	      		if (curPage == null) {
	      			page = 1;
	      		}else{
	      			page = Integer.valueOf(curPage);
	      		}
	      		//若pageSize小于或等于0，则默认设置为50
	      			pageCount =3;	      
	      		
        PageVO  pv=this.userService.listTeacher(kindergartenId,page,pageCount);
        
		return pv;
	  }
	  
	  @RequestMapping("/updateTeacher")
	  @ResponseBody
	  public boolean updateTeacher(User user){
	
		System.out.println(user.getId());
		System.out.println(user.getAddress());
		System.out.println(user.getRealName());
		  boolean  result=this.userService.updateTeacher(user);
		  return result;
	  }
	  @RequestMapping("/listPrincipal")
	  public String listPrincipal(HttpSession session,Map map,String curPage){
		  int page,	pageSize =3;;
	      //若curPage小于或等于0，则默认设置为1
	      		if (curPage == null) {
	      			page = 1;
	      		}else{
	      			page = Integer.valueOf(curPage);
	      		}
	      		//若pageSize小于或等于0，则默认设置为50	      		
        PageVO  pv=this.userService.listPrincipal(page,pageSize);
        map.put("pv", pv);
		return "principalManage";
	  } 
	  @RequestMapping("/listPrincipal1")
	  @ResponseBody
	  public PageVO listPrincipal1(HttpSession session,Map map,String curPage){
		  int page,	pageSize =3;;
	      //若curPage小于或等于0，则默认设置为1
	      		if (curPage == null) {
	      			page = 1;
	      		}else{
	      			page = Integer.valueOf(curPage);
	      		}
	      		//若pageSize小于或等于0，则默认设置为50	      		
        PageVO  pv=this.userService.listPrincipal(page,pageSize);
		return pv;
	  } 
	  @RequestMapping("/updatePrincipal")
	  @ResponseBody
	  public boolean updatePrincipal(User user){
	
	
		  boolean  result=this.userService.updatePrincipal(user);
		  return result;
	  }
	  @RequestMapping("/countSex")
	  @ResponseBody
	  public List<Map> countSex(HttpSession session){
		  int kindergartenId = (int) session.getAttribute("kindergartenId");

		  List<Map>  count=this.userService.countSex(kindergartenId);
		  return count;
	  }
	  
	  @RequestMapping("/listAllPrincipal")
	  @ResponseBody
	  public String listAllPrincipal(HttpSession session,HttpServletResponse response){
		  int kindergartenId = (int) session.getAttribute("kindergartenId");
	      //若curPage小于或等于0，则默认设置为1
    	
    		//若pageSize小于或等于0，则默认设置为50	      		
		  List<Map>  count=this.userService.countSex(kindergartenId);
		  
		  return "teacherPrincipal";
	  }
	  
	
	  
	  @RequestMapping("/saveFile")
	  public String filesUpload(@RequestParam(value="file",required=false) MultipartFile[] files) { 
	
		     String path = "D:/a/";
		        //判断file数组不能为空并且长度大于0  
		        if(files!=null&&files.length>0){  
		            //循环获取file数组中得文件  
		            for(int i = 0;i<files.length;i++){  
		                MultipartFile file = files[i];  
		                System.out.println(file.getOriginalFilename());
		                //保存文件  
		         System.out.println(123);
		                
		                saveFile(file, path);  
		            }  
		        } 
	
		  return "redirect:/user/listTeacher";
		  
	  }
	  
	    private boolean saveFile(MultipartFile file, String path) {  
	        // 判断文件是否为空  
	        if (!file.isEmpty()) {  
	            try {  
	                File filepath = new File(path);
	                if (!filepath.exists()) 
	                    filepath.mkdirs();
	                // 文件保存路径  
	                String savePath = path + file.getOriginalFilename(); 
	                System.out.println(file.getOriginalFilename());
	                System.out.println(savePath);
	                // 转存文件  
	                file.transferTo(new File(savePath));  
	                return true;  
	            } catch (Exception e) {  
	                e.printStackTrace();  
	            }  
	        }  
	        return false;  
	    } 
	  
	  
}  
	  
	  
	  

	

	
	

