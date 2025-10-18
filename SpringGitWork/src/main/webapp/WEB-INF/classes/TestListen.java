package com.spring.finall.listen;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;



public class TestListen implements ServletContextListener {

	
	public TestListen(){}
	
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
	ServletContext sct=	sce.getServletContext();
System.out.println("하하하하");
System.out.println("하하하하");
System.out.println("하하하하");
System.out.println("하하하하");
	try {
		sct.setAttribute("ses", "ping");
	}catch(Exception e) {
		
		System.out.println(e);
		
	}
	
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext sct=	sce.getServletContext();
		System.out.println("뭐를가져오려나.."+sct.getAttribute("ses"));
		sct.removeAttribute("sex");
		
	}

}
