<%@ page language="java" contentType="text/html; charset=gb2312"%>
<%@ page import="com.recharge.crypt.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.Date,java.text.*"%>
<%@ page import="java.util.HashMap"%>
<%@ include file="globalParam.jsp"%>
<html>
	<head>
		<title>��Կ����</title>
		<link href="sdk.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>

	<body>
		<%
			String itf_code = "flx_key_update";		
			request.setCharacterEncoding("GBK");
			try {
				String newsignKey = request.getParameter("newsignKey");
				String signKey1="";
				
				out.println("newsignKey��" + newsignKey);
				
				//����Կ3des���ܴ���
        HiThreeDes desc = new HiThreeDes();                            
        int sk_len=signKey.length();
        out.println("sk_len="+sk_len);  
        
        if(sk_len>=32){
          signKey1=signKey.substring(0,32);
        }else{
        	signKey1=signKey;
        	for(int i=0;i<32-sk_len;i++){
        	   signKey1=signKey1+"0";
          }
        }     
        newsignKey = desc.encryptMode(signKey1, newsignKey);
        out.println("signKey1="+signKey1);
        out.println("req_id="+req_id);
        out.println("newsignKey��У��="+newsignKey);
		    //newsignKey = URLEncoder.encode(newsignKey,"UTF-8");	
				//-- ǩ��			
				 String signData = char_set +  merc_id+ req_id + newsignKey + sign_typ + itf_code + ver_no;
	                out.println("signData="+signData);
				HiiposmUtil util = new HiiposmUtil();
				String hmac = util.MD5Sign(signData, signKey);
    
				//-- ������
				String buf = "char_set=" + char_set  + "&merc_id=" + merc_id + "&req_id="
		                    + req_id+"&signKey="+ newsignKey + "&sign_typ=" + sign_typ + "&itf_code=" + itf_code
		                    + "&ver_no=" + ver_no ;
				
				
				buf = "hmac=" + hmac + "&" + buf;
			  
				//����http���󣬲���ȡ��Ӧ����
				String res = util.sendAndRecv(req_url, buf, char_set);

				//��ȡ�ֻ�֧��ƽ̨���ص�ǩ����ϢժҪ��������ǩ
				String hmac1 = util.getValue(res, "hmac");
				String vfsign = util.getValue(res, "merc_id")
						+ util.getValue(res, "msg_code")
						+ util.getValue(res, "msg_inf");					
				out.println("vfsign:"+vfsign);					
				String code = util.getValue(res, "msg_code");
				out.println("code��" + code);
				String re_code=code.substring(3);
				out.println("re_code��" + re_code);
				
				if (!re_code.equals("00000")) {
					out.println("�����룺" + code);
					out.println("������Ϣ��"
							+ URLDecoder.decode(util.getValue(res, "message"),
									"UTF-8"));
					return;
				}

				// -- ��֤ǩ��
				boolean flag = false;
				flag = util.MD5Verify(vfsign, hmac1, signKey);

				if (!flag) {
					out.println("��ǩʧ��");
                    return;
				}

				out.println("================");
				out.println("<br/>");
				out.println("���׳ɹ�");
				out.println("<br/>");
				out.println("================");				
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>

	</body>
</html>
