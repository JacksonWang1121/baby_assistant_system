package sdibt.group.resolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class MyExceptionResolver implements HandlerExceptionResolver {

	public ModelAndView resolveException(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", e.getMessage());
		mv.setViewName("error");
		System.out.println("MyExceptionResolver::msg = "+e.getMessage());
		return mv;
	}

}
