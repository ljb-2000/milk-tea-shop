<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>叶子C奶茶店</title>
<%@ include file="/WEB-INF/page/common/common.jsp"%>
<!--Core CSS -->
<link href="<c:url value="/resources/bs3/css/bootstrap.min.css"/>"
	rel="stylesheet">
<link href="<c:url value="/resources/css/bootstrap-reset.css"/>"
	rel="stylesheet">
<link
	href="<c:url value="/resources/font-awesome/css/font-awesome.css"/>"
	rel="stylesheet" />

<link rel="stylesheet"
	href="<c:url value="/resources/js/data-tables/DT_bootstrap.css"/>" />

<!-- Custom styles for this template -->
<link href="<c:url value="/resources/css/style.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/css/style-responsive.css"/>"
	rel="stylesheet" />

<link
	href="<c:url value="/resources/js/bootstrap-fileupload/fileinput.css"/>"
	media="all" rel="stylesheet" type="text/css" />
</head>

<body>

	<section id="container">
		<%@ include file="/WEB-INF/page/common/header.jsp"%>

		<!--main content start-->
		<section id="main-content">
			<section class="wrapper">
				<!-- page start-->

				<div class="row">
					<div class="col-sm-12">
						<section class="panel">
							<header class="panel-heading">
								<strong>会员充值</strong><span class="tools pull-right"> <a
									href="javascript:;" class="fa fa-chevron-down"></a> <a
									href="javascript:;" class="fa fa-cog"></a> <a
									href="javascript:;" class="fa fa-times"></a>
								</span>
							</header>
							<div class="panel-body">
								<div class="adv-table editable-table ">
									<div class="clearfix">
										<div class="btn-group">
										<label class="col-sm-3 control-label col-lg-3">联系方式：</label>
											<div class="col-lg-9">
												<div class="input-group m-bot15">
												    <input id="telId" name="telId" type="hidden">
													</div>
											</div>
											<a href="#addMilkTeaModal" data-toggle="modal" idattr="${telId}" class="searchtelContent">
															<button class="btn btn-success">查询</button></a>
										</div>
										
									</div>
									<div class="space15"></div>
									<table class="table table-striped table-hover table-bordered"
										id="editable-sample">
										<thead>
											<tr>
												<th>姓名</th>
												<th>联系方式</th>
												<th>折扣</th>
												<th>积分</th>
												<th>余额</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${vipList}" var="item">
												<tr class="">
													<td>${item.name}</td>
													<td>${item.tel}</td>
													<td>${item.discount}</td>
                                                    <td>￥${item.integral}</td>
                                                    <td>￥${item.recharge}</td>
															<td><a href="#addMilkTeaModal" data-toggle="modal" idattr="${item.id}" class="updateContent">
															<button class="btn btn-success">修改</button>
													</a> <a href="${basePath}/vip/delete?id=${item.id}" style="padding-left: 10px">
															<button class="btn btn btn-primary">删除</button>
													</a> 
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</section>
					</div>
				</div>
				<!-- page end-->
			</section>
		</section>
		<!--main content end-->
		
		<!-- Modal -->
		<div class="modal fade" id="addMilkTeaModal" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">添加会员</h4>
					</div>

					<div class="modal-body row">
						<div class="col-md-5">
							<div class="form-group">
								<label> 姓名：</label> <input id="name" name="name"
									class="form-control">
							</div>
							<div class="form-group">
								<label> 联系方式：</label> <input id="tel"
									name="tel" class="form-control">
							</div>
							<div class="form-group">
								<label> 余额：</label> <input id="recharge" name="recharge"
									class="form-control">
							</div>
							<div class="form-group">
								<label> 折扣：</label> <input id="discount" name="discount"
									class="form-control">
							</div>
							<div class="form-group">
								<label> 积分：</label> <input id="integral" name="integral"
									class="form-control">
							</div>
						</div>

					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="saveChanges">保存</button>
					</div>

				</div>
			</div>
		</div>
		<!-- modal -->


	</section>
	<%@ include file="/WEB-INF/page/common/footer.jsp"%>
	<script src="<c:url value="/resources/js/table-editable.js"/>"></script>
	<script
		src="<c:url value="/resources/js/bootstrap-fileupload/fileinput.js"/>"
		type="text/javascript"></script>
	<script
		src="<c:url value="/resources/js/bootstrap-fileupload/fileinput_locale_zh.js"/>"
		type="text/javascript"></script>
	<script src="<c:url value="/resources/js/ajaxfileupload.js"/>"
		type="text/javascript"></script>
	<script type="text/javascript">
	    var add = true;
	    var id;
		jQuery(document).ready(function() {
			EditableTable.init();
		});
		
		$('#addMilkButton').click(function(){
			$('#name').val('');
		});
		
		$('.updateContent').each(function(){
			$(this).click(function(){
				add = false;
				id = $(this).attr('idattr');
				
				$.ajax({
					type : "GET",
					url : basePath + '/vip/getOneById?id='+id,
					async: false, 
					success : function(returnValue) {
						$('#name').val(returnValue.name);
					}
			    });	     
			});
		});
		
		$('.searchtelContent').each(function(){
			$(this).click(function(){
				telid = $(this).attr('idattr');
				
				$.ajax({
					type : "GET",
					url : basePath + '/vip/getOneById?telid='+telid,
					async: false, 
					success : function(returnValue) {
						$('#name').val(returnValue.name);
					}
			    });	     
			});
		});

		$('#saveChanges').click(function() {
			url = basePath + '/vip/add';
			
			if(add==false){
				url = basePath + '/vip/update';
			}
			var name = $('#name').val();
			var tel = $('#tel').val();
			var discount = $('#discount').val();
			var integral = $('#integral').val();
			var recharge = $('#recharge').val();
			
			$.ajax({
				type : "POST",
				url : url,
				data : {
					id : id,
					name : name,
					tel:tel,
					discount:discount,
					integral:integral,
					recharge:recharge
				},
				async: true, 
				success : function(returnValue) {
					 location.reload();
				}
		    });	     
			$('#addMilkTeaModal').modal('hide');
		});

	</script>
</body>
</html>
