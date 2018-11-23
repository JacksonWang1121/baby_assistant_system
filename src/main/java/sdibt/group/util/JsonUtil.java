package sdibt.group.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

/**
 * 处理request中的json数据
 * @title JsonUtil.java
 * @author JacksonWang
 * @date 2018年11月9日 上午9:52:32
 * @package sdibt.group.util
 * @version 1.0
 *
 */
public class JsonUtil {

	public static byte[] getRequestPostBytes(HttpServletRequest request) throws IOException {
		int contentLength = request.getContentLength();
		if (contentLength < 0) {
			return null;
		}
		byte buffer[] = new byte[contentLength];
		for (int i = 0; i < contentLength;) {
			int readlen = request.getInputStream().read(buffer, i, contentLength - i);
			if (readlen == -1) {
				break;
			}
			i += readlen;
		}
		return buffer;
	}

	public static String getRequestPostStr(HttpServletRequest request) throws IOException {
		byte buffer[] = getRequestPostBytes(request);
		String charEncoding = request.getCharacterEncoding();
		if (charEncoding == null) {
			charEncoding = "UTF-8";
		}
		return new String(buffer, charEncoding);
	}

	public static String getRequestJsonString(HttpServletRequest request) throws IOException {
		String submitMehtod = request.getMethod();
		// GET
		if (submitMehtod.equals("GET")) {
			return new String(request.getQueryString().getBytes("utf-8"), "utf-8").replaceAll("%22", "\"");
		} else {// POST
			return getRequestPostStr(request);
		}
	}

}
