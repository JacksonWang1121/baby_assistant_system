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

	/* 刷新多条件信息 */
	console.log("payStatus = ${conditions.payStatus }");
	$(".fpayStatus[value='${conditions.payStatus }']").prop("checked","checked");

	/* 刷新分页信息 */
	console.log("pageSize = ${pv.pageSize },curPage = ${pv.curPage },pages = ${pv.pages }");
	$("#pageSize").val('${pv.pageSize }');
	$("#curPage").val('${pv.curPage }');
	$("#pages").val('${pv.pages }');
	
	/* 多条件查询中的班级下拉框 */
	$("#cls").bind('focus',function() {
    	$.ajax({
			url:"${pageContext.request.contextPath }/class/listClass",
			type:"post",
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				var cls = '<option value="">--&nbsp;请选择&nbsp;--</option>';
				for(var i in data) {
					//下拉框重新赋值
					cls = cls + '<option value="'+data[i].grade_name+','+data[i].class_id+','+data[i].class_name+'">'
							+data[i].grade_name+','+data[i].class_name+'</option>';
				}
				//重置下拉框
				$("#cls").html(cls);
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	/* 重置按钮注册事件 */
	$("#resetBtn").bind('click',function() {
		$("#fbabyName").val("");
		$("#cls").html('<option value>--&nbsp;请选择&nbsp;--</option>');
		$("#fenterDate").val("");
		$('.fpayStatus[value=""]').prop("checked","checked");
	});
	
	/* 注册上一页的点击事件 */
	$("#prevPage").click(function() {
		//获取每页的条数
		var pageSize = $("#pageSize").val();
		console.log("pageSize = "+pageSize);
		//获取当前页
		//String转int
		var value = Number($("#curPage").val());
		var curPage = (value-1==0)?1:(value-1);
		console.log("curPage = "+curPage);
		var conditions = getConditions();
		window.location.href = "${pageContext.request.contextPath }/baby/listStudent?curPage="+curPage+"&pageSize="+pageSize+"&"+conditions;
	});
	
	/* 每页条数的失去焦点事件 */
	$("#pageSize").blur(function() {
		//获取每页的条数
		var pageSize = $("#pageSize").val();
		console.log("pageSize = "+pageSize);
		//获取当前页
		//String转int
		var curPage = Number($("#curPage").val());
		console.log("curPage = "+curPage);
		var conditions = getConditions();
		window.location.href = "${pageContext.request.contextPath }/baby/listStudent?curPage="+curPage+"&pageSize="+pageSize+"&"+conditions;
	});
	
	/* 当前页的获得焦点事件 */
	$("#curPage").focus(function() {
		//获取当前页
		//String转int
		curPageValue = Number($("#curPage").val());
		console.log("curPageValue = "+curPageValue);
	});
	
	/* 当前页的失去焦点事件 */
	$("#curPage").blur(function() {
		//获取每页的条数
		var pageSize = $("#pageSize").val();
		console.log("pageSize = "+pageSize);
		//获取总页数
		var pages = Number($("#pages").val());
		console.log("pages = "+pages);
		//获取当前页
		//String转int
		var value = Number($("#curPage").val());
		var curPage = (value>0 && value<(pages+1))?value:curPageValue;
		console.log("curPage = "+curPage);
		var conditions = getConditions();
		window.location.href = "${pageContext.request.contextPath }/baby/listStudent?curPage="+curPage+"&pageSize="+pageSize+"&"+conditions;
	});
	
	/* 注册下一页的点击事件 */
	$("#nextPage").click(function() {
		//获取每页的条数
		var pageSize = $("#pageSize").val();
		console.log("pageSize = "+pageSize);
		//获取总页数
		var pages = Number($("#pages").val());
		console.log("pages = "+pages);
		//获取当前页
		//String转int
		var value = Number($("#curPage").val());
		var curPage = (value+1>pages)?value:(value+1);
		console.log("curPage = "+curPage);
		var conditions = getConditions();
		window.location.href = "${pageContext.request.contextPath }/baby/listStudent?curPage="+curPage+"&pageSize="+pageSize+"&"+conditions;
	});
	
	/* 检查学号是否已存在 */
	$("#babyNo").bind('blur',function() {
		var babyNo = $("#babyNo").val();
    	$.ajax({
			url:"${pageContext.request.contextPath }/baby/findStudent",
			type:"post",
			data:{"babyNo":babyNo},
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				if (data != null) {
					alert("学号已存在，请重新输入");
					$("#babyNo").val("");
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	/* 检查联系电话是否已存在 */
	$("#username").bind('blur',function() {
		var username = $("#username").val();
    	$.ajax({
			url:"${pageContext.request.contextPath }/user/findByUsername",
			type:"post",
			data:{"username":username},
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				if (data != null) {
					alert("联系电话已存在，请重新输入");
					$("#username").val("");
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
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
				var grade = '<option value="">--&nbsp;请选择&nbsp;--</option>';
				for(var i in data) {
					//下拉框重新赋值
					grade = grade + '<option value="'+data[i].gradeId+'">'+data[i].gradeName+'</option>';
				}
				//重置下拉框
				$("#gradeId").html(grade);
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	/* 添加学生记录中的班级下拉框 */
	$("#classId").bind('focus',function() {
    	$.ajax({
			url:"${pageContext.request.contextPath }/class/listClass",
			type:"post",
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				//清空下拉框
				$("#classId").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
				for(var i in data) {
					//下拉框重新赋值
					$("#classId").append('<option value="'+data[i].class_id+'">'
							+data[i].grade_name+','+data[i].class_name+'</option>');
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	/* 添加学生记录 */
	$("#saveStudentBtn").bind('click',function() {
		//获取学生学号
		var babyNo = $("#babyNo").val();
		if (babyNo==null || babyNo.trim()=="") {
			alert("请输入学生学号");
			return;
		}
		//获取学生姓名
		var babyName = $("#babyName").val();
		if (babyName==null || babyName.trim()=="") {
			alert("请输入学生姓名");
			return;
		}
		//获取联系电话
		var username = $("#username").val();
		if (username==null || username.trim()=="") {
			alert("请输入联系电话");
			return;
		}
		//获取联系电话
		var gradeId = $("#gradeId").val();
		if (gradeId==null || gradeId.trim()=="") {
			alert("请选择年级");
			return;
		}
		//获取表单内容
		var formData = $("#form_stu_save").serialize();
    	$.ajax({
			url:"${pageContext.request.contextPath }/baby/saveStudent",
			type:"post",
			data:formData,
			dataType:"text",
			success:function(data, status) {
				console.log("success-data = "+data);
				if (data == "true") {
					alert("保存成功");
					window.location.href = "${pageContext.request.contextPath }/baby/listStudent";
				} else {
					alert("保存失败");
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
				alert("保存失败");
			}
		});
	});
	
});

/* 获取学生列表上方的查询条件，并拼接成url格式的字符串 */
function getConditions() {
	var babyName = $("#fbabyName").val();
	var cls = $("#cls").val();
	var enterDate = $("#fenterDate").val();
	var payStatus = $(".fpayStatus").val();
	console.log("babyName = "+babyName+",classId = "+classId+",enterDate = "+enterDate+",payStatus = "+payStatus);
	return "babyName = "+babyName+",cls = "+cls+",enterDate = "+enterDate+",payStatus = "+payStatus;
}
</script>
</head>
<body>
<!-- 查询条件 -->
<form id="form_session_find" action="${pageContext.request.contextPath }/baby/listStudent?curPage=${pv.curPage }&pageSize=${pv.pageSize }" method="post">
<table class="table">
	<tr>
		<th><label for="fbabyName">学生姓名</label></th>
		<td><input type="text" name="babyName" id="fbabyName" value="${conditions.babyName }"/></td>
		<th><label for="cls">班级</label></th>
		<td>
			<select name="cls" id="cls">
				<c:if test="${conditions.classId eq null }">
					<option value="">--&nbsp;请选择&nbsp;--</option>
				</c:if>
				<c:if test="${conditions.classId ne null }">
					<option value="${gradeName },${conditions.classId },${className }">${gradeName },${className }</option>
				</c:if>
			</select>
		</td>
		<td>
			<input type="submit" class="btn btn-primary" value="查询">
			<input type="button" class="btn btn-primary" id="resetBtn" value="重置">
			<input type="button" class="btn btn-primary" id="excelBtn" value="导出Excel">
		</td>
	</tr>
	<tr>
		<th><label for="fenterDate">入园时间</label></th>
		<td><input type="text" class="Wdate" name="enterDate" id="fenterDate" value="${conditions.enterDate }" onclick="WdatePicker({'dateFmt':'yyyy-MM-dd'})"/></td>
		<th><label for="payStatus">缴费状态</label></th>
		<td>
			<input type="radio" name="payStatus" class="fpayStatus" value="" checked="checked"/>全部
			<input type="radio" name="payStatus" class="fpayStatus" value="0"/>待缴费
			<input type="radio" name="payStatus" class="fpayStatus" value="1"/>已缴费
		</td>
	</tr>
</table>
</form>

<!-- 查询所有用户信息 -->
<table id="listStudent" class="table table-condensed" style="width: 840px;">
    <tr><th>姓名</th><th>学号</th><th>班级</th><th>家长</th><th>联系电话</th><th>入园时间</th><th>家庭地址</th><th>缴费状态</th><th>操作</th></tr>
    <c:forEach items="${pv.data }" var="stu">
    	<tr>
    		<td>${stu.baby_name }</td>
    		<td>${stu.baby_no }</td>
    		<td>${stu.class_name }</td>
    		<td>${stu.real_name }</td>
    		<td>${stu.username }</td>
    		<td>${stu.enter_date }</td>
    		<td>${stu.address }</td>
    		<td>
    			<c:if test="${stu.pay_status eq 0 }">待缴费</c:if>
    			<c:if test="${stu.pay_status eq 1 }">已缴费</c:if>
    		</td>
    		<td>
    			<a href="javascript:">编辑</a>&nbsp;|&nbsp;
    			<c:if test="${stu.pay_status eq 0 }">
	    			<a href="${pageContext.request.contextPath }/baby/hasPaid?babyId=${stu.baby_id }">已缴费</a>&nbsp;|&nbsp;
    			</c:if>
    			<a href="${pageContext.request.contextPath }/baby/quitSchool?babyId=${stu.baby_id }">退学</a>
    		</td>
    	</tr>
    </c:forEach>
   	<tr>
		<td colspan="8" style="text-align:center;">
			<ul class="pager">
				<li><a id="prevPage" href="javascript:">上一页</a></li>
				每页<input type="text" name="pageSize" id="pageSize" style="width: 30px"/>条,
				当前第<input type="text" name="curPage" id="curPage" style="width: 30px"/>页,
				共计<input type="text" name="pages" id="pages" style="border: none;width: 30px" readonly="readonly"/>页
				<li><a id="nextPage" href="javascript:">下一页</a></li>
			</ul>
		</td>
	</tr>
</table>

<!-- 学生信息添加 -->
<form id="form_stu_save" action="" method="post">
<table class="table">
	<tr>
		<th><label>学号</label></th>
		<td><input type="text" name="babyNo" id="babyNo"/></td>
		<th><label>姓名</label></th>
		<td><input type="text" name="babyName"/></td>
		<th><label>联系电话</label></th>
		<td><input type="text" name="username" id="username"/></td>
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
		</td>
		<th><label>缴费状态</label></th>
		<td>
			<input type="radio" name="payStatus" class="payStatus" value="0" checked="checked"/>待缴费
			<input type="radio" name="payStatus" class="payStatus" value="1"/>已缴费
		</td>
	</tr>
	<tr>
		<td colspan="6" style="text-align:center;">
			<input type="button" class="btn btn-primary" value="保存" id="saveStudentBtn">
		</td>
	</tr>
</table>
</form>
</body>
</html>