<%@ page language="java" import="java.util.*,java.text.*"
	pageEncoding="GBK"%>
<html>
	<head>
		<title>��Կ����</title>
		<link href="css/sdk.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>

	<body>
		<form name="form1" method="post" action="flx_key_update.jsp">
			<br>
			<center>

				<input type="hidden" name="merCert" value="">
				<font size=2 color=black face=Verdana><b>��Կ����</b> </font>
				<br>
				<br>
				<table class="api">
					<tr>
						<td class="field">
							�����Կ
						</td>
						<td>
							<input type="text" name="newsignKey" maxlength='64' value="">
							<font color="red">*�̻��Զ�����Կ��ֻ�������֡���Сд��ĸ��ɣ����Ȳ�����64λ���޸ĳɹ�������Կ��1��������Ч</font>
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
