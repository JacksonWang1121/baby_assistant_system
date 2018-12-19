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
<script type="text/javascript">
$(function() {
	
	/* 原班级下拉框 */
	$("#oldClass").bind('focus',function() {
    	$.ajax({
			url:"${pageContext.request.contextPath }/class/listClass",
			type:"post",
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				for(var i in data) {
					if (i == 0) {
						//清空下拉框
						$("#oldClass").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
					}
					//下拉框重新赋值
					$("#oldClass").append('<option value="'+data[i].gradeId+','+data[i].classId+','+data[i].className+'">'
							+data[i].className+'</option>');
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	/* 原班级下拉框：选择班级 */
	$("#oldClass").bind('change',function() {
		var oldClass = $("#oldClass").val();
		if (oldClass!=null || oldClass!="") {
			window.location.href = "${pageContext.request.contextPath }/baby/listStudentByClassId?oldClass="+oldClass;
		}
	});
	
	/* 现班级下拉框 */
	$("#newClass").bind('focus',function() {
    	$.ajax({
			url:"${pageContext.request.contextPath }/class/listClass",
			type:"post",
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				//清空下拉框
				$("#newClass").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
				for(var i in data) {
					//下拉框重新赋值
					$("#newClass").append('<option value="'+data[i].gradeId+','+data[i].classId+'">'
							+data[i].className+'</option>');
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	/* 学生记录全选框 */
	$("#allStuIdCheck").bind("click", function() {
		//获取全选框的checked属性值
		//JQ1.6之后，它将“属性”与“特性”做了区别，可以通过attr方法去获得属性，通过prop方法去获得特性 
		var check = $("#allStuIdCheck").prop("checked");
		console.log("allStuIdCheck = "+check);
		//若全选框为选中，则选中所有的复选框
		//否则取消选中所有的复选框
		if (check) {
			$(".stuId").prop("checked",true);
		} else {
			$(".stuId").prop("checked",false);
		}
	});
	
	/* 待缴费全选框 */
	/* $("#allUnpaidCheck").bind("click", function() {
		//获取全选框的checked属性值
		//JQ1.6之后，它将“属性”与“特性”做了区别，可以通过attr方法去获得属性，通过prop方法去获得特性 
		var check = $("#allUnpaidCheck").prop("checked");
		console.log("allUnpaidCheck = "+check);
		//若全选框为选中，则选中所有的复选框
		//否则取消选中所有的复选框
		if (check) {
			$(".unpaid").prop("checked",true);
		} else {
			$(".unpaid").prop("checked",false);
		}
	}); */
	
	/* 已缴费全选框 */
	$("#allPaidCheck").bind("click", function() {
		//获取全选框的checked属性值
		//JQ1.6之后，它将“属性”与“特性”做了区别，可以通过attr方法去获得属性，通过prop方法去获得特性 
		var check = $("#allPaidCheck").prop("checked");
		console.log("allPaidCheck = "+check);
		//若全选框为选中，则选中所有的复选框
		//否则取消选中所有的复选框
		if (check) {
			$(".paid").prop("checked",true);
		} else {
			$(".paid").prop("checked",false);
		}
	});
	
	/* 同一学生记录的待缴费复选框和已缴费复选框，只能二选一 */
	//遍历待缴费复选框
	/* $(".unpaid").each(function() {
		//点击某一学生记录的待缴费复选框
		$(this).bind("click", function() {
			//若该学生记录的待缴费复选框被选中，则取消该学生记录的已缴费复选框的选中(若该学生记录的已缴费复选框已被选中)
			var unpaidCheck = $(this).prop("checked");
			var paidCheck = $(this).next("input").prop("checked");
			if (unpaidCheck && paidCheck) {
				$(this).next("input").prop("checked",false);
			}
		});
	}); */
	//遍历已缴费复选框
	/* $(".paid").each(function() {
		//点击某一学生记录的已缴费复选框
		$(this).bind("click", function() {
			//若该学生记录的已缴费复选框被选中，则取消该学生记录的待缴费复选框的选中(若该学生记录的待缴费复选框已被选中)
			var paidCheck = $(this).prop("checked");
			var unpaidCheck = $(this).prev("input").prop("checked");
			if (paidCheck && unpaidCheck) {
				$(this).prev("input").prop("checked",false);
			}
		});
	}); */
	
	/* 升学报名 */
	$("#enrollmentBtn").bind('click',function() {
		//年级id
		var gradeId = 0;
		//班级id
		var classId = 0;
		//分班状态，默认为1，未分班，即已申请状态
		var applyStatus = 1;
		//获取现班级
		var newClass = $("#newClass").val();
		if (newClass==null || newClass=="") {
			if (!confirm("未选择新班级，是否跳过？")) {
				return;
			}
		} else {
			var cls = newClass.split(",");
			//获取年级id
			gradeId = cls[0];
			//获取班级id
			classId = cls[1];
			//分班状态置为已分班
			applyStatus = 0;
		}
		//创建存放学生升学报名数据的数组
		var stuList = new Array();
		//获取所有选中的学生记录的复选框
		var stu = $(".stuId:checked");
		console.log("stu.length = "+stu.length);
		for (var i = 0; i < stu.length; i++) {
			//获取学生id
			var babyId = stu.eq(i).val();
			//缴费状态，默认为0，待缴费
			var payStatus = 0;
			//获取该学生记录的已缴费状态复选框
			var paidCheck = stu.eq(i).parent().parent().last().first().prop("checked");
			console.log("paidCheck = "+paidCheck);
			if (paidCheck) {
				payStatus = 1;
			}
			//创建对象，存储该学生的升学报名数据
			var obj = new Object();
			obj["babyId"] = babyId;
			obj["gradeId"] = gradeId;
			obj["classId"] = classId;
			obj["applyStatus"] = applyStatus;
			obj["payStatus"] = payStatus;
			//将该学生的升学报名数据添加到stuList数组中
			stuList.push(obj);
		}
		//数组转json字符串
		var json = JSON.stringify(stuList);
		console.log(json);
    	$.ajax({
			url:"${pageContext.request.contextPath }/baby/enrollmentApplication",
			type:"post",
			data:json,
			dataType:"text",
			success:function(data, status) {
				console.log("success-data = "+data);
				if (data == "true") {
					alert("报名成功");
					$("#oldClass").change();
				} else {
					alert("报名失败");
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
				alert("报名失败");
			}
		});
	});
	
	/* 毕业离校 */
	$("#graduationBtn").bind('click',function() {
		//创建存放学生id数据的数组
		var stuList = new Array();
		//获取所有选中的学生记录的复选框
		var stu = $(".stuId:checked");
		console.log("stu.length = "+stu.length);
		for (var i = 0; i < stu.length; i++) {
			//获取学生id
			var babyId = stu.eq(i).val();
			stuList.push(babyId);
		}
		//数组转json字符串
		var json = JSON.stringify(stuList);
		console.log(json);
    	$.ajax({
			url:"${pageContext.request.contextPath }/baby/graduation",
			type:"post",
			data:json,
			dataType:"text",
			success:function(data, status) {
				console.log("success-data = "+data);
				if (data == "true") {
					alert("毕业成功");
				} else {
					alert("毕业失败");
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
				alert("毕业失败");
			}
		});
	});
	
});
</script>
</head>
<body>
<!-- 班级下拉框 -->
原班级
<select name="oldClass" id="oldClass">
	<c:if test="${oldClass eq null }">
		<option value="">--&nbsp;请选择&nbsp;--</option>
	</c:if>
	<c:if test="${oldClass ne null }">
		<option value="${oldClass }">${oldClassName }</option>
	</c:if>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;
现班级
<select name="newClass" id="newClass">
	<c:if test="${newClass eq null }">
		<option value="">--&nbsp;请选择&nbsp;--</option>
	</c:if>
	<c:if test="${newClass ne null }">
		<option value="${newClass }">${stu.class_name }</option>
	</c:if>
</select>
<br><br>
<!-- 查询所有用户信息 -->
<!-- <form action="" id="form_enrollment">
</form> -->
<table class="table table-condensed" style="width: 840px;">
    <tr>
    	<th><input type="checkbox" id="allStuIdCheck">全选</th>
    	<th>姓名</th><th>学号</th><th>班级</th><th>入园时间</th>
    	<th>缴费状态<br><input type="checkbox" id="allPaidCheck">已缴费(全选)</th>
    </tr>
    <c:forEach items="${stuList }" var="stu">
    	<tr>
    		<td><input type="checkbox" name="stuId" class="stuId" value="${stu.baby_id }"></td>
    		<td>${stu.baby_name }</td>
    		<td>${stu.baby_no }</td>
    		<td>${stu.class_name }</td>
    		<td>${stu.enter_date }</td>
    		<td><input type="checkbox" name="paid" class="paid"></td>
    	</tr>
    </c:forEach>
   	<tr>
		<td colspan="7" style="text-align:center;">
			<input type="button" class="btn btn-primary" value="升学报名" id="enrollmentBtn">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn btn-primary" value="毕业离校" id="graduationBtn">
		</td>
	</tr>
</table>
</body>
</html>