<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宝贝助手管理系统</title>
<jsp:include page="common.jsp"></jsp:include>
<link href="css/bootstrap-treeview.min.css" rel="stylesheet">
<script src="js/bootstrap-treeview.min.js" type="text/javascript"></script>
<style type="text/css">
* {
	padding:0px;
	margin:0px;
}
/* a {
	text-decoration: none;
}
a:hover {
	text-decoration:underline;
} */
#wrapper {
	/* width: 1348px; */
	margin: 0 auto;
}
#head{
	height: 100px;
	text-align: center;
	/* border:1px solid red; */
}
#middle {
	/* height:539px; */
}
#menu {
	float: left;
	width: 16%;
	/* height:538px; */
	overflow: scroll;
	overflow-x:hidden;
	/* border:1px solid red; */
}
#main {
	float: right;
	width: 84%;
	/* height:536px; */
	/* overflow: scroll; */
	background-image: url("images/background.jpg") no-repeat 100% 100%;
	/* border:1px solid red; */
}
/* 用户的登录信息 */
#dd {
	text-align: right;
	padding-right: 30px;
}
</style>
<script type="text/javascript">
$(function() {
	//浏览器当前窗口可视区域高度
	//console.log('浏览器当前窗口可视区域高度：'+$(window).height());
	//浏览器当前窗口文档的高度
	//console.log('浏览器当前窗口文档的高度：'+$(document).height());
	//浏览器当前窗口文档body的高度
	//console.log('浏览器当前窗口文档body的高度：'+$(document.body).height());
	//浏览器当前窗口文档body的总高度 包括border padding margin
	//console.log('浏览器当前窗口文档body的总高度 ：'+$(document.body).outerHeight(true));

	//浏览器当前窗口可视区域宽度
	//console.log('浏览器当前窗口可视区域宽度：'+$(window).width());
	//浏览器当前窗口文档的宽度
	//console.log('浏览器当前窗口文档的宽度：'+$(document).width());
	//浏览器当前窗口文档body的宽度
	//console.log('浏览器当前窗口文档body的宽度：'+$(document.body).width());
	//浏览器当前窗口文档body的总宽度 包括border padding margin
	//console.log('浏览器当前窗口文档body的总宽度 ：'+$(document.body).outerWidth(true));
	
	//var w = document.documentElement.clientWidth || document.body.clientWidth;
	var w = $(window).width();
	console.log("w = "+w);
	//var h = document.documentElement.clientHeight || document.body.clientHeight;
	var h = $(window).height();
	console.log("h = "+h);
	$("#wrapper").css("width",w+"px");
	$("#middle").css("height",(h-100)+"px");
	$("#menu").css("height",(h-101)+"px");
	$("#main").css("height",(h-102)+"px");
	
	//初始化日期
	var date = new Date();
	$("#timestamp").text(date.toLocaleString());
	//定义一个定时器
	window.setInterval(function() {
		var date = new Date();
		$("#timestamp").text(date.toLocaleString());
	},1000);

	/* 退出系统 */
	$("#exitSystem").click(function() {
		//确认是否退出
		if (confirm("确定退出系统？")) {
			//跳转到退出系统界面
			window.location.href = "${pageContext.request.contextPath }/user/doLogout";
		}
	});

	//从request作用域中获取登录用户的权限
	var permissions = '${requestScope.permissions }';
	//console.log("index.jsp::permissions = "+permissions);
	$('#tree').treeview({
		data: permissions,
		onNodeChecked: function (event,data) {
            console.log("onNodeChecked:"+data.text);
        },
        onNodeSelected: function (event, data) {
            console.log("onNodeSelected:"+data.text+"--"+data.href);
            //跳转页面
            var url = '<iframe style="width:100%;height:100%" frameborder="0" src="${pageContext.request.contextPath }/'
				+data.href+'" allowTransparency="true"></iframe>';
            $("#main").html(url);
        }
	});
});
</script>
</head>
<body>
<div id="wrapper">
	<!-- 头部 -->
	<div id="head">
		<h1>宝贝助手管理系统</h1>
		<div id="dd">
	    	<strong>${sessionScope.user.realName }</strong>
	    	，您好，当前身份为<strong>${sessionScope.role.description }</strong>
	    	，当前时间为<strong id="timestamp"></strong>
	    	<a id="exitSystem" href="javascript:" >退出系统</a>
    	</div>
	</div>
	<!-- 分割线 -->
	<hr width="100%" color="#808080" style="margin-top: -30px;margin-bottom: 0px;">
	<!-- 中间 -->
	<div id="middle">
		<!-- 菜单 -->
		<div id="menu">
			<div id="tree"></div>
		</div>
		<!-- 主体 -->
		<div id="main"></div>
	</div>
</div>
</body>
</html>