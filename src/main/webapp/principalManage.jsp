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
		$("#username1").blur( 
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
									$("#info1").html('手机号已被注册');				
								} else {
									$("#info1").html('手机号未被注册');
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
						window.location.href="/BabyAssistantSystem/user/listPrincipal";
						
					} else {
						alert('添加失败');
					}							
				},
				error:function(){//请求失败后回调函数
					alert('后台报错')
				}
			});
         });
		
		$("#prevPage").click(function(){
			var pageSize=Number($('#pageSize').val());
			var curPage1=Number($('#curPage').val());
			var pages=Number($('#pages').val());	
			var curPage=curPage1>1?curPage1-1:curPage1;
			$.ajax({
				url:"${pageContext.request.contextPath }/user/listPrincipal1",
				type:"post",
				dataType:"json",
				data:{"curPage":curPage,"pageSize":pageSize},
				success:function(data) {
					var tb = document.getElementById('principalTable');
	    	    var rowNum=tb.rows.length;
	    		    for (i=1;i<rowNum;i++) 
	    		    {
	    		        tb.deleteRow(i);
	    		        rowNum=rowNum-1;
	    		        i=i-1;
	    		    } 
	    		    for (var  i=0;i<data.data.length;i++) {
	    		    	
	    		      $("#principalTable").append("<tr><td>"
	    				+data.data[i].user_id+"</td><td>"
	    				  +data.data[i].real_name+"</td><td>"
	    					+data.data[i].username+"</td><td>"
	    					+data.data[i].name+"</td><td>"
	    					+data.data[i].address+"</td><td><a href=javascript: class=bianji data-toggle=modal data-target=#myModal>"
	    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
	    					+"退休"+"</a></td></tr>");
				}
	    	
	    		    $("#curPage").val(data.curPage);
	    		    $("#pageSize").val(data.pageSize);
	    			$('.bianji').click(function(){
	    				var userId= $(this).parent("td").prev().prev().prev().prev().prev().html();
	    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
	    				var username = $(this).parent("td").prev().prev().prev().html();
	    				var name = $(this).parent("td").prev().prev().html();
	    				var address = $(this).parent("td").prev().html();
	    				$("#userId1").val(userId);
	    				$("#realName1").val(realName);
	    				$("#username1").val(username);
	    				$("#name1").val(name);
	    				$("#address1").val(address);
	    			});
	    		
				},
				error:function() {
					alert('后台报错')	
				}	
			});	
			});		
		$("#nextPage").click(function(){
			var pageSize=Number($('#pageSize').val());
			var curPage1=Number($('#curPage').val());
			var pages=Number($('#pages').val());	
			var curPage=curPage1<pages?curPage1+1:curPage1;
			$.ajax({
				url:"${pageContext.request.contextPath }/user/listPrincipal1",
				type:"post",
				dataType:"json",
				data:{"curPage":curPage,"pageSize":pageSize},
				success:function(data) {
					var tb = document.getElementById('principalTable');
	    	    var rowNum=tb.rows.length;
	    		    for (i=1;i<rowNum;i++) 
	    		    {
	    		        tb.deleteRow(i);
	    		        rowNum=rowNum-1;
	    		        i=i-1;
	    		    } 
	    		    for (var  i=0;i<data.data.length;i++) {
	    		    	
	    		      $("#principalTable").append("<tr><td>"
	    				+data.data[i].user_id+"</td><td>"
	    				  +data.data[i].real_name+"</td><td>"
	    					+data.data[i].username+"</td><td>"
	    					+data.data[i].name+"</td><td>"
	    					+data.data[i].address+"</td><td><a href=javascript: class=bianji data-toggle=modal data-target=#myModal>"
	    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
	    					+"退休"+"</a></td></tr>");
				}
	    	
	    		    $("#curPage").val(data.curPage);
	    		    $("#pageSize").val(data.pageSize);
	    			$('.bianji').click(function(){
	    				var userId= $(this).parent("td").prev().prev().prev().prev().prev().html();
	    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
	    				var username = $(this).parent("td").prev().prev().prev().html();
	    				var name = $(this).parent("td").prev().prev().html();
	    				var address = $(this).parent("td").prev().html();
	    				$("#userId1").val(userId);
	    				$("#realName1").val(realName);
	    				$("#username1").val(username);
	    				$("#name1").val(name);
	    				$("#address1").val(address);
	    			});
	    		
				},
				error:function() {
					alert('后台报错')	
				}	
			});	
			});		
		
		
		/* 给模态框中的输入框赋值 */
		$('.bianji').click(function(){
			var userId= $(this).parent("td").prev().prev().prev().prev().prev().html();
			var realName = $(this).parent("td").prev().prev().prev().prev().html();
			var username = $(this).parent("td").prev().prev().prev().html();
			var name = $(this).parent("td").prev().prev().html();
			var address = $(this).parent("td").prev().html();
			$("#userId1").val(userId);
			$("#realName1").val(realName);
			$("#username1").val(username);
			$("#name1").val(name);
			$("#address1").val(address);
		});
		
		
		$("#updateprincipal").click(function(){
			var principalId=$("#userId1").val();
			var realName=$("#realName1").val();
			var username=$("#username1").val();
			var address1=$("#address1").val();
			$.ajax({
				url:"/BabyAssistantSystem/user/updatePrincipal",//发送请求地址
				type:"get",//发送请求的方法
				dataType:"text",//返回的数据类型
				data:{"id":principalId,"realName":realName,"address":address1,"username":username},//发送到服务器的数据自动转换为字符串格式
				success:function(data){//请求成功后回调函数
					if (data=='true') {
							alert("修改成功")	
							window.location.href="/BabyAssistantSystem/user/listPrincipal";
					} else {
						alert("修改失败")
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
	
	
<table id="principalTable" class="table table-condensed" style="width: 840px;">
       <tr><th>园长编号</th><th>园长名称</th><th>园长手机号</th><th>幼儿园名称</th><th>地址</th></tr>
    <c:forEach items="${pv.data}" var="principals">
    	<tr>
    		<td>${principals.user_id}</td>
    		<td>${principals.real_name }</td>    		
    		<td>${principals.username }</td>
    		<td>${principals.name }</td>
    		<td>${principals.address }</td>
             <td>
					<a href="javascript:" data-toggle="modal"data-target="#myModal" class="bianji">编辑</a>&nbsp;|&nbsp;
					<a href="${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }">退学</a>
					</td>
    	</tr>
    </c:forEach> 
    </table>
    
    
    <table>
   	<tr>
		<td colspan="8" style="text-align:center;">
			<ul class="pager">
				<li><a id="prevPage" href="javascript:">上一页</a></li>
				本页<input type="text" name="pageSize" id="pageSize" value="${pv.pageSize}"  style="width: 30px"/>条,
				当前第<input type="text" name="curPage" id="curPage"  value="${pv.curPage}"     style="width: 30px"/>页,
				共计<input type="text" name="pages" id="pages" style="border: none;width: 30px" value="${pv.pages}"      readonly="readonly"/>页
				<li><a id="nextPage" href="javascript:">下一页</a></li>
				
			</ul>
		</td>
	</tr>
</table>

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
	
	
	<!-- 园长信息模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
         <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">模态框（Modal）标题</h4>
            </div>
            <div class="modal-body">
        	<table class="table">
			<tr>
				<td><span class="types">园长编号:</span></td>
				<td><input type="text" name="userId" id="userId1" disabled="disabled"></td>
				
			</tr>
			<tr>
				<td><span class="types">园长名称：</span></td>
				<td><input type="text" name="realName1" id="realName1"></td>
                <td><span id="info"></span></td>
			</tr>
			<tr>
				<td><span class="types">园长手机号：</span></td>
				<td><input type="text" name="username1" id="username1"></td>
                <td><span id="info1"></span></td>
			</tr>
		
			<tr>
				<td><span class="types">幼儿园名称：</span></td>
				<td><input type="text" name="name1"  id="name1" disabled="disabled"></td>

			</tr>
				<tr>
				<td><span class="types">地址：</span></td>
				<td><input type="text" name="address1"   id="address1"></td>

			</tr>

		</table>
		</div>
		<input id="updateprincipal" style="margin-left: 200px"  type="button" class="btn btn-primary"  value="修改班级">
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
	
	
	
	
	
	
</body>
</html>
