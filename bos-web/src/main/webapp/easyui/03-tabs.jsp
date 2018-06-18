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
			<div title="面板三">3333</div>
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