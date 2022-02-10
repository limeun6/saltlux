<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="http://127.0.0.1:5000/test1" method="post" enctype="multipart/form-data">
데이터<input type="text" name="data"><p>
파일<input type="file" name="file"><p>
<input type="submit" value="요청">
<input type="reset" value="취소">

</form>
</body>
</html>