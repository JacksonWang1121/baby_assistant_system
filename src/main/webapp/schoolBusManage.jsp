<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>校车管理</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	/* 添加学生记录中的班级下拉框 */
	$("#saveSchoolBusBtn").bind('click',function() {
		//获取表单内容
		var formData = $("#form_schoolbus_save").serialize();
    	$.ajax({
			url:"${pageContext.request.contextPath }/schoolBus/saveSchoolBus",
			type:"post",
			data:formData,
			dataType:"text",
			success:function(data, status) {
				console.log("schoolBusManage::success-data = "+data);
				if (data == "true") {
					alert("保存成功");
					window.location.href = "${pageContext.request.contextPath }/schoolBus/listSchoolBusToPage";
				} else {
					alert("保存失败");
				}
			},
			error:function(data, status, e) {
				console.log("schoolBusManage::error-e = "+e);
				alert("保存失败");
			}
		});
	});
	
});
</script>
</head>
<body>
<!-- 查询该幼儿园所有校车的信息 -->
<table id="listSchoolBus" class="table table-condensed" style="width: 840px;">
    <tr><th>编号</th><th>名称</th><th>司机</th><th>联系电话</th><th>车牌号</th><th>状态</th><th>操作</th></tr>
    <c:forEach items="${schoolBusList }" var="bus">
    	<tr>
    		<td>${bus.id }</td>
    		<td>${bus.busName }</td>
    		<td>${bus.driver }</td>
    		<td>${bus.driverTel }</td>
    		<td>${bus.busPlate }</td>
    		<td>${bus.busStatus }</td>
    		<td>
    			<a href="javascript:">编辑</a>&nbsp;|&nbsp;
	    		<a href="javascript:">删除</a>
    		</td>
    	</tr>
    </c:forEach>
</table>

<!-- 校车信息添加 -->
<h2>校车信息添加</h2>
<form id="form_schoolbus_save" action="" method="post">
<table class="table">
	<tr>
		<th><label>名称</label></th>
		<td><input type="text" name="busName"/></td>
		<th><label>车牌号码</label></th>
		<td><input type="text" name="busPlate"/></td>
	</tr>
	<tr>
		<th><label>司机</label></th>
		<td><input type="text" name="driver"/></td>
		<th><label>联系电话</label></th>
		<td><input type="text" name="driverTel"/></td>
	</tr>
	<tr>
		<th><label for="payStatus">状态</label></th>
		<td>
			<input type="radio" name="busStatus" value="可用" checked="checked"/>可用
			<input type="radio" name="busStatus" value="不可用"/>不可用
		</td>
	</tr>
	<tr>
		<td colspan="6" style="text-align:center;">
			<input type="button" class="btn btn-primary" value="保存" id="saveSchoolBusBtn">
		</td>
	</tr>
</table>
</form>
</body>
</html>