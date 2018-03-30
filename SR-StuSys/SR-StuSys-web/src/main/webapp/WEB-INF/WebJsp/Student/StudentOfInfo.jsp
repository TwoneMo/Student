<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form id="forminfo" name="self" method="post" >
	<div class="form-group">
    <label for="stusid">学号</label>
    <input type="text" class="form-control" id="stusid" name="sid" value="${stu.sid }"  readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="stusname">姓名</label>
    <input type="text" class="form-control" id="stusname" name="sname" value="${stu.sname }"  readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="stuclassid">班级</label>
    <input type="text" class="form-control" id="stuclassid"  value="${stu.myclass.classname }"  readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="stusex">性别</label>
	<c:if test="${stu.sex=='male' }">
		<input type="text" class="form-control" id="stusex"  value="男"  readonly="readonly" style="width: 200px;color: black;color: black;">
	</c:if>
	<c:if test="${stu.sex=='female' }">
		<input type="text" class="form-control" id="stusex"  value="女"  readonly="readonly" style="width: 200px;color: black;color: black;">
	</c:if>
  	</div>
  	<div class="form-group">
    <label for="stuaddress">住址</label>
    <input type="text" class="form-control" id="stuaddress" name="address" value="${stu.address }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="stuemail">e-mail</label>
    <input type="text" class="form-control" id="stuemail" name="email" value="${stu.email }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="stuidentityCard">身份证</label>
    <input type="text" class="form-control" id="stuidentityCard" name="identityCard" value="${stu.identityCard }" readonly="readonly" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="stubirthday">出生日期</label>
    <input type="text" class="form-control" id="stubirthday" name="birthday" value="${stu.birthday }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<div class="form-group">
    <label for="stuphone">移动手机</label>
    <input type="text" class="form-control" id="stuphone" name="phone" value="${stu.phone }" readonly="readonly" style="width: 200px;color: black;">
  	</div>
  	<br />
	</form>

</body>
</html>