<%@ page language="java" contentType="text/html; charset=gbk"%>
<%@ page import="com.recharge.crypt.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.Date,java.text.*"%>
<%@ include file="globalParam.jsp"%>
<html>
    <head>
        <title>������ֵ</title>
        <link href="sdk.css" rel="stylesheet" type="text/css" />
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    </head>

    <body>
        <%
            String itf_code = "flx_request";
            String sessionId = "";
            HashMap urlMap = new HashMap();

            //��������            
            try {
                //��ȡ���ύ�ĸ�����
                String mbl_no = request.getParameter("mbl_no");
                String flx_typ = request.getParameter("flx_typ");
                String flx_num = request.getParameter("flx_num");               
                String req_dt = request.getParameter("req_dt");
 
                //-- ǩ��ԭ����
                String signData = char_set + notify_url + merc_id+ req_id + req_dt
                        + sign_typ + itf_code + ver_no +mbl_no+flx_typ+flx_num;

                //ǩ���������ǩ�������ϢժҪ
                 out.println("signData="+signData);
                 out.println("signKey="+signKey);
                HiiposmUtil util = new HiiposmUtil();
                String hmac = util.MD5Sign(signData, signKey);
                out.println("hmac="+hmac);
                 
                //-- ������
                  String buf = "char_set=" + char_set + "&notify_url="
                    + notify_url + "&req_id=" + req_id + "&req_dt="
                    + req_dt + "&itf_code=" + itf_code + "&ver_no=" + ver_no
                    + "&merc_id=" + merc_id + "&signKey=" + signKey
                    + "&mbl_no=" + mbl_no + "&flx_typ=" + flx_typ+ "&flx_num=" + flx_num+"&sign_typ="+sign_typ;
                //-- ������ϢժҪ
                buf = "hmac=" + hmac + "&" + buf;
                 out.println("buf="+buf);
                   out.println("req_url="+req_url);

                   
                //����http���󣬲���ȡ��Ӧ����
                String res = null;
                try{
                	res = util.sendAndRecv(req_url, buf, char_set);
                }catch(Exception e){
                        out.println(e.getMessage());
                        e.printStackTrace();
                	out.println("\n����http���󱨴�");
                	return;
                }
                out.println("res="+res);
                //��ȡ��ֵƽ̨��Ӧ����ϢժҪ
                String hmac1 = util.getValue(res, "hmac");
                String vfsign = util.getValue(res, "merc_id")                     
                        + util.getValue(res, "msg_code")
                        + util.getValue(res, "msg_inf")
                        + util.getValue(res, "sys_dt");
                        
                String code = util.getValue(res, "msg_code");
                 out.println("code��" + code);
                String re_code=code.substring(3);
                out.println("re_code��" + re_code);
                
                //�жϷ������Ƿ���000000��
                if (!re_code.equals("00000")) {
                   out.println("================================");       
                   out.println("����ʧ��:"
                            + code
                            + URLDecoder.decode(util.getValue(res, "message"),"UTF-8"));
                   out.println("================================");
                    return;
                }

                // -- ��֤ǩ��
                boolean flag = false;
                out.println(vfsign + "  " + hmac1);
                flag = util.MD5Verify(vfsign, hmac1, signKey);

                if (!flag) {
                    //request.getSession().setAttribute("message", "��֤ǩ��ʧ�ܣ�");
                    out.println("��ǩʧ��");
                    return;
                }
                out.println("<br/>");
                out.println("================");
                out.println("<br/>");
                out.println("���׳ɹ�");
                out.println("<br/>");
                out.println("������:" + util.getValue(res, "returnCode"));
                out.println("<br/>");
                out.println("������������Ϣ:" + URLDecoder.decode(util.getValue(res, "message"),"UTF-8"));
                out.println("================");
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
