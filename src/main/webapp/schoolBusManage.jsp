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
	/* 添加校车记录按钮的单击触发事件 */
	$("#saveSchoolBusBtn").bind('click',function() {
		//获取校车名称
		var busName = $("#busName").val().trim();
		//busName不能为空
		if (busName=="" || busName==null) {
			alert("请输入校车名称");
			return;
		}
		//获取校车车牌号码
		var busPlate = $("#busPlate").val().trim();
		//busPlate不能为空
		if (busPlate=="" || busPlate==null) {
			alert("请输入校车车牌号码");
			return;
		}
		//判断校车车牌号码的格式
		if (!busPlate.test("/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/")) {
			alert("请输入正确的车牌号码");
			return;
		}
		//获取司机姓名
		var driver = $("#driver").val().trim();
		//driver不能为空
		if (driver=="" || driver==null) {
			alert("请输入司机姓名");
			return;
		}
		//获取联系电话
		var driverTel = $("#driverTel").val().trim();
		if (driverTel=="" || driverTel==null) {
			alert("请输入司机的联系电话");
			return;
		}
		//判断联系电话格式
		if (driverTel.test("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$")) {
			alert("请输入正确的联系电话");
			return;
		}

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