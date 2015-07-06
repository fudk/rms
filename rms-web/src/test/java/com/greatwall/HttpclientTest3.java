package com.greatwall;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class HttpclientTest3 {

	public static void main(String[] args) {
		//创建HttpClientBuilder  
		HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();  
		//HttpClient  
		CloseableHttpClient closeableHttpClient = httpClientBuilder.build();  

//		HttpPost httpPost = new HttpPost("http://115.29.43.62:8080/rechargeapi/recharge");  
		HttpPost httpPost = new HttpPost("http://localhost/rechargeapi/recharge");  
		//httpPost.setConfig();  
		
//		RequestConfig requestConfig = RequestConfig.custom()  
//			    .setConnectionRequestTimeout(50).setConnectTimeout(50)  
//			    .setSocketTimeout(50).build(); 
//		httpPost.setConfig(requestConfig);  
		// 创建参数队列  
		List<NameValuePair> formparams = new ArrayList<NameValuePair>();  
		formparams.add(new BasicNameValuePair("platId", "TEST1"));  
		formparams.add(new BasicNameValuePair("timestamp", new Date().getTime()+""));  
		formparams.add(new BasicNameValuePair("orderId", UUID.randomUUID().toString()));  
		formparams.add(new BasicNameValuePair("opType", "phone"));  
		formparams.add(new BasicNameValuePair("custPhone", "15067127829"));  
		formparams.add(new BasicNameValuePair("opPrice", "50"));  
		formparams.add(new BasicNameValuePair("opNum", "1"));  
		formparams.add(new BasicNameValuePair("notifyUrl", "http://qweer"));  
		/*formparams.add(new BasicNameValuePair("platId", "TEST1"));  
		formparams.add(new BasicNameValuePair("timestamp", new Date().getTime()+""));  
		formparams.add(new BasicNameValuePair("orderId", UUID.randomUUID().toString()));  
		formparams.add(new BasicNameValuePair("opType", "flow"));  
		formparams.add(new BasicNameValuePair("custPhone", "15067127829"));  
		formparams.add(new BasicNameValuePair("opPrice", "30M"));  
		formparams.add(new BasicNameValuePair("opNum", "1"));  
		formparams.add(new BasicNameValuePair("notifyUrl", ""));  */

		StringBuffer sb = new StringBuffer();
		for(NameValuePair nameValuePair:formparams){
			sb.append(nameValuePair.getName());
			sb.append("=");
			sb.append(nameValuePair.getValue());
			sb.append("&");
		}
		sb.append("C6914624EB90000116D71D90141B3FC0");
		formparams.add(new BasicNameValuePair("sign", DigestUtils.md5Hex(sb.toString())));  
		
		
		
		UrlEncodedFormEntity entity;  
		try {  
			entity = new UrlEncodedFormEntity(formparams, "UTF-8");  
			httpPost.setEntity(entity);  

			HttpResponse httpResponse;  
			//post请求  
			httpResponse = closeableHttpClient.execute(httpPost);  

			//getEntity()  
			HttpEntity httpEntity = httpResponse.getEntity();  
			if (httpEntity != null) {  
				//打印响应内容  
				System.out.println("response:" + EntityUtils.toString(httpEntity, "UTF-8"));  
			}  
			//释放资源  
			closeableHttpClient.close();  
		} catch (Exception e) {  
			e.printStackTrace();  
		}  
	}

}
