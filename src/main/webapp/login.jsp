<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<jsp:include page="common.jsp"></jsp:include>
<style type="text/css">
body {
	background-image: url("images/background.jpg");
}
#tab {
	width: 350px;
	margin: 0 auto;
}
.error{
	color:red;
}
</style>
<script type="text/javascript">
$(function() {
	/* 
		垂直居中显示
	*/
	var h = $(window).height();
	//var h = document.documentElement.clientHeight || document.body.clientHeight;
	console.log("h = "+h);
	var tabHeight = $("#tab").css("height").replace("px","");
	console.log("tabHeight = "+tabHeight);
	$("#tab").css("margin-top",(h-parseInt(tabHeight))/2+"px");

	//获取url中的msg参数值
	var msg = getUrl("msg");
	console.log("msg = "+msg);
	if (msg != null) {
		if (msg == "noPermission") {
			alert("该用户没有访问权限");
			$("#username").val("");
		} else if (msg == "loginFailed") {
			alert("账号或密码错误");
		}
	}

});

/*  */
function getUrl(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return null;
}
</script>
</head>
<body>
<div class="error">${error}</div>
<form action="${pageContext.request.contextPath }/user/doLogin" method="post">
<table class="table" id="tab">
	<tr>
		<th colspan="2" style="text-align:center;"><h2>宝贝助手管理系统</h2></th>
	</tr>
	<tr>
		<td align="right">用户名</td>
		<td><input type="text" name="username" id="username" value="<shiro:principal/>"></td>
	</tr>
	<tr>
		<td align="right">密&nbsp;&nbsp;码&nbsp;</td>
		<td><input type="password" name="password"></td>
	</tr>
	<!-- <tr>
		<td colspan="2" style="text-align:center;">
			<input type="checkbox" name="rememberMe" value="true">记住我
		</td>
	</tr> -->
	<tr>
		<td colspan="2" style="text-align:center;">
			<input type="submit" class="btn btn-danger" value="登录">
		</td>
	</tr>
</table>
</form>
</body>
</html>