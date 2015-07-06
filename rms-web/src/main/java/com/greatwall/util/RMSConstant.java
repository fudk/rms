package com.greatwall.util;

public class RMSConstant {

	 /** 
	* @Fields ISP_CM : 中国移动 
	*/ 
	public static final String ISP_CM = "CM";  
	 /** 
	* @Fields ISP_CU : 中国联通 
	*/ 
	public static final String ISP_CU = "CU";  
	 /** 
	* @Fields ISP_CT : 中国电信 
	*/ 
	public static final String ISP_CT = "CT";  
	
	
	/** 
	* @Fields PRODUCT_TYPE_PHONE : 话费类型 
	*/ 
	public static final String PRODUCT_TYPE_PHONE = "phone";
	
	/** 
	* @Fields PRODUCT_TYPE_FLOW : 流量类型 
	*/ 
	public static final String PRODUCT_TYPE_FLOW = "flow";
	
	
	
	/** 
	* @Fields DEFAULT_DISCOUNT : 默认折扣比例 
	*/ 
	public static final Integer DEFAULT_DISCOUNT = 100;
	
	
	/** 
	* @Fields ADMIN_ROLE : 管理员roleId 
	*/ 
	public static final String ADMIN_ROLE = "1,";
	
	/** 
	* @Fields AGENT_ROLE : 代理商roleId 
	*/ 
	public static final String AGENT_ROLE = "2,";
	
	/** 
	* @Fields DEFAULT_ROLE : 普通用户roleId（默认用户） 
	*/ 
	public static final String DEFAULT_ROLE = "3,";
	
	/** 
	* @Fields CONSUME_STATE_PROCESSING : 等待调用接口 
	*/ 
	public static final String CONSUME_STATE_PROCESSING = "processing";
	
	/** 
	 * @Fields CONSUME_STATE_SENDED : 接口已调用 
	 */ 
	public static final String CONSUME_STATE_SENDED = "sended";
	/** 
	 * @Fields CONSUME_STATE_FAIL : 接口调用失败 
	 */ 
	public static final String CONSUME_STATE_FAIL = "fail";
	/** 
	 * @Fields CONSUME_STATE_SUC : 接口调用成功 
	 */ 
	public static final String CONSUME_STATE_SUC = "success";
	
	
	
	
	/** 
	* @Fields ERROR_CODE_101 : 乐观锁版本错误 
	*/ 
	public static final String ERROR_CODE_101 = "101";
	
	/** 
	* @Fields ERROR_CODE_102 : 剩余金额小于0 
	*/ 
	public static final String ERROR_CODE_102 = "102";
	
	
	/** 
	* @Fields ERROR_CODE_103 : 数据库插入、更新、删除数量为空 
	*/ 
	public static final String ERROR_CODE_103 = "103";
	/** 
	 * @Fields ERROR_CODE_104 : 接口返回失败
	 */ 
	public static final String ERROR_CODE_104 = "104";
}
