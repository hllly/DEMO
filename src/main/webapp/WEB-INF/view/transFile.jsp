<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>上传图片</title>
</head>
<body>
<h>上传</h>
<form name="userForm" action="/file/upload2" method="post" enctype="multipart/form-data">
    选择文件：<input type="file" name="filename">
            <input type="submit" value="提交">
    </form>
</body>
</html>
