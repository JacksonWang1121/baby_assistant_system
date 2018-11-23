package sdibt.group.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * md5加密算法
 * @author JacksonWang
 *
 */
public class MD5Util {
	
	 // 全局数组
    private final static String[] strDigits = { "0", "1", "2", "3", "4", "5",
            "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

    public MD5Util() {}

    // 返回形式为数字跟字符串
    private static String byteToArrayString(byte bByte) {
        int iRet = bByte;
        // System.out.println("iRet="+iRet);
        if (iRet < 0) {
            iRet += 256;
        }
        int iD1 = iRet / 16;
        int iD2 = iRet % 16;
        return strDigits[iD1] + strDigits[iD2];
    }

    // 返回形式只为数字
    private static String byteToNum(byte bByte) {
        int iRet = bByte;
        System.out.println("iRet1=" + iRet);
        if (iRet < 0) {
            iRet += 256;
        }
        return String.valueOf(iRet);
    }

    // 转换字节数组为16进制字串
    private static String byteToString(byte[] bByte) {
        StringBuffer sBuffer = new StringBuffer();
        for (int i = 0; i < bByte.length; i++) {
     sBuffer.append(byteToArrayString(bByte[i]));
        
        }
        return sBuffer.toString();
    }
     /**
      * 根据明文运用加密算法返回密文
      * @param strObj
      * @return
      */
	 public static String GetMD5Code(String strObj) {
	        String resultString = null;
	        try {
	            resultString = new String(strObj);//加载明文
	            MessageDigest md = MessageDigest.getInstance("MD5");//jdk提供的获取各种算法的类的对象md
	            // md.digest() 该函数返回值为存放哈希值结果的byte数组
	            resultString = byteToString(md.digest(strObj.getBytes()));//将md5返回的byte数组的每一个byte变为字符串，拼接起来
	        } catch (NoSuchAlgorithmException ex) {
	            ex.printStackTrace();
	        }
	        return resultString;
	    }
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(MD5Util.GetMD5Code("zhangok"));
//		System.out.println(Integer.toOctalString(new Integer(0xff)));
	}

}
