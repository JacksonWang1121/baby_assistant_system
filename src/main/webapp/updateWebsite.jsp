<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=request.getContextPath()+"/" %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改微官网</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	/* 每次访问该页面时，查询是否已存在该幼儿园的微官网 */
	$.ajax({
		url: "${pageContext.request.contextPath }/website/findWebsite",
		type: "GET",
		dataType: "json",
		success: function(data,status) {
			// 根据返回结果指定界面操作
			console.log("website_update::findWebsite:success-data = "+data);
			//若有数据返回，则显示在对应的文本框中，否则提示微官网不存在
			if (data==null || data=="") {
				alert("微官网不存在");
				//禁用修改按钮
				$("#updateWebsiteBtn").attr("disabled","disabled");
			} else {
				//json格式字符串转为json对象
				//var data = $.parseJSON(result);
				$("#schoolIntro").val(data.schoolIntro);
				if (data.schoolIntroPicture != null) {
					//$("#schoolIntroPicture").val(data.schoolIntroPicture);
					$("#schoolIntroPicture").after('<img width="100px" alt="该图片不存在" src="'+data.schoolIntroPicture+'">');
				}
				$("#certificateName1").val(data.certificateName1);
				if (data.certificatePicture1 != null) {
					//$("#certificatePicture1").val(data.certificatePicture1);
					$("#certificatePicture1").after('<img width="100px" alt="该图片不存在" src="'+data.certificatePicture1+'">');
				}
				$("#certificateName2").val(data.certificateName2);
				if (data.certificatePicture2 != null) {
					//$("#certificatePicture2").val(data.certificatePicture2);
					$("#certificatePicture2").after('<img width="100px" alt="该图片不存在" src="'+data.certificatePicture2+'">');
				}
				$("#certificateName3").val(data.certificateName3);
				if (data.certificatePicture3 != null) {
					//$("#certificatePicture3").val(data.certificatePicture3);
					$("#certificatePicture3").after('<img width="100px" alt="该图片不存在" src="'+data.certificatePicture3+'">');
				}
				$("#teacherIntro1").val(data.teacherIntro1);
				if (data.teacherPicture1 != null) {
					//$("#teacherPicture1").val(data.teacherPicture1);
					$("#teacherPicture1").after('<img width="100px" alt="该图片不存在" src="'+data.teacherPicture1+'">');
				}
				$("#teacherIntro2").val(data.teacherIntro2);
				if (data.teacherPicture2 != null) {
					//$("#teacherPicture2").val(data.teacherPicture2);
					$("#teacherPicture2").after('<img width="100px" alt="该图片不存在" src="'+data.teacherPicture2+'">');
				}
				$("#teacherIntro3").val(data.teacherIntro3);
				if (data.teacherPicture3 != null) {
					//$("#teacherPicture3").val(data.teacherPicture3);
					$("#teacherPicture3").after('<img width="100px" alt="该图片不存在" src="'+data.teacherPicture3+'">');
				}
				if (data.stuWorks != null) {
					//$("#stuWorks").val(data.stuWorks);
					var works = data.stuWorks.split(";");
					console.log("website_update::findWebsite-works_length = "+works.length);
					for(var i=0; i<works.length; i++) {
						$("#stuWorks").after('<img width="100px" alt="该图片不存在" src="'+works[i]+'">');
					}
				}
			}
		},
		error: function(data,status,e) {
			console.log("website_update::findWebsite:error = "+e);
			alert("读取失败");
			//禁用修改按钮
			$("#updateWebsiteBtn").attr("disabled","disabled");
		}
	});
	
	/* 点击保存按钮 */
	$("#updateWebsiteBtn").click(function() {
		//用FormData对象来发送二进制文件
		//FormData构造函数提供的append()方法，除了直接添加二进制文件还可以附带一些其它的参数，作为XMLHttpRequest实例的参数提交给服务端
		var formData = new FormData($("form_website_update"));
		formData.append("schoolIntro", $("#schoolIntro").val());
		formData.append("schoolIntroPicture", $("#schoolIntroPicture")[0].files[0]);
		formData.append("certificateName1", $("#certificateName1").val());
		formData.append("certificatePicture1", $("#certificatePicture1")[0].files[0]);
		formData.append("certificateName2", $("#certificateName2").val());
		formData.append("certificatePicture2", $("#certificatePicture2")[0].files[0]);
		formData.append("certificateName3", $("#certificateName3").val());
		formData.append("certificatePicture3", $("#certificatePicture3")[0].files[0]);
		formData.append("teacherIntro1", $("#teacherIntro1").val());
		formData.append("teacherPicture1", $("#teacherPicture1")[0].files[0]);
		formData.append("teacherIntro2", $("#teacherIntro2").val());
		formData.append("teacherPicture2", $("#teacherPicture2")[0].files[0]);
		formData.append("teacherIntro3", $("#teacherIntro3").val());
		formData.append("teacherPicture3", $("#teacherPicture3")[0].files[0]);
		for(var i=0; i<$('#stuWorks')[0].files.length; i++) {
			formData.append('stuWorks', $('#stuWorks')[0].files[i]);
		}
		//console.log("website_update::fromData = "+formData);
		$.ajax({
			url: "${pageContext.request.contextPath }/website/updateWebsite",
			type: "POST",
			data: formData,
			dataType: "text",
			async: true,         //同步或异步请求方式，默认为true，异步
			cache: false,
			processData: false,  //不要对data参数进行序列化处理，默认为true
			contentType: false,  //不要设置Content-Type请求头，因为文件数据是以 multipart/form-data来编码
			success: function(data,status) {
				// 根据返回结果指定界面操作
				console.log("website_update::updateWebsite:success-data = "+data);
				alert("修改成功");
			},
			error: function(data,status,e) {
				console.log("website_update::updateWebsite:error-data = "+data);
				alert("修改失败");
			}
		});
	});
});

