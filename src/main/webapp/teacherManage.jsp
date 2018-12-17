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
</style>
<script type="text/javascript">

	$(function() {
		$.ajax({
		
			url:"/BabyAssistantSystem/user/countSex",//发送请求地址
			type:"get",//发送请求的方法
			dataType:"json",//返回的数据类型
			success:function(data){//请求成功后回调函数
			
					var myChart = echarts.init(document.getElementById('main'));
					var weatherIcons = {
						    'data1': data[0].count,
				
						};
					// 指定图表的配置项和数据
					var option = {
						    title: {
						        text: '幼儿园男女老师比重',
						        left: 'center'
						    },
						    tooltip : {
						        trigger: 'item',
						        formatter: "{a} <br/>{b} : {c} ({d}%)"
						    },
						    legend: {
						        // orient: 'vertical',
						        // top: 'middle',
						        bottom: 10,
						        left: 'center',
						        data: [data[1].sex+"老师",  data[0].sex+'老师']
						    },
						    series : [
						        {
						            type: 'pie',
						            radius : '65%',
						            center: ['50%', '50%'],
						            selectedMode: 'single',
						            data:[
						               
						                {value:data[0].count, name: data[0].sex+"老师",
						                	
						                    label: {
						                        normal: {
						                            formatter: [
						                                ''+data[0].sex+"老师"+'{value|'+data[0].count+'}',						                      
						                            ].join('\n'),
						                            backgroundColor: '#eee',
						                            borderColor: '#777',
						                            borderWidth: 1,
						                            borderRadius: 4,
						                            rich: {
						                                value: {
						                                    width: 5,
						                                    padding: [0, 20, 0, 30],
						                                    align: 'left'
						                                },
						                      
						                            }
						                        }
						                    }
						                
						                },
						           
						                {value:data[1].count, name: data[1].sex+'老师',
						                	 label: {
							                        normal: {
							                            formatter: [
							                                ''+data[1].sex+"老师"+'{value|'+data[1].count+'}',						                      
							                            ].join('\n'),
							                            backgroundColor: '#eee',
							                            borderColor: '#777',
							                            borderWidth: 1,
							                            borderRadius: 4,
							                            rich: {
							                                value: {
							                                    width:5,
							                                    padding: [0, 20, 0, 30],
							                                    align: 'left'
							                                },
							                      
							                            }
							                        }
							                    }},
						      
						            ],
						            itemStyle: {
						                emphasis: {
						                    shadowBlur: 10,
						                    shadowOffsetX: 0,
						                    shadowColor: 'rgba(0, 0, 0, 0.5)'
						                }
						            }
						        }
						    ]
						};
					// 使用刚指定的配置项和数据显示图表。
					myChart.setOption(option);
									
			},
			error:function(){//请求失败后回调函数
				alert('后台报错')
			}
		});	
		


	
		$("#bingzhuang").click(function(){
			
			window.location.href="/BabyAssistantSystem/bingzhuang.jsp"
			
		});

		
		/* 判断手机号是否已存在*/
		$("#username").blur(function(){
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
			
		});
		
		/*添加教师 */
		$("#teacherRegister1").click(function(){
			//将值作为参数传送到servlet ，已ajax方式传送到servlet
			//创建一个xhr，作为前台界面与后台servlet交互的关键对象
		var  username=$('#username').val();
		var  password=$('#password').val();
		var  repassword=$('#repassword').val();
		var  classId=$('#classId').val();
		var  realName=$('#realName').val();
		var  info=$('#info').text(); 	
		if(info=='手机号已被注册'){
			alert("手机号已存在")
			return;
		}
		if(username==""){
			alert("请输入手机号")
			return;
		}
		if(password==""){
			alert("请输入密码")
			return;
		}
		if(repassword==""){
			alert("请输入确认密码")
			return;
		}

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
		
		/*班级下拉框 */
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
		
		/*判断该班级是否已经存在老师 */
		$("#classId").blur(function(){
					//获取文本框的值
					var classId = $('#classId').val();		
					if(classId==""){
						return;
						
					}
					 $.ajax({
							url:"${pageContext.request.contextPath }/class/isExistsTeacherByClassId",//发送请求地址
							type:"post",//发送请求的方法
							dataType:"text",//返回的数据类型
							data:{"classId":classId},
							success:function(data,status){//请求成功后回调函数
								if (data !="null") {
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
		
		/* 判断两次密码是否一致 */
		$("#repassword").blur(function(){
			
			if($('#password').val()!=$('#repassword').val()){				
				alert('密码不一致')	
				document.getElementById("password").value="";
				document.getElementById("repassword").value="";
			}
	
			
		});
		
		
		/* 给模态框中的输入框赋值 */
		$('.bianji').click(function(){
			var userId= $(this).parent("td").prev().prev().prev().prev().prev().html();
			var realName = $(this).parent("td").prev().prev().prev().prev().html();
			var className = $(this).parent("td").prev().prev().prev().html();
			var username = $(this).parent("td").prev().prev().html();
			var address = $(this).parent("td").prev().html();
			$("#userId1").val(userId);
			$("#realName1").val(realName);
			$("#className1").val(className);
			$("#username1").val(username);
			$("#address1").val(address);
		});
		
		/* 前一页*/
		$("#prevPage").click(function(){
			var pageSize=Number($('#pageSize').val());
			var curPage1=Number($('#curPage').val());
			var pages=Number($('#pages').val());	
			var curPage=curPage1>1?curPage1-1:curPage1;
			$.ajax({
				url:"${pageContext.request.contextPath }/user/listTeacher1",
				type:"post",
				dataType:"json",
				data:{"curPage":curPage,"pageSize":pageSize},
				success:function(data) {
					var tb = document.getElementById('teacherTable');
	    	    var rowNum=tb.rows.length;
	    		    for (i=1;i<rowNum;i++) 
	    		    {
	    		        tb.deleteRow(i);
	    		        rowNum=rowNum-1;
	    		        i=i-1;
	    		    } 
	    		    for (var  i=0;i<data.data.length;i++) {
	    		    	
	    		    	$("#teacherTable").append("<tr><td>"
	    	    				+data.data[i].user_id+"</td><td>"
	    	    				  +data.data[i].real_name+"</td><td>"
	    	    					+data.data[i].class_name+"</td><td>"
	    	    					+data.data[i].username+"</td><td>"
	    	    					+data.data[i].address+"</td><td><a href=javascript:  class=bianji data-toggle=modal data-target=#myModal>"
	    	    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
	    	    					+"退休"+"</a></td></tr>");
				}
	    			/* 刷新当前页数 */
	    		    $("#curPage").val(data.curPage);
	    		    
	    			/* 刷新按钮*/
	    			$('.bianji').click(function(){
	    				var userId= $(this).parent("td").prev().prev().prev().prev().prev().html();
	    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
	    				var className = $(this).parent("td").prev().prev().prev().html();
	    				var username = $(this).parent("td").prev().prev().html();
	    				var address = $(this).parent("td").prev().html();
	    				$("#userId1").val(userId);
	    				$("#realName1").val(realName);
	    				$("#className1").val(className);
	    				$("#username1").val(username);
	    				$("#address1").val(address);	    			
	    			});
				},
				error:function() {
					alert('后台报错')	
				}	
			});	
			});
		
		
		
		
		/* 下一页 */
		$("#nextPage").click(function(){
			var pageSize=Number($('#pageSize').val());
			var curPage1=Number($('#curPage').val());
			var pages=Number($('#pages').val());	
			var curPage=curPage1<pages?curPage1+1:curPage1;
			   alert(curPage);
			$.ajax({
				url:"${pageContext.request.contextPath }/user/listTeacher1",
				type:"post",
				dataType:"json",
				data:{"curPage":curPage,"pageSize":pageSize},
				success:function(data) {
					var tb = document.getElementById('teacherTable');
	    	    var rowNum=tb.rows.length;
	    		    for (i=1;i<rowNum;i++) 
	    		    {
	    		        tb.deleteRow(i);
	    		        rowNum=rowNum-1;
	    		        i=i-1;
	    		    } 
	    		    for (var  i=0;i<data.data.length;i++) {
	    		    	
	    		      $("#teacherTable").append("<tr><td>"
	    				+data.data[i].user_id+"</td><td>"
	    				  +data.data[i].real_name+"</td><td>"
	    					+data.data[i].class_name+"</td><td>"
	    					+data.data[i].username+"</td><td>"
	    					+data.data[i].address+"</td><td><a href=javascript: class=bianji data-toggle=modal data-target=#myModal>"
	    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
	    					+"退休"+"</a></td></tr>");
				}
	    		 
	    		    $("#curPage").val(data.curPage);
	    			$('.bianji').click(function(){
	    				var userId= $(this).parent("td").prev().prev().prev().prev().prev().html();
	    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
	    				var className = $(this).parent("td").prev().prev().prev().html();
	    				var username = $(this).parent("td").prev().prev().html();
	    				var address = $(this).parent("td").prev().html();
	    				$("#userId1").val(userId);
	    				$("#realName1").val(realName);
	    				$("#className1").val(className);
	    				$("#username1").val(username);
	    				$("#address1").val(address);
	    			});
	    		
				},
				error:function() {
					alert('后台报错')	
				}	
			});	
			});		
		
		
		
		
		$("#updateTeacher").click(function(){
			var teacherId=$("#userId1").val();
			var realName=$("#realName1").val();
			var address1=$("#address1").val();
			$.ajax({
				url:"/BabyAssistantSystem/user/updateTeacher",//发送请求地址
				type:"get",//发送请求的方法
				dataType:"text",//返回的数据类型
				data:{"id":teacherId,"realName":realName,"address":address1},//发送到服务器的数据自动转换为字符串格式
				success:function(data){//请求成功后回调函数
					if (data=='true') {
							alert("修改成功")	
							window.location.href="/BabyAssistantSystem/user/listTeacher";
					} else {
						alert("修改失败")
					}							
				},
				error:function(){//请求失败后回调函数
					alert('后台报错')
				}
			});	
			
			
		});
		
		
		
		
		$("#addFile").on("change",function(){
			var filePath=$(this).val();
		
			type = filePath.substring(filePath.lastIndexOf(".")).toLowerCase(),			
		    src = window.URL.createObjectURL(this.files[0]); //转成可以在本地预览的格式
		    if( !type.match(/.png|.jpg|.jpeg/) ) {
		    	 alert("您上传图片的类型不符合(.jpg|.jpeg|.gif|.png)！");
		    	 document.getElementById('addFile').value="";
		}
			$("#image").attr('src',src);
		});

	});

    

</script>
</head>
<body>
<div>



        <div id="main11" style="width: 100%;height:150px;" >
        <div  id="left" style="width: 70%;height:150px; float: left;">
        <table id="teacherTable" class="table table-condensed"
			style="width: 750px;">
			<tr>
				<th>教师编号</th>
				<th>教师名称</th>
				<th>班级名称</th>
				<th>教师手机号</th>
				<th>教师家庭地址</th>
			</tr>
			<c:forEach items="${pv.data}" var="teachers">
				<tr>
					<td>${teachers.user_id}</td>
					<td>${teachers.real_name }</td>
					<td>${teachers.class_name }</td>
					<td>${teachers.username }</td>
					<td>${teachers.address }</td>
					<td>
					<a href="javascript:" data-toggle="modal"data-target="#myModal" class="bianji">编辑</a>
					</td>
				</tr>
			</c:forEach>
		</table>
        
        </div>
        <div id="right" style="width: 30%;height:150px; float: right;">
         <div id="main" style="width: 100%;height:150px;"></div>
        </div>
        
        </div> 
      	<!-- 教师信息表 -->
		
		
		<!-- 教师分页表 -->
		<table id="teacherTable1" class="table table-condensed">
			<tr>
				<td colspan="8" style="text-align: center;">
					<ul class="pager">
						<li><a id="prevPage" href="javascript:">上一页</a></li> 每页
						<input type="text" name="pageSize" id="pageSize" value="${pv.pageSize}" style="width: 30px" />条, 当前第
						<input type="text" name="curPage" id="curPage" value="${pv.curPage}" style="width: 30px" />页,
						共计
						<input type="text" name="pages" id="pages" value="${pv.pages}"
							style="border: none; width: 30px" readonly="readonly" />页
						<li><a id="nextPage" href="javascript:">下一页</a></li>
					</ul>
				</td>
			</tr>
		</table>
			
		<!-- 添加教师信息表 -->
		<table class="table">
			<tr>
				<th><label>手机号:</label></th>
				<td><input type="text" name="username" id="username"></td>
				<td><span id="info"></span></td>

				<th><label>密码：</label></th>
				<td><input type="password" name="password" id="password" value=""></td>
				<td><span></span></td>
				<th><label>确认密码：</label></th>
				<td><input type="password" name="password" id="repassword"></td>
			</tr>
			<tr>
				<th><label>年级：</label></th>
				<td><select id="gradeId" name="gradeId">
						<option value="">--&nbsp;请选择&nbsp;--</option>
				</select></td>
				<td><span></span></td>
				<th><label>班级：</label></th>
				<td><select id="classId" name="classId">
						<option value="">--&nbsp;请选择&nbsp;--</option>
				</select></td>
				<td><span id="info1"></span></td>
				<th><label>真实名称：</label></th>
				<td><input type="text" name="realName" id="realName"></td>
			</tr>
		</table>
		
		<input id="teacherRegister1"   type="button" value="老师注册" class="btn btn-primary">

	</div>
		
		<!-- 教师信息模态框 -->
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
				<td><span class="types">教师编号:</span></td>
				<td><input type="text" name="userId" id="userId1" disabled="disabled"></td>
				
			</tr>
			<tr>
				<td><span class="types">教师名称：</span></td>
				<td><input type="text" name="realName1" id="realName1"></td>
                <td><span id="info2"></span></td>
			</tr>
			<tr>
				<td><span class="types">班级名称：</span></td>
				<td><input type="text" name="className1"  id="className1" disabled="disabled"></td>

			</tr>
			<tr>
				<td><span class="types">教师手机号：</span></td>
				<td><input type="text" name="username1"  id="username1" disabled="disabled"></td>

			</tr>
				<tr>
				<td><span class="types">家庭地址：</span></td>
				<td><input type="text" name="address1"   id="address1"></td>

			</tr>

		</table>
		</div>
		<input id="updateTeacher" style="margin-left: 200px"  type="button" class="btn btn-primary"  value="修改班级">
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<form method="post" action="/BabyAssistantSystem/user/UploadServlet " enctype="multipart/form-data">
    选择一个文件:
    <input type="file" name="uploadFile"  id="addFile" />
    <img id="image"  style="width: 50px;height: 50px">
    <br/><br/>
    <input type="submit" value="上传" />
</form>

	
</body>
</html>