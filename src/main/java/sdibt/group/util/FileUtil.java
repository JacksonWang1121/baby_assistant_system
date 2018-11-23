package sdibt.group.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.sun.jmx.snmp.Timestamp;

/**
 * 上传文件工具类
 * @title UploadFile.java
 * @author JacksonWang
 * @date 2018年9月20日 上午10:00:14
 * @package sdibt.group.util
 * @version 1.0
 *
 */
public class FileUtil {

	//BabyAssistantFile项目中文件的路径
	public static String httpFilePath = "http://localhost:8080/babyassistantfile/";
	//BabyAssistantFile项目的绝对路径
	private static String babyAssistantFilePath;

	//获取BabyAssistantFile项目的绝对路径
	public static String getBabyAssistantFilePath(HttpServletRequest request) {
		//获取session
		HttpSession session = request.getSession();
		//获取本项目在tomcat中的部署路径
		String babyAssistantSystemPath = session.getServletContext().getRealPath("/");
		//获取tomcat服务器中webapps的路径
		String webapps = new File(babyAssistantSystemPath).getParentFile().getAbsolutePath();
		return webapps + "/babyassistantfile/";
	}

	/**
	 * 上传文件
	 * @param request-请求服务
	 * @param mfile-上传的文件
	 * @param dir-要保存的目录
	 */
	public static String uploadFile(HttpServletRequest request, MultipartFile mfile, String dir) {
		System.out.println("----------------------------uploadFile("+mfile.getOriginalFilename()+")----------------------------");
		//获取BabyAssistantFile项目路径
		babyAssistantFilePath = getBabyAssistantFilePath(request);
//		System.out.println("FileUtil::uploadFile-babyAssistantFilePath=" + babyAssistantFilePath);
		
		//获取文件名
		String fileName = mfile.getOriginalFilename();
//		System.out.println("FileUtil::uploadFile-fileName(old) = "+fileName);
		
		//判断是否存在重名文件，直接获取新的文件名
		fileName = includeFile(fileName, dir);
		System.out.println("FileUtil::uploadFile-fileName(new) = "+fileName);
		
		//保存文件
		//transferToFile(mfile, dir+"\\"+fileName);
		try {
			mfile.transferTo(new File(babyAssistantFilePath+dir+"\\"+fileName));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return fileName;
	}

	/**
	 * 删除文件
	 * @param request-请求服务
	 * @param fileName-要删除文件的名称
	 * @param dir-要删除文件所在的目录
	 */
	public static void deleteFile(String fileName, String dir) {
		File file = new File(babyAssistantFilePath+dir+"\\"+fileName);
		file.delete();
		System.out.println("FileUtil::deleteFile: file("+fileName+") is deleted successfully");
	}
	
	/**
	 * 将MultipartFile类型的文件转换为File类型的文件
	 * @param mfile-要转换的文件
	 * @param filePath-要保存的文件路径
	 */
	public static void transferToFile(MultipartFile mfile, String filePath) {
		if("".equals(mfile) || mfile.getSize()<=0){
			System.err.println("FileUtil::transferToFile:MultipartFile is NULL");
		}else{
			InputStream in = null;
			try {
				in = mfile.getInputStream();
				File file = new File(babyAssistantFilePath+filePath);
				outputFile(in, file);
				//删除临时文件
				//File del = new File(file.toURI());
		   		//del.delete();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (in != null) {
						in.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 将文件保存到服务器的指定路径下
	 * @param in
	 * @param directory
	 */
	public static void outputFile(InputStream in, File file) {
		OutputStream out = null;
		try {
			out = new FileOutputStream(file);
			//创建一个字节数组存储读出来的数据
			byte[] b = new byte[1024];//一般情况下该数组1k，1024
			int len = 0;//表示每一次读了多少个
			//开始读取数据,循环读取文件，直到读到文件的末尾结束循环
			while((len = in.read(b)) != -1)	{
				out.write(new String(b, 0, len).getBytes());//这一次循环读取的内容
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 查询文件项目中是否存在该文件
	 * 若存在，则在该文件名的后面加上时间戳
	 * @param fileName-要查询文件的名称
	 * @param directory-要查询的文件夹
	 */
	public static String includeFile(String fileName, String directory) {
		File dir = new File(babyAssistantFilePath+directory);
		//若dir是一个文件而不是文件夹，则提示错误
		if (dir.isFile()) {
			System.err.println("FileUtil::includeFile:Open directory Failed...");
		}
		//获取dir文件夹下的所有文件以及子文件夹
		File[] files = dir.listFiles();
		//遍历file
		for (File f : files) {
			//若是文件，则判断是否重名,否则进入子文件夹查询
			if(f.isFile()){
				//若为文件，则判断要上传的文件是否有重名的文件
				if (f.getName().equals(fileName)) {
					//获取文件名
					String fname = fileName.substring(0,fileName.lastIndexOf("."));
					System.out.println("FileUtil::includeFile-fname = "+fname);
					//获取文件后缀名
					String suffix = fileName.substring(fileName.lastIndexOf("."));
					System.out.println("FileUtil::includeFile-suffix = "+suffix);
					//将文件名后面加上一个时间戳
					Timestamp timestamp = new Timestamp();
					fileName = fname+timestamp.getDateTime()+suffix;
					break;
				}
			} else {
				/*
				 * 此处只需要查询directory文件夹下是否有重名文件即可，不用管它的子文件夹
				 */
				//includeFile(fileName, directory+"\\"+f.getName());
			}
		}
		return fileName;
	}
	
	/**
	 * 查询文件项目中是否存在该文件
	 * @param fileName-要查询文件的名称
	 * @param directory-要查询的文件夹
	 * @return
	 */
	public static boolean existFile(String fileName, String directory) {
		//标记要查询的文件是否存在，默认为不存在
		boolean isExist = false;
		File dir = new File(babyAssistantFilePath+directory);
		//若dir是一个文件而不是文件夹，则提示错误
		if (dir.isFile()) {
			System.err.println("FileUtil::includeFile:Open directory Failed...");
		}
		//获取dir文件夹下的所有文件以及子文件夹
		File[] files = dir.listFiles();
		//遍历file
		for (File f : files) {
			//若是文件，则判断是否重名,否则进入子文件夹查询
			if(f.isFile()){
				//若为文件，则判断要上传的文件是否有重名的文件
				if (f.getName().equals(fileName)) {
					isExist = true;
					break;
				}
			} else {
				/*
				 * 此处只需要查询directory文件夹下是否有重名文件即可，不用管它的子文件夹
				 */
				//includeFile(fileName, directory+"\\"+f.getName());
			}
		}
		return isExist;
	}

	/**
	 * 根据系统变量获取服务器上tomcat的安装目录
	 * @return
	 */
	public static String getTomcatPath() {
		//tomcat安装目录
		String tomcatPath = null;
		//获取系统变量map
		Map<String, String> env = System.getenv();
		//获取map中的key值
		Set<String> keySet = env.keySet();
		//迭代器
		Iterator<String> iter = keySet.iterator();
		while(iter.hasNext()) {
			String key = iter.next();
			if ("TOMCAT_HOME".equals(key.toUpperCase())) {
				tomcatPath = env.get(key);
			}
		}
		System.out.println("FileUtil-tomcatPath = "+tomcatPath);
		return tomcatPath;
	}

}
