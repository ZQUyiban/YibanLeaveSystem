<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head>
		<meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link rel="stylesheet" href="<%=request.getContextPath()%>resource/css/layui.css" media="all">
		<link rel="stylesheet" href="<%=request.getContextPath()%>resourcecss/css/layer.css" media="all">
		<link rel="stylesheet" href="<%=request.getContextPath()%>resourcecss/css/style.css"/>

		<style>
			body{
				margin:10px;
				
			}
			.demo-carousel{
				height: 200px;
				line-height: 200px;
				text-align: center;
			}
			#suo
			{
				width: 200px;
				height: 35px;
				
				margin: 10px;
			}
		</style>
		<title></title>
	</head>
	<body>
		<h1 style="font-size: 2em;text-align: center;">管理员登录系统</h1>
		<br />
		<hr class="layui-bg-green" ><br /><br />
		<div class="layui-container ">
	
			
		<div class="layui-form" action="">
		<div class="layui-form-item">
		<div class="layui-row">
		
		
		<input type="text" name="key" placeholder="请输入搜索的关键字" style="margin: 10px;"  autocomplete="off" id="suo">
           <button class="layui-btn" lay-submit style="height: 38px;">搜索</button>
       
		</div>       
			</div>		
		<table class="layui-table" lay-data="{height:332,,page:true}" lay-filter="demo" lay-even width="1360" height="2000">
			<thead>
				<tr>
			
					<th lay-data="{field:'id' ,sort: true, fixed: true, width:150}">学号</th>
					<th lay-data="{field:'name' ,width:150}">姓名</th>
					<th lay-data="{field:'xueyuan' ,width:200}">学院</th>
					<th lay-data="{field:'zhuanye' ,width:150}">专业</th>
					<th lay-data="{field:'starttime' ,width:150}">请假开始时间</th>
					<th lay-data="{field:'endtime' ,width:150}">请假截止时间</th>
					<th lay-data="{field:'dianhua',width:150}">电话号码</th>
			    <th lay-data="{fixed:'right',width:250,align:'center',toolbar:'#barDemo'}"></th>
			      
				</tr>
			</thead>
			<tr>
					<th>201524</th>
					<th>陈缴费</th>
					<th>计算机学院</th>
					<th>软件工程</th>
					<th>2017-10-08</th>
					<th>2017-10-09</th>
					<th>123456</th>
			    <th lay-data="{fixed:'right',width:50,align:'center',toolbar:'#barDemo'}"></th>
				</tr>
					<tr>
					<th>201524</th>
					<th>陈缴费</th>
					<th>计算机学院</th>
					<th>软件工程</th>
					<th>2017-10-08</th>
					<th>2017-10-09</th>
					<th>123456</th>
			    <th lay-data="{fixed:'right',width:50,align:'center',toolbar:'#barDemo'}"></th>
				</tr>
		</table>
		
		<div id="pageDemo"></div>
		</div>
		</div>	
		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-primary layui-btn-mini" lay-event="yuanyin">查看请假原因</a>
			
			<a class="layui-btn layui-btn-mini" lay-event="yes">同意</a>
			<a class="layui-btn layui-btn-mini layui-btn-danger" lay-event="no">不同意</a>
		</script>	
		<script src="<%=request.getContextPath()%>resource/js/layui.js" charset="UTF-8"></script>
		<script >
			layui.use(['form','laypage','layer','table','carousel','element'],function()
			{
				var laypage=layui.laypage
				,table=layui.table
				,element=layui.element
				,form=layui.form;
		
//			table.render({
//				var Data=[{id:"201524133105",name:"陈怡慧",xueyuan:"计算机学院",zhuanye:"软件工程",starttime:"2017-08-2",endtime:"2017-08-05"},
//			         {id:"201524133103",name:"陈怡慧",xueyuan:"计算机学院",zhuanye:"软件工程",starttime:"2017-08-2",endtime:"2017-08-05"}];
//			table.data=Data;
//			
//		});
			//监听工具条
			table.on('tool(demo)',function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
			var data=obj.data//获取当前行数据
			,layevent=obj.event;//获得lay-event对应的值
			if(layevent=='yuanyin')
			{
				layer.open({
					title:'请假原因'
					,content:'回家有事'
				});
			}
			else if(layevent=='yes')
			{
				layer.msg('已同意');
			}
			else if(layevent=='no')
			{
				layer.msg('不同意请假');
			}				
		});
		laypage.render({
			elem:'pageDemo'
			,count:100//总页数
			,skin:'#1E9FFF'
			,jump:function(obj,first)
			{
				if(!first)
				{
					layer.msg('第'+obj.curr+'页');
				}
			}
		});
		});
		</script>	
	</body>
</html>