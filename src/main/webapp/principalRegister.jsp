<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src=""></script>
<style type="text/css">
.types {
	width: 20%;
	height: 70px;
	font-size: 40px;
	font-weight: 700;
}

.username {
	width: 50%;
	height: 70px;
	font-size: 40px;
	font-weight: 700;
}


</style>
<script type="text/javascript">
	$(function() {

		$("#username").blur( 
				function() {
					//获取文本框的值
					var username = $(this).val();
					
					 $.ajax({
							url:"/BabyAssistantSystem/user/isExistsUsername",//发送请求地址
							type:"post",//发送请求的方法
							dataType:"text",//返回的数据类型
							data:{"username":username},
							success:function(data){//请求成功后回调函数
								if (data == 'true') {
									$("#info").html('手机号已被注册');				
								} else {
									$("#info").html('手机号未被注册');
								}							
							},
							error:function(){//请求失败后回调函数
								alert('后台报错')
							} 
						});
				});	
		
		
		
		
		$("#principleSave").click(function(){
			//将值作为参数传送到servlet ，已ajax方式传送到servlet
			//创建一个xhr，作为前台界面与后台servlet交互的关键对象
			var  username=$('#username').val();
			var  password=$('#password').val();
			var  kindergartenName=$('#kindergartenName').val();
			var  realName=$('#realName').val();
			 $.ajax({
				url:"/BabyAssistantSystem/user/principalRegister",//发送请求地址
				type:"post",//发送请求的方法
				dataType:"text",//返回的数据类型
				data:{"username":username,"password":password,"realName":realName,"kindergartenName":kindergartenName},
				success:function(data){//请求成功后回调函数
					if (data == '1') {
						alert('添加成功');
					} else {
						alert('添加失败');
					}							
				},
				error:function(){//请求失败后回调函数
					alert('后台报错')
				}
			});
				
				
			});
		
		
	});
</script>
</head>
<body>
	<div>

		<table class="table">
			<tr>
				<td><span class="types">手机号:</span></td>
				<td><input type="text" name="username" id="username"></td>
				<td><span id="info"></span></td>
			</tr>
			<tr>
				<td><span class="types">密码：</span></td>
				<td><input type="password" name="password" id="password"
					value=""></td>

			</tr>
			<tr>
				<td><span class="types">幼儿园名称：</span></td>
				<td><input type="text" name="kindergartenName" id="kindergartenName"></td>

			</tr>
			<tr>
				<td><span class="types">真实名称：</span></td>
				<td><input type="text" name="realName" id="realName"></td>

			</tr>


		</table>

		<input id="principleSave" type="button" value="园长注册">

	</div>
</body>
</html>
