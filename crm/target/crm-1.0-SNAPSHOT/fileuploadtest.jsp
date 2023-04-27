<%--
  Created by IntelliJ IDEA.
  User: yyy
  Date: 2023/1/8
  Time: 21:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>演示文件上传</title>
</head>
<body>
<%--
    文件上传的表单三个条件:
       1.表单组件标签只能用:<input type='file'>
       2.请求方式只能用 post
       3.表单的编码格式只能用 multipart/form-data
--%>
<form action="workbench/activity/fileUpload" enctype="multipart/form-data" method="post">
    <input type="file" name="myFile"/><br/>
    <input type="text" name="userName"/><br/>
    <input type="submit" value="上传"><br/>
</form>
</body>
</html>
