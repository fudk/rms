<%@ page language="java" import="java.net.*,java.util.*,java.text.*" pageEncoding="gbk"%>
<%@ include file="globalParam.jsp" %>

<html>
    <head>
        <title>�������̻�������ʾ</title>
        <link href="css/sdk.css" rel="stylesheet" type="text/css" />
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    </head>

    <body>
        <center>           
            <table>
                <tr>
                    <th>
                        <p>
                            <h4>
                               ������ֵ������ʾDemo
                            </h4>
                        </p>
                        <hr>
                    </th>
                </tr>
                        
                <tr>
					<td align="center">
					<form action="index.jsp">
							�̻���:
							<input name="merchantId" value="<%=merc_id%>" />
							<!--input name="merchantId"/-->
							<br/>
							�̻���Կ:
							<input name="signKey" value="<%=signKey%>" size="64"/>
							<br/>
							<input type="submit" value="�����̻���" />
					</form>
					</td>
				</tr>
				
				
                <tr>
                    <td>
                        <a href="flx_request_input.jsp">������ֵ����</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="flx_result_query_input.jsp">������ֵ�����ѯ</a>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <a href="flx_key_update_input.jsp">��Կ����</a>
                    </td>
                </tr>
            </table>
        </center>
    </body>
</html>
