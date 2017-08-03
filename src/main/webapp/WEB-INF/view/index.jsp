<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
    <link rel="stylesheet" href="/css/lib/bootstrap.min.css">
    <script src="/js/lib/jquery-3.1.1.min.js"></script>
    <script src="/js/lib/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/css/index.css">
    <script>

        jQuery(document).ready(function($) {
            $(".scroll").click(function(event){
                event.preventDefault();
                $('html,body').animate({scrollTop:$(this.hash).offset().top},1200);
            });
        });
    </script>
</head>
<body class="main">
<br/><br/><br/><br/><br/><br/>
<div class="container grad">
    <div class="row" >
        <div class="col-xs-4 col-md-offset-4">
            <form class="form-horizontal" role="form" id="loginForm">
                <div class="form-group">
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="nick" placeholder="请输入昵称">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="pwd" placeholder="请输入密码">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-0 col-sm-10">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="rem" value="true"> 记住我
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-0 col-sm-10">
                        <button type="button" class="btn btn-default" style="width:100%" onclick="login();">进入</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <br/><br/><br/><br/><br/>
</div>

<script>
    function checkUser(){
        var nick = document.getElementsByName("nick")[0].value;
        var password = document.getElementsByName("pwd")[0].value;
        if(nick == ""  ){
            alert("用户名不能为空");
            return false;
        }
        if(password == ""  ){
            alert("密码不能为空");
            return false;
        }else{
            return true;
        }
    }
    function  login() {
        var form=document.forms[0];
        form.action = "${pageContext.request.contextPath}/user/login";
        form.method = "post";
        if(checkUser()){
            form.submit();
        }
        else
            return false;
    }
</script>
</body>
</html>
