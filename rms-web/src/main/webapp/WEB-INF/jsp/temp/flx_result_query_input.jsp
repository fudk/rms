<%@ page language="java" import="java.util.*,java.text.*"
	pageEncoding="GBK"%>
<html>
	<head>
		<title>������ѯ</title>
		<link href="css/sdk.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>

	<body>
		<form name="form1" method="post" action="flx_result_query.jsp">
			<br>
			<center>

				<input type="hidden" name="merCert" value="">
				<font size=2 color=black face=Verdana><b>������ѯ</b> </font>
				<br>
				<br>
				<table class="api">
					<tr>
						<td class="field">
							����ѯ��ֵ��¼�����
						</td>
						<td>
							<input type="text" name="inq_req_id" maxlength='20' value="">
							<font color="red">*��Ҫ��ѯ���̻���������ˮ��</font>
						</td>
					</tr>
					<tr>
						<td class="field">
							����ѯ��ֵ��¼��������
						</td>
						<td>
							<input type="text" name="inq_req_dt" maxlength='20' value="">
							<font color="red">*��Ҫ��ѯ���̻�����������</font>
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
