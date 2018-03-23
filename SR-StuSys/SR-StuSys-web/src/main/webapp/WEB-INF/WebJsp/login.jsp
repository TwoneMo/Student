<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Bootstrap -->
<link href="${pageContext.request.contextPath}/static/assets/css/vendor/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/assets/css/font-awesome.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/assets/css/vendor/bootstrap-checkbox.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/assets/css/minimal.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/assets/css/font-awesome.min.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css">
<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/DataTables-1.10.15/media/css/jquery.dataTables.css">
<!-- jQuery -->
<script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/static/DataTables-1.10.15/media/js/jquery.js"></script>
<!-- DataTables -->
<script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/static/DataTables-1.10.15/media/js/jquery.dataTables.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootbox.min.js"></script>



</head>

<script type="text/javascript">
	$(document).ready(function(){
		$("#caa").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/users/toCreateAccount.do",
				type:"post",
				dataType:"text",
				success:function(result){
					bootbox.dialog({
						title:"用户注册",
					    message:result
					});
				}
			})
		})
	});
</script>

<body class="bg-1">
    <!-- Wrap all page content here -->
    <div id="wrap">
      <!-- Make page fluid -->
      <div class="row">
        <!-- Page content -->
        <div id="content" class="col-md-12 full-page login">
          <div class="inside-block">
            <img src="${pageContext.request.contextPath }/static/assets/images/logo-big.png" alt class="logo">
            <h1><strong>Welcome</strong> Stranger</h1>
            <h5>Zhejiang Shuren University</h5>
            <form id="form-signin" class="form-signin" name="login" action="${pageContext.request.contextPath }/users/dologin.do" method="post">
              <section>
                <div class="input-group">
                  <input type="text" class="form-control" name="username" placeholder="Username">
                  <div class="input-group-addon"><i class="fa fa-user"></i></div>
                </div>
                <div class="input-group">
                  <input type="password" class="form-control" name="password" placeholder="Password">
                  <div class="input-group-addon"><i class="fa fa-key"></i></div>
                </div>
              </section>
              <section class="controls">
                <div class="checkbox check-transparent">
                  <input type="checkbox" value="1" id="remember" checked>
                  <label for="remember" style="font-size: 22px">Remember me</label>
                </div>
                <a href="#">Forget password?</a>
              </section>
              <section class="log-in">
                <button class="btn btn-greensea" type="submit">Log In</button>
                <span>or</span>
                <button class="btn btn-slategray" id="caa" type="button">Create an account</button>
              </section>
            </form>
          </div>
        </div>
        <!-- /Page content -->  
      </div>
    </div>
    <!-- Wrap all page content end -->
  </body>
</html>