/* 检查上传文件的格式 */
function checkFile(file) {
    var value = $(file).val();
    var fileName = value.substring(value.lastIndexOf(".") + 1).toLowerCase();
	if (fileName !== "png" && fileName !== "jpg" && fileName !== "jpeg" && fileName !== "gif") {
        //清空输入框
        $(file).val("");
        //清除输入框后面的文件，即删除img元素
        var element = $(file).nextAll("img");
		console.log("website_update::checkFile-element_length = "+element.length);
		if (element.length > 0) {
			for (var i = 0; i < element.length; i++) {
		    	element.eq(i).remove();
				console.log("website_update::checkFile-element("+i+") is removed.");
			}
		}
        alert("上传图片格式不正确，请重新上传");
    }
}

/* 显示文件 */
function showFile(file) {
	//清除输入框后面的文件，即删除img元素
    var element = $(file).nextAll("img");
	console.log("website_update::showFile-element_length = "+element.length);
	if (element.length > 0) {
		for (var i = 0; i < element.length; i++) {
	    	element.eq(i).remove();
			console.log("website_update::showFile-element("+i+") is removed.");
		}
	}
	//获取上传文件
	var files = $(file)[0].files;
	console.log("website_update::showFile-files_length = "+files.length);
	if (files.length > 0) {
		for (var i = 0; i < files.length; i++) {
			//获取上传文件的绝对路径
		    var url = getObjectURL($(file)[0].files[i]);
			$(file).after('<img width="100px" alt="该图片不存在" src="'+url+'">');
		}
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
<form id="form_website_update">
<table class="table" style="width: 910px;margin: 0 auto;margin-top: 20px;">
	<tr><td colspan="4"><h3>校园简介</h3></td></tr>
	<tr>
		<th>描述</th>
		<td><textarea rows="3" cols="36" name="schoolIntro" id="schoolIntro"></textarea></td>
		<th>图片</th>
		<td><input type="file" name="schoolIntroPicture" value="aaaaaaaa" onchange="checkFile(this);showFile(this)" id="schoolIntroPicture" accept="image/*"></td>
	</tr>
	<tr><td colspan="4"><h3>资质证书</h3></td></tr>
	<tr>
		<th>证书名称</th>
		<td><input type="text" name="certificateName1" id="certificateName1"></td>
		<th>扫描件</th>
		<td><input type="file" name="certificatePicture1" onchange="checkFile(this);showFile(this)" id="certificatePicture1" accept="image/*"></td>
	</tr>
	<tr>
		<th>证书名称</th>
		<td><input type="text" name="certificateName2" id="certificateName2"></td>
		<th>扫描件</th>
		<td><input type="file" name="certificatePicture2" onchange="checkFile(this);showFile(this)" id="certificatePicture2" accept="image/*"></td>
	</tr>
	<tr>
		<th>证书名称</th>
		<td><input type="text" name="certificateName3" id="certificateName3"></td>
		<th>扫描件</th>
		<td><input type="file" name="certificatePicture3" onchange="checkFile(this);showFile(this)" id="certificatePicture3" accept="image/*"></td>
	</tr>
	<tr><td colspan="4"><h3>教师风采</h3></td></tr>
	<tr>
		<th>教师简介</th>
		<td><textarea rows="3" cols="36" name="teacherIntro1" id="teacherIntro1"></textarea></td>
		<th>扫描件</th>
		<td><input type="file" name="teacherPicture1" onchange="checkFile(this);showFile(this)" id="teacherPicture1" accept="image/*"></td>
	</tr>
	<tr>
		<th>教师简介</th>
		<td><textarea rows="3" cols="36" name="teacherIntro2" id="teacherIntro2"></textarea></td>
		<th>扫描件</th>
		<td><input type="file" name="teacherPicture2" onchange="checkFile(this);showFile(this)" id="teacherPicture2" accept="image/*"></td>
	</tr>
	<tr>
		<th>教师简介</th>
		<td><textarea rows="3" cols="36" name="teacherIntro3" id="teacherIntro3"></textarea></td>
		<th>扫描件</th>
		<td><input type="file" name="teacherPicture3" onchange="checkFile(this);showFile(this)" id="teacherPicture3" accept="image/*"></td>
	</tr>
	<tr><td colspan="4"><h3>学生作品</h3></td></tr>
	<tr>
		<td colspan="4"><input type="file" name="stuWorks" onchange="checkFile(this);showFile(this)" id="stuWorks" multiple="multiple" accept="image/*"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" class="btn btn-primary" value="修改" id="updateWebsiteBtn">
		</td>
	</tr>
</table>
</form>
</body>
</html>