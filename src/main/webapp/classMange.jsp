<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生管理</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="datepicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function() {
	/* 添加班级中的年级下拉框 */
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
	$("#gradeId2").bind('focus',function() {
		
    	$.ajax({
			url:"${pageContext.request.contextPath }/class/listGrade",
			type:"post",
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				//清空下拉框
				$("#gradeId2").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
				for(var i in data) {
					//下拉框重新赋值
					$("#gradeId2").append('<option value="'+data[i].gradeId+'">'+data[i].gradeName+'</option>');
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	$("#listClassInfo").click(function(){
		var className=$("#className2").val();
		var gradeId=$("#gradeId2").val();
		alert(className)
		$.ajax({
			url:"${pageContext.request.contextPath }/class/listClassInfo",
			type:"post",
			dataType:"json",
			data:{"className":className,"gradeId":gradeId},
			success:function(data) {
				var tb = document.getElementById('classTable');
    	    var rowNum=tb.rows.length;
    		    for (i=1;i<rowNum;i++) 
    		    {
    		        tb.deleteRow(i);
    		        rowNum=rowNum-1;
    		        i=i-1;
    		    } 
    		    for (var  i=0;i<data.data.length;i++) {
    		      $("#classTable").append("<tr id=listStudent><td>"
    				+data.data[i].class_id+"</td><td>"
    				  +data.data[i].class_name+"</td><td>"
    					+data.data[i].real_name+"</td><td>"
    					+data.data[i].grade_name+"</td><td>"
    					+data.data[i].name+"</td><td>"
    					+(data.data[i].count)+"</td><td><a  class=bianji   href=javascript:  data-toggle=modal  data-target=#myModal>"
    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
    					+"退休"+"</a></td></tr>");
			}
    		    $('.bianji').click(function(){
    		    	var classId = $(this).parent("td").prev().prev().prev().prev().prev().prev().html();
    				var className = $(this).parent("td").prev().prev().prev().prev().prev().html();
    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
    				var gradeName = $(this).parent("td").prev().prev().prev().html();
    				var kindergartenName = $(this).parent("td").prev().prev().html();
    				$("#classId").val(classId);
    				$("#className2").val(className);
    				$("#realName").val(realName);
    				$("#gradeName").val(gradeName);
    				$("#kindergartenName").val(kindergartenName);
    			});
    		    
    		    $("#curPage").val(data.curPage);
    		    $("#pages").val(data.pages);
			},
			error:function() {
				alert('后台报错')	
			}		
		});	
	});
		
    	
	
	/*判断在该幼儿园该班级名称是否已存在*/
	$("#className").blur(function(){
		var  className =$('#className').val();
		$.ajax({
			url:"${pageContext.request.contextPath }/class/isExistClassName",
			type:"post",
			dataType:"json",
			data:{"className":className},
			success:function(data) {
				if(data==true){
					$("#info").html('班级名称已存在')	
				}else{
					$("#info").html('班级名称未存在')			
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}		
		});	
	});
	
	/*判断在该幼儿园该班级名称是否已存在*/
	$("#className3").blur(function(){
		var  className =$('#className2').val();
		$.ajax({
			url:"${pageContext.request.contextPath }/class/isExistClassName",
			type:"post",
			dataType:"json",
			data:{"className":className},
			success:function(data) {
				if(data==true){
					$("#info1").html('班级名称已存在')	
				}else{
					$("#info1").html('班级名称未存在')			
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}		
		});	
	});
	
	/* 添加班级*/
	$("#saveClass").click(function(){
			var className = $('#className').val();
			var gradeId=$('#gradeId').val();		
			var info=$('#info').text();
			if(info=="班级名称已存在"){
				alert("班级名称已存在,请重新输入")
				return;
			}		
			$.ajax({
				url:"${pageContext.request.contextPath }/class/saveClass",
				type:"post",
				dataType:"json",
				data:{"className":className,"gradeId":gradeId},
				success:function(data) {
					if(data==true){
						alert('添加成功');	
						window.location.href="${pageContext.request.contextPath }/class/listClasses";
					}else{
						alert('添加失败')			
					}	
				},
				error:function() {
					alert('后台报错')	
				}	
			});

		});

	/* 上一页 */
	$("#prevPage").click(function(){
		var  curPage1=Number($('#curPage').val());
		var  pages=Number($('#pages').val());
		var  pageSize=Number($('#pageSize').val());
		var  curPage=(curPage1>=2)?curPage1-1:curPage1;
		$.ajax({	
			url:"${pageContext.request.contextPath }/class/listClass11",
			type:"post",
			dataType:"json",
			data:{"curPage":curPage,"pageSize":pageSize},
			success:function(data) {
				var tb = document.getElementById('classTable');
    	    var rowNum=tb.rows.length;
    		    for (i=1;i<rowNum;i++) 
    		    {
    		        tb.deleteRow(i);
    		        rowNum=rowNum-1;
    		        i=i-1;
    		    } 
    		    for (var  i=0;i<data.data.length;i++) {
    		      $("#classTable").append("<tr id=listStudent><td>"
    				+data.data[i].class_id+"</td><td>"
    				  +data.data[i].class_name+"</td><td>"
    					+data.data[i].real_name+"</td><td>"
    					+data.data[i].grade_name+"</td><td>"
    					+data.data[i].name+"</td><td>"
    					+(data.data[i].count)+"</td><td><a  class=bianji   href=javascript:  data-toggle=modal  data-target=#myModal>"
    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
    					+"退休"+"</a></td></tr>");
			}
    		    $('.bianji').click(function(){
    		    	var classId = $(this).parent("td").prev().prev().prev().prev().prev().prev().html();
    				var className = $(this).parent("td").prev().prev().prev().prev().prev().html();
    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
    				var gradeName = $(this).parent("td").prev().prev().prev().html();
    				var kindergartenName = $(this).parent("td").prev().prev().html();
    				$("#classId").val(classId);
    				$("#className2").val(className);
    				$("#realName").val(realName);
    				$("#gradeName").val(gradeName);
    				$("#kindergartenName").val(kindergartenName);
    			});
    		    
    		    $("#curPage").val(data.curPage);
			},
			error:function() {
				alert('后台报错')	
			}	
		});
	});
	
	
	
	/* 下一页 */
	$("#nextPage").click(function(){
		var  curPage1=Number($('#curPage').val());
		var  pages=Number($('#pages').val());
		var  pageSize=Number($('#pageSize').val());
		var className=$("#className2").val();
		var gradeId=$("#gradeId2").val();	
		var  curPage=(curPage1<pages)?curPage1+1:curPage1;	
		if(className==""&&gradeId==""){
		$.ajax({			
			url:"${pageContext.request.contextPath }/class/listClass11",
			type:"post",
			dataType:"json",
			data:{"curPage":curPage,"pageSize":pageSize},
			success:function(data) {
				var tb = document.getElementById('classTable');
    	    var rowNum=tb.rows.length;
    		    for (i=1;i<rowNum;i++) 
    		    {
    		        tb.deleteRow(i);
    		        rowNum=rowNum-1;
    		        i=i-1;
    		    } 
    		    for (var  i=0;i<data.data.length;i++) {
    		      $("#classTable").append("<tr id=listStudent><td>"
    				+data.data[i].class_id+"</td><td>"
    				  +data.data[i].class_name+"</td><td>"
    					+data.data[i].real_name+"</td><td>"
    					+data.data[i].grade_name+"</td><td>"
    					+data.data[i].name+"</td><td>"
    					+(data.data[i].count)+"</td><td><a  class=bianji   href=javascript:  data-toggle=modal  data-target=#myModal>"
    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
    					+"退休"+"</a></td></tr>");
			}
    		    $('.bianji').click(function(){
    		    	var classId = $(this).parent("td").prev().prev().prev().prev().prev().prev().html();
    				var className = $(this).parent("td").prev().prev().prev().prev().prev().html();
    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
    				var gradeName = $(this).parent("td").prev().prev().prev().html();
    				var kindergartenName = $(this).parent("td").prev().prev().html();
    				$("#classId").val(classId);
    				$("#className2").val(className);
    				$("#realName").val(realName);
    				$("#gradeName").val(gradeName);
    				$("#kindergartenName").val(kindergartenName);
    			});
    		    
    		    $("#curPage").val(data.curPage);
    		    
			},
			error:function() {
				alert('后台报错')	
			}	
		});
		}else{
			$.ajax({			
				url:"${pageContext.request.contextPath }/class/listClassInfo",
				type:"post",
				dataType:"json",
				data:{"curPage":curPage,"pageSize":pageSize,"className":className,"gradeId":gradeId},
				success:function(data) {
					var tb = document.getElementById('classTable');
	    	    var rowNum=tb.rows.length;
	    		    for (i=1;i<rowNum;i++) 
	    		    {
	    		        tb.deleteRow(i);
	    		        rowNum=rowNum-1;
	    		        i=i-1;
	    		    } 
	    		    for (var  i=0;i<data.data.length;i++) {
	    		      $("#classTable").append("<tr id=listStudent><td>"
	    				+data.data[i].class_id+"</td><td>"
	    				  +data.data[i].class_name+"</td><td>"
	    					+data.data[i].real_name+"</td><td>"
	    					+data.data[i].grade_name+"</td><td>"
	    					+data.data[i].name+"</td><td>"
	    					+(data.data[i].count)+"</td><td><a  class=bianji   href=javascript:  data-toggle=modal  data-target=#myModal>"
	    					+"编辑"+"</a>&nbsp;|&nbsp<a href=${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }>"
	    					+"退休"+"</a></td></tr>");
				}
	    		    $('.bianji').click(function(){
	    		    	var classId = $(this).parent("td").prev().prev().prev().prev().prev().prev().html();
	    				var className = $(this).parent("td").prev().prev().prev().prev().prev().html();
	    				var realName = $(this).parent("td").prev().prev().prev().prev().html();
	    				var gradeName = $(this).parent("td").prev().prev().prev().html();
	    				var kindergartenName = $(this).parent("td").prev().prev().html();
	    				$("#classId").val(classId);
	    				$("#className2").val(className);
	    				$("#realName").val(realName);
	    				$("#gradeName").val(gradeName);
	    				$("#kindergartenName").val(kindergartenName);
	    			});
	    		    
	    		    $("#curPage").val(data.curPage);
	    		    
				},
				error:function() {
					alert('后台报错')	
				}	
			});
		}
	});
	
	/* 给模态框赋值 */
	$('.bianji').click(function(){
		var classId = $(this).parent("td").prev().prev().prev().prev().prev().prev().html();
		var className = $(this).parent("td").prev().prev().prev().prev().prev().html();
		var realName = $(this).parent("td").prev().prev().prev().prev().html();
		var gradeName = $(this).parent("td").prev().prev().prev().html();
		var kindergartenName = $(this).parent("td").prev().prev().html();
		$("#classId").val(classId);
		$("#className3").val(className);
		$("#realName").val(realName);
		$("#gradeName").val(gradeName);
		$("#kindergartenName").val(kindergartenName);
	});

	/* 更新班级信息 */
	$("#updateClass").click(function() {
			var className = $('#className3').val();
			var realName = $("#realName").val();
			var classId = $("#classId").val();
			$.ajax({
				url : "/BabyAssistantSystem/class/updateClass",
				type : "post",
				dataType : "json",
				data : {"className" : className,"realName" : realName,"classId" : classId},
				success : function(data) {
					if (data==true) {				
						alert("更新成功")
						window.location.href="/BabyAssistantSystem/class/listClasses";
					} else {
						alert("更新失败")
					}
				},
			});

		});

	});
</script>
</head>
<body>
	<!-- 查询条件 -->
	<form id="form_session_find" action="${pageContext.request.contextPath }/baby/listStudent?curPage=${pv.curPage }&pageSize=${pv.pageSize }" method="post">
	<table class="table">
		<tr>
			<th><label for="fbabyName">班级名称:</label></th>
			<td><input type="text" name="className2" id="className2"/></td>	
			<td>年级:</td>		
			<td>
			     <select id="gradeId2" name="gradeId2">
					<option value="">--&nbsp;请选择&nbsp;--</option>
				</select>
			</td>
			<td>
				<input   type="button"  id="listClassInfo" class="btn btn-primary"   value="查询">
				<input type="button" class="btn btn-primary" id="excelBtn" value="导出Excel">
			</td>
		</tr>
	</table>
</form>


	<!-- 班级信息表 -->
	<table id="classTable" class="table table-condensed" style="width: 840px;">
	    <tr><th>班级编号</th><th>班级名称</th><th>老师名称</th><th>年级名称</th><th>幼儿园名称</th><th>班级人数</th><th>操作</th></tr>
	    <c:forEach items="${pv.data}" var="class1">
	    	<tr id="listStudent">
	    		<td>${class1.class_id}</td>
	    		<td>${class1.class_name}</td>
	    		<td>${class1.real_name }</td>
	    		<td>${class1.grade_name }</td>
	    		<td>${class1.name}</td>
	    		<td>${class1.count}</td>
	    		<td>
	            <a href="javascript:"  data-toggle="modal" data-target="#myModal" class ="bianji">编辑</a>&nbsp;|&nbsp;
	    	    <a href="${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }">退学</a>
	    		</td>
	    			
	    	</tr>
	    </c:forEach> 
	    </table>
	    
	    <table>
	   	<tr id="listStudent2" class="table table-condensed">
	   	<td width="40%" ></td>
			<td  style="text-align:center; margin-left: 100px" >
				<ul class="pager">
					<li><a id="prevPage" href="javascript:">上一页</a></li>
					每页<input type="text" name="pageSize" id="pageSize"  value="${pv.pageSize}" style="width: 30px"/>条,
					当前第<input type="text" name="curPage" id="curPage" style="width: 30px"   value="${pv.curPage}"/>页,
					共计<input type="text" name="pages" id="pages" style="border: none;width: 30px" readonly="readonly"  value="${pv.pages}"/>页
					<li><a id="nextPage" >下一页</a></li>
				</ul>
			</td>
		</tr>
	</table>


	<!-- 添加班级信息 -->
	<table class="table">
		<tr>
			<th><label>班级名称：</label></th>
			<td><input type="text" name="className" id="className"/></td>
			<td><span id="info"></span></td>
			<th><label>年级：</label></th>
			<td>
			    <select id="gradeId" name="gradeId">
					<option value="">--&nbsp;请选择&nbsp;--</option>
				</select>
			</td>
		</tr>	
		<tr>
		<td colspan="4" style="text-align:center;"> 
		<input id="saveClass"  type="button" class="btn btn-primary"  value="添加班级">
		</td>		
		</tr>
	</table>


		<!-- 班级信息模态框 -->
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
						<td><span class="types">班级编号:</span></td>
						<td><input type="text" name="classId" id="classId" disabled="disabled"></td>
						
					</tr>
					<tr>
						<td><span class="types">班级名称：</span></td>
						<td><input type="text" name="className3" id="className3"></td>
		                <td><span id="info1"></span></td>
					</tr>
					<tr>
						<td><span class="types">老师名称：</span></td>
						<td><input type="text" name="realName"  id="realName"></td>
		
					</tr>
					<tr>
						<td><span class="types">年级名称：</span></td>
						<td><input type="text" name="gradeName" disabled="disabled" id="gradeName"></td>
		
					</tr>
						<tr>
						<td><span class="types">幼儿园名称：</span></td>
						<td><input type="text" name="kindergartenName"   disabled="disabled" id="kindergartenName"></td>
		
					</tr>
				</table>
				</div>
				<input id="updateClass" style="margin-left: 200px"  type="button" class="btn btn-primary"  value="修改班级">
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		
		</div>
		   
</body>
</html>