<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>退出系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- <meta http-equiv="refresh" content="5;url=login.jsp"> -->
<style type="text/css">
.wrapper {
  font-size: 20px;
  padding-top:50px;
  text-align: left;
}
#jump {
	color: blue;
	font-size: 30px;
}
</style>
</head>
<%
	session.invalidate();
%>
<body>
<div class="wrapper">
	<span id="jump">5</span> 秒钟后页面将自动返回登录页面...
</div>
</body>
<script type="text/javascript">
function countDown(secs){
	jump.innerText=secs;
	if(--secs>0) {
		setTimeout("countDown("+secs+" )",1000);
	}
	if(secs == 0) {
		 window.open("login.jsp","_top");
	}
}
countDown(5);
</script>
</html>
