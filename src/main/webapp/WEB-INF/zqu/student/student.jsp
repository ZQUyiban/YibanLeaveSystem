<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<
<html>
<head>
	<link href="<%=request.getContextPath()%>resources/css/bootstrap.min.css" rel="stylesheet">
	
    <script src="<%=request.getContextPath()%>resources/js/bootstrap.min.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="utf-8">
	<title>肇院请假系统</title>
	<style>
		*{
			font-family:"Helvetica Neue" "Microsoft YaHei";
			padding:0;margin:0;
			-webkit-box-sizing: border-box;
			-moz-box-sizing: border-box;
		   box-sizing: border-box;	
		}
		.header{
			color:#000;
			height:300px;
			overflow:hidden;
		}
		.index-body{
			padding:0 3px 0 1px;
		}
		.footer{
			padding:15px;
			border-radius:5px;
			font-size:12px;
			background-color:#6A5ACD;
			color:#fff;
			text-align:center;
		}
		form div{
			margin:13px auto;
		}
		.input-group{margin:0;}
		h1,h2,h3,h4{ text-align:center;}
		.submit-btn{
			width:100%;
			height:40px;
			background-color:#FFA500;
			border:none;
			border-radius:6px;
			color:#fff;
		}
		.blur-bg{
			background:url(../resources/picture/bg.jpg) no-repeat;
			background-position:center;
			background-size:100% 100%;
			z-index:-1;
			position:absolute;
			right:0;
			left:0;
			top:0;
			width:100%;
			height:300px;
			-webkit-filter:blur(7px);
			-moz-filter:blur(7px);
			-ms-filter:blur(7px);
			filter:blur(7px);
		}
		.time input{ width:100%;height:32px;}
		.userid{text-align:center;margin:45px auto;}
	</style>
</head>
<body class="container-fluid">
<div class="row">
<div class="index-body col-md-8 col-md-offset-2" >
	<div class="header container-fluid"> 
		<div class="blur-bg"></div>
		<div class="userid row"><div class="col-md-12"><img src="<%=request.getContextPath()%>/resources/picture/touxiang.jpg" style="border-radius:50%;width:110px;height:110px"></div>
		<div class="col-md-12"><h1>肇庆学院</h1> <h4>郑伟森 (id:123123)</h4></div>
		</div>	
	</div>
	
	<div class="index-form form container-fluid" >
		<h3> 请假登记 </h3>
		<form id="test" action="#" method="post">
			<div class="row">  
				<div class="col-md-4"><div class="input-group"><span class="input-group-addon">姓名:</span> <input name="name" type="text" class="form-control" placeholder="输入你的姓名"></div></div>
				<div class="col-md-4"><div class="input-group"><span class="input-group-addon">学号:</span> <input name="id" type="text" class="form-control" placeholder="输入你的学号"></div></div>
				<div class="col-md-4"><div class="input-group"><span class="input-group-addon">手机号码:</span> <input name="tel" type="text" class="form-control" id="phone" placeholder="输入手机号码" tip="请输入手机号码" ></div></div>
				

			</div>
			<div class="row">
			<div class="col-md-6 "><select class="form-control"><option value="1">计算机科学与软件学院、大数据学院</option></select></div>	
			<div class="col-md-6"><select class="form-control"><option>软件1班</option></select></div>
			</div>
			
			<div class="row">
				 
					<div class="col-md-6 time"><p>请假时间</p><input type="date" name="starttime"></div>
					<div class="col-md-6 time"><p>结束时间</p><input type="date" name="endtime"></div>
			</div>
			
			<p>请假原因</p>
			<textarea class="form-control" rows="5" name="text1" placeholder="输入请假原因"></textarea>
			<div class="row"><div class="col-md-3 col-md-offset-9"><button type="submit" class="submit-btn" >提交申请</button></div></div>
		</form>
		</div>
	</div>
	</div>
	<hr />
	<div class="footer"> 
	<div class="foot-text">易班学生工作站</div>
	<div class="foot-copyright">Copyright© 2017 ZQU E-Class</div>
	</div>

<script src="<%=request.getContextPath()%>js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>js/jquery.validate.js"></script>



>
<script type="text/javascript">
	
     jQuery.validator.addMethod("phone", function(value, element) {  
    var length = value.length;  
    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;  
    return this.optional(element) || (length == 11 && mobile.test(value));  
   }, "输入正确的手机号码"); 

     
	$(function(){
		
		$("#test").validate({
		debug:true,//调试模式，即使验证成功也不会跳转到目标页面
		
		rules:
		{
			name:
			{
				required:true
				
			},
			id:
			{
				required:true,
				number:true,
				length:12
			},
			text1:
			{
				required:true,
				minlength:5,
				maxlength:100
			},
		tel:
			{
				required:true,
				minlength:11,
				phone:true
				
			}
			
		},
		messages:{
			name:
			{
				required:"请输入姓名"
				
			},
			id:
			{
				required:"请输入正确的学号"
				
			},
			
			text1:
			{
				required:"请填写请假原因",
				minlength:"最少不要低于5个字",
				maxlength:"最多不要多于100个字"
				
			},
			
			tel:
			{
				phone:"请填写正确的手机号码"
				
			}
			
			
		}
		
	});
	});
</script>
</body>
</html>