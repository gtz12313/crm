<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":"
			+ request.getServerPort()
			+ request.getContextPath() + "/";
%>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		$(function () {
			//键盘按下事件
			$(window).keydown(function (data) {
				if(data.keyCode == 13){ //回车触发
					$("#loginBtn").click();
				}
			});

			$("#loginBtn").click(function (){
				var loginAct = $.trim($("#loginAct").val());
				var pwd = $.trim($("#pwd").val())
				var isRemPwd = $("#isRemPwd").prop("checked");
				if (loginAct == "" || pwd == ""){
					$("#msg").text("用户名或密码为空")
					return false;
				}
				$.ajax({
					url:"settings/qx/user/login",
					data:{
						loginAct:loginAct,
						pwd:pwd,
						isRemPwd:isRemPwd
					},
					type:"post",
					dataType:"json",
					success:function (data) {
						if (data.code == "1"){
							$("#msg").text("");
							window.location.href = "workbench/index"
						}else {
							$("#msg").html(data.msg);
						}
					},
					beforeSend:function (){//当ajax向后台发送请求之前,执行
						//该函数的返回值 能够决定 ajax是否真正向后台发送请求
						//如果函数返回 true,则ajax会真正向后台发送请求
						$("#msg").text("正在验证中,请稍后...");
						return true;
					}
				});
			});
		});
	</script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;"/>
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2019&nbsp;动力节点</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="/settings/qx/user/login" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" id="loginAct" name="loginAct" value="${cookie.loginAct.value}" placeholder="用户名">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" id="pwd" name="pwd" value="${cookie.loginPwd.value}" placeholder="密码">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						<label>
							<c:if test="${empty cookie.loginAct or empty cookie.loginPwd}">
								<input type="checkbox" id="isRemPwd">
							</c:if>
							<c:if test="${not empty cookie.loginAct and not empty cookie.loginPwd}">
								<input type="checkbox" id="isRemPwd" checked="checked">
							</c:if>
							十天内免登录
						</label>
						&nbsp;&nbsp;
						<span id="msg" style="color: red"></span>
					</div>
					<button type="button" id="loginBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>