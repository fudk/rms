<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="GBK"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	String orderId = sdf.format(new Date());
	String orderDate = orderId.substring(0, 8);
%>

<html>
	<head>
		<title>������ֵ</title>
		<link href="css/sdk.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>

	<body>
		<form name="form1" method="post" action="flx_request.jsp">
			<br>
			<center>
				<font size=2 color=black face=Verdana><b>����������</b></font>
				<br>
				<br>
				<table class="api">
				   <tr>
						<td class="field">
							����ֵ�ֻ���
						</td>
						<td>
							<input type="text" name="mbl_no" maxlength='20' value="13874878832">
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="field">
							����������
						</td>
						<td>
							<select name="flx_typ">
								<option value="M">
									M-�°�
								</option>
								<option value="Q">
									Q-����
								</option>
								<option value="H">
									H-�����
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="field">
						  ������ֵ
						</td>
						<td>
							<input type="text" name="flx_num" maxlength='20' value="30M">
							<font color="red">*</font>
						</td>
					</tr>
					
					<tr>
						<td class="field">
							�̻���������
						</td>
						<td>
							<input type="text" name="req_dt" maxlength='200' value="20430724">
							<font color="red">*YYYYMMDD</font>
						</td>
					</tr>
					<tr>
						<td class="field">
						</td>
						<td>
							<input type="Submit" value="�ύ" id="Submit" name="submit" />
						</td>
					</tr>
					
				</table>
			</center>
			<a id="HomeLink" class="home" href="index.jsp">��ҳ</a>
		</form>
	</body>
</html>
