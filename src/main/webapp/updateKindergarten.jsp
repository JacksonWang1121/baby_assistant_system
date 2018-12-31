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
	
	$.ajax({
		url:"${pageContext.request.contextPath }/kindergarten/findKindergarten",
		type:"post",
		dataType:"json",
		success:function(data, status) {
			console.log("success-data = "+data);
			if (data == null) {
				alert("读取失败");
			} else {
				$("#name").val(data.name);
				$("#registeredDate").val(data.registeredDate);
				$("#description").val(data.description);
				$("#telephone").val(data.telephone);
				//address
				console.log(data.address);
				if (data.address!="" || data.address!=null) {
					var ads = data.address.split(",");
					if (ads[0]!="" || ads!=null || typeof(ads[0])!="undefined") {
						$("#province").html('<option value="">'+ads[0]+'</option>');
					}
					if (ads[0]!="" || ads!=null || typeof(ads[0])!="undefined") {
						$("#city").html('<option value="">'+ads[1]+'</option>');
					}
					if (ads[0]!="" || ads!=null || typeof(ads[0])!="undefined") {
						$("#area").html('<option value="">'+ads[2]+'</option>');
					}
					if (ads[0]!="" || ads!=null || typeof(ads[0])!="undefined") {
						$("#street").val(ads[3]);
					}
				}
				if (data.picture != null) {
					$("#photo").after('<img width="100px" alt="该图片不存在" src="'+data.picture+'">');
				}
			}
		},
		error:function(data, status, e) {
			console.log("error = "+e);
			alert("读取失败");
		}
	});
	
	/* 省份下拉框 */
	$("#province").bind('focus',function() {
    	$.ajax({
			url:"${pageContext.request.contextPath }/kindergarten/listProvince",
			type:"post",
			dataType:"json",
			success:function(data, status) {
				console.log("success-data = "+data);
				//清空下拉框
				$("#province").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
				for(var i in data) {
					//下拉框重新赋值
					$("#province").append('<option value="'+data[i].provinceID+'">'+data[i].province+'</option>');
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
			}
		});
	});
	
	/* 城市下拉框 */
	$("#city").bind('focus',function() {
		//获取省份
		var province = $("#province").val();
		//若省份为空，则提示先选择省份
		if (province==null || province=="") {
			alert("请先选择省份");
			$("#city").blur();
			return;
		} else {
	    	$.ajax({
				url:"${pageContext.request.contextPath }/kindergarten/listCity",
				type:"post",
				data:{"provinceId":province},
				dataType:"json",
				success:function(data, status) {
					console.log("success-data = "+data);
					//清空下拉框
					$("#city").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
					for(var i in data) {
						//下拉框重新赋值
						$("#city").append('<option value="'+data[i].cityID+'">'+data[i].city+'</option>');
					}
				},
				error:function(data, status, e) {
					console.log("error = "+e);
				}
			});
		}
	});
	
	/* 县区下拉框 */
	$("#area").bind('focus',function() {
		//获取城市
		var city = $("#city").val();
		//若省份为空，则提示先选择省份
		if (city==null || province=="") {
			alert("请先选择城市");
			$("#area").blur();
			return;
		} else {
	    	$.ajax({
				url:"${pageContext.request.contextPath }/kindergarten/listArea",
				type:"post",
				data:{"cityId":city},
				dataType:"json",
				success:function(data, status) {
					console.log("success-data = "+data);
					//清空下拉框
					$("#area").html('<option value="">--&nbsp;请选择&nbsp;--</option>');
					for(var i in data) {
						//下拉框重新赋值
						$("#area").append('<option value="'+data[i].areaID+'">'+data[i].area+'</option>');
					}
				},
				error:function(data, status, e) {
					console.log("error = "+e);
				}
			});
		}
	});
	
	/* 修改幼儿园信息 */
	$("#updateKindergartenBtn").bind('click',function() {
		//获取幼儿园名称
		var name = $("#name").val().trim();
		//name不能为空
		if (name=="" || name==null) {
			alert("请输入幼儿园名称");
			return;
		}
		//获取幼儿园的咨询电话
		var telephone = $("#telephone").val().trim();
		//telephone不能为空
		if (telephone=="" || telephone==null) {
			alert("请输入咨询电话");
			return;
		}
		//获取幼儿园所在省份
		var province = $("#province").val();
		//province不能为空
		if (province=="" || province==null) {
			alert("请选择省份");
			return;
		}
		//获取幼儿园所在城市
		var city = $("#city").val();
		//city不能为空
		if (city=="" || city==null) {
			alert("请选择城市");
			return;
		}
		//获取幼儿园所在县区
		var area = $("#area").val();
		//area不能为空
		if (area=="" || area==null) {
			alert("请选择县区");
			return;
		}

		//获取表单内容
		var formData = new FormData();
		formData.append("name", $("#name").val());
		formData.append("description", $("#description").val());
		formData.append("telephone", $("#telephone").val());
		formData.append("province", $('option[value="'+$("#province").val()+'"]').html());
		formData.append("city", $('option[value="'+$("#city").val()+'"]').html());
		formData.append("area", $('option[value="'+$("#area").val()+'"]').html());
		formData.append("street", $("#street").val());
		formData.append("photo", $("#photo")[0].files[0]);
    	$.ajax({
			url:"${pageContext.request.contextPath }/kindergarten/updateKindergarten",
			type:"post",
			data:formData,
			dataType:"text",
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success:function(data, status) {
				console.log("success-data = "+data);
				if (data == "true") {
					alert("修改成功");
					window.location.href = "updateKindergarten.jsp";
				} else {
					alert("修改失败");
				}
			},
			error:function(data, status, e) {
				console.log("error = "+e);
				alert("修改失败");
			}
		});
	});
	
});

