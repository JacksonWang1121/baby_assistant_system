package sdibt.group.converter;

import org.springframework.core.convert.converter.Converter;
/**
 * 
 * Title:StringToNullConverter
 * @author hanfangfang
 * date:2018年8月28日 上午11:15:25
 * package:org.sdibt.group.converter
 * version 1.0
 */
public class StringToNullConverter implements Converter<String, Object> {

	@Override
	public Object convert(String source) {
		if ("".equals(source))
			return null;
		else
			return source;
	}

}
