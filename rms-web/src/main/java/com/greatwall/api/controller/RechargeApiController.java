package com.greatwall.api.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.greatwall.api.domain.RechargeCondition;
import com.greatwall.platform.system.dto.User;
import com.greatwall.platform.system.service.UserService;
import com.greatwall.recharge.client.ShunpanService;
import com.greatwall.recharge.dto.Consume;
import com.greatwall.recharge.dto.Product;
import com.greatwall.recharge.service.ProductService;
import com.greatwall.recharge.service.RechargeConsumeService;
import com.greatwall.util.MathUtil;
import com.greatwall.util.NetworkUtil;
import com.greatwall.util.PhoneUtil;
import com.greatwall.util.StringUtil;

@Controller
@RequestMapping("/rechargeapi")
public class RechargeApiController {

	Logger logger = Logger.getLogger(RechargeApiController.class);
			
	@Autowired
	private ShunpanService shunpanService;
	@Autowired
	private RechargeConsumeService rechargeConsumeService;
	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	@Autowired
	private PhoneUtil phoneUtil;
	
	@RequestMapping("/callbacknotify")
	public@ResponseBody Map<String,String> callbackNotify(String streameid,
			String thirdstreamid,String opstatus,String sign){
		
		StringBuffer sb = new StringBuffer();
		sb.append("streameid=");
		sb.append(streameid);
		sb.append("&thirdstreamid=");
		sb.append(thirdstreamid);
		sb.append("&opstatus=");
		sb.append(opstatus);
		sb.append("&");
		sb.append(shunpanService.getKey());
		
		Map<String,String> remap = new HashMap<String,String>();
		if(DigestUtils.md5Hex(sb.toString()).equals(sign)){
			rechargeConsumeService.confirmConsume(thirdstreamid, opstatus);
			remap.put("retcode", "10000000");
			remap.put("retmsg", "交易成功");
		}else{
			remap.put("retcode", "10000001");
			remap.put("retmsg", "交易失败");
		}
		
		return remap;
	}
	
	@RequestMapping(value = "/recharge",method = { RequestMethod.GET, RequestMethod.POST })
	public@ResponseBody Map<String,String> recharge(RechargeCondition rechargeCondition,HttpServletRequest request){
		
		Map<String,String> remap = new HashMap<String,String>();
		if(rechargeCondition==null){
			remap.put("resCode", "02");
			remap.put("resMsg", "校验失败");
			return remap;
		}
		User u = null;
		if(rechargeCondition.getPlatId()!=null){
			u = userService.getUser(rechargeCondition.getPlatId());
		}else{
			remap.put("resCode", "06");
			remap.put("resMsg", "platId不能为空");
			return remap;
		}
		
		if(u == null || StringUtils.isBlank(u.getLoginName())){
			remap.put("rescode", "04");
			remap.put("resMsg", "用户不存在");
			return remap;
		}
		
		String ip = NetworkUtil.getIpAddress(request);
		if(!"127.0.0.1".equals(u.getPermitIp())){
			if(StringUtils.isBlank(ip)||!ip.equals(u.getPermitIp())){
				remap.put("resCode", "03");
				remap.put("resMsg", "IP地址未授权");
				return remap;
			}
		}
		
		if(!StringUtil.authRechargeCondition(rechargeCondition, u.getSessionKey())){
			remap.put("resCode", "02");
			remap.put("resMsg", "校验失败");
			return remap;
		}
		String[] phones = StringUtil.getRepStrings(rechargeCondition.getCustPhone());
		
		Product product = new Product();
		if("phone".equals(rechargeCondition.getOpType())){
			product.setProductPrice(new Double(rechargeCondition.getOpPrice()));
		}else{
			product.setProductValue(rechargeCondition.getOpPrice());
		}
		
		product.setIsp(phoneUtil.isPhoneNum(phones[0]));
		product.setProductType(rechargeCondition.getOpType());
		product = productService.getProduct(product);
		
		Consume consume = new Consume();
		
		consume.setProductId(product.getProductId());
		consume.setProductName(product.getProductName());
		consume.setProductValue(product.getProductValue());
		consume.setConsumePrice(product.getProductPrice());
		consume.setConsumeNum(rechargeCondition.getOpNum());//默认消费数量为1个
		consume.setConsumeAmount(MathUtil.mul(product.getProductPrice(), new Double(1), 2));
		consume.setConsumeType(product.getProductType());
		consume.setIsp(product.getIsp());
		consume.setState("processing");//处理中
		consume.setUserId(u.getUserId());
		
		List<String> errorMsgs = new ArrayList<String>();
		//获取相应产品信息
		
		for(String phone : phones){
			try {
				//如果电话号码与产品运营商不匹配
				if(!consume.getIsp().toUpperCase().equals(phoneUtil.isPhoneNum(phone))){
					throw new ClassCastException("手机号码与运营商不匹配");
				}
				consume.setConsumePhone(phone);
				
				rechargeConsumeService.addConsume(consume);
					
			}catch (ClassCastException e) {
				logger.error(phone+" "+e.getMessage());
				errorMsgs.add(phone+" "+e.getMessage());
			}catch (Exception e) {
				logger.error(phone+" 消费错误 ",e);
				errorMsgs.add(phone+" "+e.getMessage());
			}
		}

		if(errorMsgs!=null&&errorMsgs.size()>0){
			Gson gson = new Gson();
			remap.put("resCode", "05");
			remap.put("resMsg", gson.toJson(errorMsgs) );
			remap.put("msg", phones.length-errorMsgs.size()+"保存成功，"+errorMsgs.size()+"保存失败。");
		}else{
			remap.put("resCode", "01");
			remap.put("resMsg", "充值成功");
		}
		
		return remap;
	}
}
