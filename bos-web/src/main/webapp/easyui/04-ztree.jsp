<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tabs选项卡</title>
<!-- 引入easyUI的资源文件 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"></script>

<!-- js脚本 -->
<script type="text/javascript">
/* 页面加载完成后触发以下函数 */
$(function() {
			/* easyui的写法,绑定btn1的事件 */
			$("#btn1").click(function() {
				/* 先判断该选项卡是否存在，这里判断的是系统管理是否已存在 */
				var e = $("#mytabs").tabs("exists","系统管理");
				if(e){
					//如果已经存在,就直接选中该选项卡
					$("#mytabs").tabs("select","系统管理");
					
				}else{
					//如果不存在，就添加一个选项卡
					$("#mytabs").tabs("add",
					{
						/* 第二个参数是选项卡的属性 */
						title:'系统管理',
						iconCls:'icon-edit',
						closable:true,
						content:'<iframe frameborder="1" height="100%" width="100%" src="https://www.baidu.com"></iframe>'
					}		
					);
				}
			});
		});
		
		
/* 构造ztree的js脚本 ，使用标准的json数据构造，每个json对象表示一个节点数据*/
$(function() {
	var setting = {};
	var zNodes = [
		{"name":"节点一",
		"children":[
			{"name":"子节点一"},
			{"name":"子节点二"},
			{"name":"子节点三"}
		]	
		},
		
		{"name":"节点二"},
		{"name":"节点三"}
	];
	
	/* 调用ztree的API初始化ztree */
	$.fn.zTree.init($("#ztree"),setting,zNodes);
});


/* 构造ztree的js脚本 ，使用简单的json数据构造，每个json对象表示一个节点数据 */
$(function() {
	var setting2 = {
			data:{
				simpleData:{
					//使用简单json数据构造ztree节点
					enable:true
				}
			}
	};
	
	var zNodes2 = [
		//每个json对象表示一个节点数据
		{"id":"1","pId":"2","name":"节点一"},
         {"id":"2","pId":"3","name":"节点二"},
         {"id":"3","pId":"0","name":"节点三"}
	];
	
	//调用API初始化ztree
	$.fn.zTree.init($("#ztree2"),setting2,zNodes2);
});

/* 发送ajax请求获取json数据构造ztree */
$(function() {
	var setting3 = {
			data:{
				//使用简单json数据构造ztree节点
				simpleData:true
			},
			callback:{
				onClick: function(event,treeId,treeNode) {
					//判断节点的page属性有没有定义，如果没有定义就是父节点，有定义就是子节点
					if(treeNode.page != undefined){
						//判断选项卡是否已存在
						var e = $("#mytabs").tabs("exists",treeNode.name);
						if(e){
							//已经存在就选中
							$("#mytabs").tabs("select",treeNode.name);
						}else{
							//不存在就添加一个选项卡
							$("#mytabs").tabs("add",{
								//选项卡的属性
								title : treeNode.name,
								closable : true,
								content:'<iframe frameborder="0" height="100%" width="100%" src="'+treeNode.page+'"></iframe>'
							});
						}
					}
				}
			}
	};
	
		//发送ajax请求，获取json数据 方式有ajax，post，get，load，getjson，getscript
		//$.post的参数有4个，1是URL地址，2是请求参数，3是回调函数，4是数据格式
		var url = "${pageContext.request.contextPath}/json/menu.json";
		$.post(
		url,
		{},
		function(data) {
			//接收到数据
			$.fn.zTree.init($("#ztree3"));
		},
		'json'
		);
});

</script>

</head>
<!-- 引入easyUI的layout样式 -->
<body class="easyui-layout">
	<!-- 使用div元素描述每个区域 -->
	<div title="XXX管理系统" style="height: 100px" data-options="region:'north'">北部区域</div>
	<div title="系统菜单" style="width: 200px" data-options="region:'west'">
		<!-- 制作accordion折叠面板 
			fit:true----自适应(填充父容器)
		-->
		<div class="easyui-accordion" data-options="fit:true">
			<!-- 使用子div表示每个面板 -->
			<div data-options="iconCls:'icon-cut'" title="面板一">
			
			<!-- 设置一个linkbutton,用来添加选项卡 -->
			<a id="btn1" class="easyui-linkbutton">添加一个选项卡</a>
		
			</div>
			<div title="面板二">
				<!-- 显示ztree效果，使用标准的json数据构造ztree -->
			<ul id="ztree" class="ztree"></ul>
			
			</div>
			<div title="面板三">
			<ul id="ztree2" class="ztree"></ul>
			</div>
			<div title="面板四">
			<ul id="ztree3" class="ztree"></ul>
			</div>
		</div>
	</div>
	
	<div data-options="region:'center'">
		<!-- 制作一个tabs选项卡面板 
				easyui-tabs：选项卡的样式
				fit:true : 自适应（填充父容器）
		-->
		<div id="mytabs" class="easyui-tabs" data-options="fit:true">
			<!-- 使用子div表示每个面板
					iconCls: 选项卡图标
					closable ：选项卡是否可关闭 true为可关；false为不可关
			 -->
			<div data-options="iconCls:'icon-cut'" title="选项卡一">1111</div>
			<div data-options="closable:true" title="选项卡二">2222</div>
			<div title="选项卡三">3333</div>
		</div>
	</div>
	<div style="width: 100px" data-options="region:'east'">东部区域</div>
	<div style="height: 50px" data-options="region:'south'">南部区域</div>
</body>
</html>