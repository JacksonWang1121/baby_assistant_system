<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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

		$("#username").blur(isExistTeacher);
		
		$("#teacherRegister1").click(function(){
			//将值作为参数传送到servlet ，已ajax方式传送到servlet
			//创建一个xhr，作为前台界面与后台servlet交互的关键对象
		var  username=$('#username').val();
		var  password=$('#password').val();
		var  classId=$('#classId').val();
		var  realName=$('#realName').val();

			 $.ajax({
				url:"/BabyAssistantSystem/user/teacherRegister",//发送请求地址
				type:"post",//发送请求的方法
				dataType:"text",//返回的数据类型
				data:{"username":username,"password":password,"classId":classId,"realName":realName},
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
		

		
		

		/* 添加学生记录中的年级下拉框 */
		$("#gradeId").bind('focus',function() {
	    	$.ajax({
				url:"${pageContext.request.contextPath }/class/listGrade",
				type:"post",
				dataType:"json",
				success:function(data, status) {
					console.log("success-data = "+data);
					//清空下拉框
					$("#gradeId").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
					for(var i in data) {
						//下拉框重新赋值
						$("#gradeId").append('<option value="'+data[i].gradeId+'">'+data[i].gradeName+'</option>');
					}
				},
				error:function(data, status, e) {
					console.log("error = "+e);
				}
			});
		});
		/* 添加学生记录中的班级下拉框 */
		$("#classId").bind('focus',function() {
			var gradeId=$('#gradeId').val();
	    	$.ajax({
				url:"${pageContext.request.contextPath }/class/listClassByGradeId",
				type:"post",
				dataType:"json",
				data:{"gradeId":gradeId},
				success:function(data, status) {
					console.log("success-data = "+data);
					//清空下拉框
					$("#classId").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
					for(var i in data) {
						//下拉框重新赋值
						$("#classId").append('<option value="'+data[i].class_id+'">'
							+data[i].class_name+'</option>');
					}
				},
				error:function(data, status, e) {
					console.log("error = "+e);
				}
			});
		});
		
		$("#classId").blur( 
				function() {
					//获取文本框的值
					var classId = $('#classId').val();
				
					 $.ajax({
							url:"${pageContext.request.contextPath }/class/isExistsTeacherByClassId",//发送请求地址
							type:"post",//发送请求的方法
							dataType:"text",//返回的数据类型
							data:{"classId":classId},
							success:function(data,status){//请求成功后回调函数
								if (data !="1") {
									$("#info1").html('已经存在老师'+data);				
								} else {
									$("#info1").html('未存在老师');
								}							
							},
							error:function(){//请求失败后回调函数
								alert('后台报错')
							} 
						});
				});	
		
		
		
		
	});
	function isExistTeacher() {
		//获取文本框的值
		var username = $(this).val();
		//将值作为参数传送到servlet ，已ajax方式传送到servlet
		//创建一个xhr，作为前台界面与后台servlet交互的关键对象
		$.ajax({
			url:"/BabyAssistantSystem/user/isExistsUsername",//发送请求地址
			type:"get",//发送请求的方法
			dataType:"text",//返回的数据类型
			data:{"username":username},//发送到服务器的数据自动转换为字符串格式
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
	}
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
				<td><span class="types">确认密码：</span></td>
				<td><input type="password" name="password" id="repassword"
					value=""></td>
			</tr>
			<tr>
			<th><label>年级</label></th>
		    <td>
			<select id="gradeId" name="gradeId">
				<option value="">--&nbsp;请选择&nbsp;--</option>
			</select>
		    </td>
		  <th><label>班级</label></th>
				<td>
					<select id="classId" name="classId">
						<option value="">--&nbsp;请选择&nbsp;--</option>
					</select>
					<span  id="info1"></span>
				</td>
		    </tr>
			<tr>
				<td><span class="types">真实名称：</span></td>
				<td><input type="text" name="realName" id="realName"></td>
			</tr>


		</table>
		<input id="teacherRegister1" type="button" value="老师注册">

	</div>
</body>
</html>