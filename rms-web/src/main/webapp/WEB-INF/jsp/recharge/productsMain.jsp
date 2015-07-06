<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/base.jsp"%>

<ul class="ulmain" totalCount="${page.totalCount }"
	pageSize="${page.pageSize }">
	<c:forEach items="${products}" var="product" varStatus="status">
		<li class="lileft"><a href="javascript:addConsume('${product.productId}')" > <img class="liimg"
				src="${basePath}con/getImg/${fn:replace(product.productImg,'.', '/')}" /> 
				<div style="display:block; ">名称：${product.productName}<br/>
				价格：<span style="color: red;font-size:16px;">${product.productPrice}元</span> 
				<%-- <span style="text-decoration:line-through">${product.productPrice}</span>/
				<span style="color: red;font-size:16px;">
				<c:if test="${product.productType == 'phone'}"><fmt:formatNumber value="${product.productPrice*sessionScope.user.discountPhone/100}" /></c:if>
				<c:if test="${product.productType == 'flow'}"><fmt:formatNumber value="${product.productPrice*sessionScope.user.discountFlow/100}" /></c:if>
				元</span> --%>
				</div>
				
				<input
				type="button" value="立即购买" /></a></li>
	</c:forEach>
</ul>
