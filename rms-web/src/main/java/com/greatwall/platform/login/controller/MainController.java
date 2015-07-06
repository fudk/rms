package com.greatwall.platform.login.controller;


import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.greatwall.platform.domain.PageParameter;
import com.greatwall.platform.login.service.MainService;
import com.greatwall.platform.system.dto.User;
import com.greatwall.recharge.dto.Product;



/**
 * 首页
 * @author fudk_k@sina.com
 * @update 2014-7-6
 */
@Controller
@RequestMapping("/main")
public class MainController {
	
	private static Logger logger = Logger.getLogger(MainController.class);

	@Autowired
	private MainService mainService;
	
	@RequestMapping(method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView main(Product product,PageParameter page,ModelMap model,HttpSession httpSession) {
		User user = httpSession.getAttribute("user")!=null?(User)httpSession.getAttribute("user"):null;
//		if(httpSession.getAttribute("resTopList")==null){
			JSONArray toplist = JSONArray.fromObject( mainService.getResource(user,"top") ); 
			JSONArray leftlist = JSONArray.fromObject( mainService.getResource(user,"left") ); 
			httpSession.setAttribute("resTopList", toplist);
			httpSession.setAttribute("resList", leftlist);
//		}
		
		return new ModelAndView("main.jsp");
	}

}