/* 检查上传文件的格式 */
function checkFile(file) {
    var fileName = $(file).val();
    //var fileName = value.substring(value.lastIndexOf(".")).toLowerCase();
    console.log("fileName = "+fileName);
	if (fileName.search(".png")!=-1 && fileName.search(".jpg")!=-1 && 
			fileName.search(".jpeg")!=-1 && fileName.search(".gif")!=-1) {
        //清空输入框
        $(file).val("");
        //清除输入框后面的文件，即删除img元素
        var element = $(file).nextAll("img");
		console.log("checkFile-element_length = "+element.length);
		if (element.length > 0) {
	    	element.eq(0).remove();
			console.log("checkFile-element is removed.");
		}
        alert("上传图片格式不正确，请重新上传");
    }
}

/* 显示文件 */
function showFile(file) {
	//清除输入框后面的文件，即删除img元素
    var element = $(file).nextAll("img");
	console.log("showFile-element_length = "+element.length);
	if (element.length > 0) {
    	element.eq(0).remove();
		console.log("showFile-element is removed.");
	}
	//获取上传文件
	var files = $(file)[0].files;
	console.log("showFile-files_length = "+files.length);
	if (files.length > 0) {
		//获取上传文件的绝对路径
	    var url = getObjectURL($(file)[0].files[0]);
		$(file).after('<img width="100px" alt="该图片不存在" src="'+url+'">');
	}
}

/* 获取上传文件的绝对路径 */
function getObjectURL(file) {
    var url = null ;
    if (window.createObjectURL!=undefined) { // basic
        url = window.createObjectURL(file) ;
    } else if (window.URL!=undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file) ;
    } else if (window.webkitURL!=undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file) ;
    }
    console.log("website_update::getObjectURL-url = "+url);
    return url ;
}
</script>
</head>
<body>
<!-- 幼儿园信息修改 -->
<form id="form_kindergarten_update" action="" method="post">
<table class="table">
	<tr>
		<th><label>园名</label></th>
		<td><input type="text" name="name" id="name"/></td>
	</tr>
	<tr>
		<th><label>注册时间</label></th>
		<td><input type="text" id="registeredDate" disabled="disabled"/></td>
	</tr>
	<tr>
		<th><label>描述</label></th>
		<td><textarea rows="5" cols="50" name="description" id="description"></textarea></td>
	</tr>
	<tr>
		<th><label>电话</label></th>
		<td><input type="text" name="telephone" id="telephone"/></td>
	</tr>
	<tr>
		<th><label>地址</label></th>
		<td>
			<select id="province" name="province">
				<option value="">--&nbsp;请选择&nbsp;--</option>
			</select>
			<span>省</span>
			<select id="city" name="city">
				<option value="">--&nbsp;请选择&nbsp;--</option>
			</select>
			<span>市</span>
			<select id="area" name="area">
				<option value="">--&nbsp;请选择&nbsp;--</option>
			</select>
			<span>县(区)</span>
		</td>
	</tr>
	<tr>
		<th></th>
		<td><textarea rows="3" cols="50" name="street" id="street"></textarea></td>
	</tr>
	<tr>
		<th><label>图片</label></th>
		<td><input type="file" name="photo" onchange="checkFile(this);showFile(this)" id="photo" accept="image/*"></td>
	</tr>
	<tr>
		<td colspan="6" style="text-align:center;">
			<input type="button" class="btn btn-primary" value="修改" id="updateKindergartenBtn">
		</td>
	</tr>
</table>
</form>
</body>
</html>