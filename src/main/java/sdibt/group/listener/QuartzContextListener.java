package sdibt.group.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.quartz.Scheduler;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class QuartzContextListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		try {
			WebApplicationContext webApplicationContext = (WebApplicationContext) event
					.getServletContext()
					.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
			Scheduler startQuartz = (Scheduler) webApplicationContext
					.getBean("DefaultQuartzScheduler");

//			Scheduler startQuartz = (Scheduler) WebApplicationContextUtils
//					.getWebApplicationContext(event.getServletContext())
//					.getBean("DefaultQuartzScheduler");

			if(startQuartz.isStarted()){
				startQuartz.shutdown();
			}
			Thread.sleep(3000);//主线程睡眠3s
			event.getServletContext().log("QuartzContextListener销毁成功！");
			System.out.println("QuartzContextListener销毁成功！");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		System.out.println("QuartzContextListener启动成功！");
		event.getServletContext().log("QuartzContextListener启动成功！");
	}

}
