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
								<strong>入库列表</strong><span class="tools pull-right"> <a
									href="javascript:;" class="fa fa-chevron-down"></a> <a
									href="javascript:;" class="fa fa-cog"></a> <a
									href="javascript:;" class="fa fa-times"></a>
								</span>
							</header>
							<div class="panel-body">
								<div class="adv-table editable-table ">
									<div class="clearfix">
										<div class="btn-group">
										<a href="#addMilkTeaModal" data-toggle="modal" id="addMilkButton">
												<button id="editable-sample_new" class="btn btn-primary">
													添加 <i class="fa fa-plus"></i>
												</button>
											</a>
										</div>
										<div class="btn-group pull-right">
											<button class="btn btn-default dropdown-toggle"
												data-toggle="dropdown">
												Tools <i class="fa fa-angle-down"></i>
											</button>
											<ul class="dropdown-menu pull-right">
												<li><a href="#">Print</a></li>
												<li><a href="#">Save as PDF</a></li>
												<li><a href="#">Export to Excel</a></li>
											</ul>
										</div>
									</div>
									<div class="space15"></div>
									<table class="table table-striped table-hover table-bordered"
										id="editable-sample">
										<thead>
											<tr>
											<th>编号</th>
												<th>物料名称</th>
												<th>下单日期</th>
												<th>下单数量</th>
												<th>单价</th>
												<th>运费</th>
												<th>供应商</th>
												<th>到货数量</th>
												<th>备注</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${inOrderList}" var="item">
												<tr class="">
												<td>${item.orderNumber}</td>
													<td>${item.materialName}</td>
													<td>${item.orderDate}</td>
													<td>${item.orderNum}</td>
													<td>${item.price}</td>
													<td>${item.shipment}</td>
													<td>${item.supplier}</td>
													<td>${item.inNum}</td>
													<td>${item.remark}</td>
															<td><a href="#addMilkTeaModal" data-toggle="modal" idattr="${item.id}" class="updateContent">
															<button class="btn btn-success">修改</button>
													</a> <a href="${basePath}/inorder/delete?id=${item.id}" style="padding-left: 10px">
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
						<h4 class="modal-title">添加物料</h4>
					</div>

					<div class="modal-body row">
						<div class="col-md-5">
						<div class="form-group">
								<label> 编号：</label> <input id="orderNumber" name="orderNumber"
									class="form-control">
							</div>
							
							<div class="form-group">
								<label> 物料：</label> 									
									<select class="form-control"  id="materials">
									<c:forEach items="${materialList}" var="item">
										<option value="${item.id}#${item.name}">${item.name}</option>
									</c:forEach>
								</select> 
							</div>
							
							<div class="form-group">
								<label> 下单数量：</label> <input id="orderNum"
									name="orderNum" class="form-control">
							</div>
						
							<div class="form-group">
								<label> 单价：</label> <input id="price"
									name="price" class="form-control">
							</div>
							<div class="form-group">
								<label> 运费：</label> <input id="shipment"
									name="shipment" class="form-control">
							</div>
							<div class="form-group">
								<label> 供应商：</label> <input id="supplier"
									name="supplier" class="form-control">
							</div>
							<div class="form-group">
								<label> 到货数量：</label> <input id="inNum"
									name="inNum" class="form-control">
							</div>
							<div class="form-group">
								<label> 备注：</label> <input id="remark"
									name="remark" class="form-control">
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
					url : basePath + '/inorder/getOneById?id='+id,
					async: false, 
					success : function(returnValue) {
						setSelect('materials',returnValue.materialId+"#"+returnValue.materialName);
						$('#materialId').val(returnValue.materialId);
						$('#orderNumber').val(returnValue.orderNumber);
						$('#orderDate').val(returnValue.orderDate);
						$('#orderNum').val(returnValue.orderNum);
						$('#price').val(returnValue.price);
						$('#shipment').val(returnValue.shipment);
						$('#supplier').val(returnValue.supplier);
						$('#inNum').val(returnValue.inNum);
						$('#remark').val(returnValue.remark);
					}
			    });	     
			});
		});
		
		function setSelect(id,selected){
			var options = $('#'+id).children();
			for(var i=0;i<options.length;i++){
				var option = options[i];
				if($(option).val()==selected){
					$(option).attr("selected", true);
				}else{
					$(option).removeAttr("selected");
				}
			}
		}

		$('#saveChanges').click(function() {
			url = basePath + '/inorder/add';
			
			if(add==false){
				url = basePath + '/inorder/update';
			}
			
			var materialId= $('#materials').val().split('#')[0];
			var materialName = $('#materials').val().split('#')[1];
			var orderDate = $('#orderDate').val();
			var orderNum = $('#orderNum').val();
			var orderNumber = $('#orderNumber').val();
			var price = $('#price').val();
			var shipment = $('#shipment').val();
			var supplier = $('#supplier').val();
			var inNum = $('#inNum').val();
			var remark = $('#remark').val();
			
			$.ajax({
				type : "POST",
				url : url,
				data : {
					id : id,
					materialId : materialId,
					materialName:materialName,
					orderDate : orderDate,
					orderNum : orderNum,
					orderNumber : orderNumber,
					price:price,
					shipment : shipment,
					supplier : supplier,
					inNum:inNum,
					remark:remark
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
