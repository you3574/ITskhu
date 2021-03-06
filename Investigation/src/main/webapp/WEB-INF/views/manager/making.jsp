<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 출제</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<!-- Bootstrap 3.3.4 -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<!-- bootstrap datepicker -->
<link rel="stylesheet" href="/resources/plugins/datepicker/bootstrap-datepicker.css">
<!-- Font Awesome Icons -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"
	rel="stylesheet" type="text/css" />
<!-- DataTables -->
<link href="/resources/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />	
<!-- Theme style -->
<link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet"
	type="text/css" />
<!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
<link href="/resources/dist/css/skins/_all-skins.min.css"
	rel="stylesheet" type="text/css" />

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<%@include file="../include/menu.jsp" %>
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					설문 출제 <small>설문을 출제합니다.</small>
				</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-md-6" style="height:400px; overflow:scroll; overflow-x:hidden">
						<div class="box box-danger">
							<div class="box-header with-border">
								<h3 class="box-title">조직도</h3>
							</div>
							<div class="box-body">
								<ul>
									<c:forEach var="levelOne" items="${LevelOne }" varStatus="status">
										<li>
											<label>
												<input type="checkbox" value="${levelOne.departCode}" class="levelOne" name="departCheckbox">
											</label>
											
											<c:out value="${levelOne.name}"/>
											<ul>
												<c:forEach var="levelTwo" items="${LevelTwo }" varStatus="status">
													<c:if test="${levelOne.levelCode == levelTwo.highDepartCode }">
														<li>
															<label>
																<input type="checkbox" value="${levelTwo.departCode}" class="levelTwo" name="departCheckbox">
															</label>
															<c:out value="${levelTwo.name}"/>
															<ul>
																<c:forEach var="levelThree" items="${LevelThree }" varStatus="status">
																	<c:if test="${levelTwo.levelCode == levelThree.highDepartCode }">
																		<li>
																			<label>
																				<input type="checkbox" value="${levelThree.departCode}" class="levelThree" name="departCheckbox">
																			</label>
																			<c:out value="${levelThree.name}"/>
																		</li>
																	</c:if>
																</c:forEach>
															</ul>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div> 
					<div class="col-md-6">
						<div class="box box-info" style="height:400px">
							<div class="box-header with-border">
								<h3 class="box-title">상세 정보</h3>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label>제목</label> <input type="text" id="titleNm"
										class="form-control" placeholder="제목 ...">
								</div>
								<div class="form-group">
									<label>설명</label>
									<textarea id="explanation" class="form-control" rows="3" placeholder="조사 설명 ..."></textarea>
								</div>
								
								<div class="form-group">
									<label>시작 날짜</label>
									<div class="input-group date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right" id="startDate" readonly>
									</div>
								</div>
								
								<div class="form-group">
									<label>종료 날짜</label>
									<div class="input-group date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
										<input type="text" class="form-control pull-right" id="endDate" readonly>
									</div>
								</div>
							</div>
							<!-- 
							<div class="box-footer">
								<button type="submit" class="btn btn-info pull-right">출제</button>
							</div>
							 -->
						</div>
					</div> 
				</div>	
				<div class="row">
					<div class="col-md-12">
						<div class="box box-success">
							<div class="box-header">
								<h3 class="box-title">등록된 설문</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div id="example2_wrapper"
									class="dataTables_wrapper form-inline dt-bootstrap">
									<div class="row">
										<div class="col-sm-6"></div>
										<div class="col-sm-6"></div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<table id="example2"
												class="table table-bordered table-hover dataTable"
												role="grid" aria-describedby="example2_info">
												<thead>
													<tr role="row">
														<th width="30px">선택</th>
														<th>순서</th>
														<th>제목</th>
														<th>설문 내용</th>
														<th>등록일</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="Question" items="${QuestionList }"
														varStatus="status">
														<!--<c:if test="${cvq.state != 'e' }">			-->
														<tr>
															<td>
																<input type="radio" id="<c:out value='${Question.version}'/>" value="<c:out value='${Question.version}'/>" name="selectRadio"  >
															</td>
															<td><c:out value="${status.count}" /></td>
															<td><c:out value="${Question.name}" /></td>
															<td><a class="btn-link" href="#"
																onclick="showDetailQuestion(<c:out value='${Question.version}'/>)"><c:out
																		value="${Question.name}" /></a></td>
															<td><fmt:parseDate value="${Question.registryDt}"
																	var="postDate" pattern="yyyymmdd" />
																<fmt:formatDate value="${postDate}" pattern="yyyy-mm-dd" /></td>
														</tr>
														<!--</c:if>-->
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>

								</div>
							</div>
							<!-- /.box-body -->
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<button class="btn btn-warning btn-lg btn-block" id="aaa" name="aaa"><i class="fa fa-upload"></i>점검</button>
					</div>
					<div class="col-md-4">
						<button class="btn btn-warning btn-lg btn-block" id="makeDoc" name="makeDoc"><i class="fa fa-upload"></i>출제</button>
					</div>
					<div class="col-md-4"></div>
				</div>
			</section>
		</div>
		<!--  Content Wrapper -->
	</div>
	<!-- ./wrapper -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<!-- Bootstrap 3.3.2 JS -->
	<script src="/resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- DataTables -->
	<script src="/resources/plugins/datatables/jquery.dataTables.min.js"></script>
	<script src="/resources/plugins/datatables/dataTables.bootstrap.min.js"></script>
	<!-- bootbox -->
	<script src="/resources/plugins/bootbox/bootbox.min.js"></script>
	<!-- SlimScroll -->
	<script src="/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src='/resources/plugins/fastclick/fastclick.min.js'></script>
	<!-- AdminLTE App -->
	<script src="/resources/dist/js/app.min.js" type="text/javascript"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/resources/dist/js/demo.js" type="text/javascript"></script>
	<!-- bootstrap datepicker -->
	<script src="/resources/plugins/datepicker/bootstrap-datepicker_2.js"></script>
	<script type="text/javascript">
$(function() {

	$('input[name=departCheckbox]').change(function(){
		 if($(this).is(':checked')){
			 $(this).parent().next().find('input[name=departCheckbox]').prop('checked',true );
		 }
		 else{
			 $(this).parent().next().find('input[name=departCheckbox]').prop('checked',false );
		 }
	});

	$('#aaa').bind({
		click: function(e){
    		e.preventDefault();
    		var testarray = [];	
    		
    		if($('input[name=departCheckbox]:checked').length > 0 ){

    			$("input[class='levelThree']:checked").each(function(i){
    				testarray.push($(this).val());
    			});
    		}else{
    			alert($('input[name=departCheckbox]:checked').length);
    		}
    		var loadingHtml = '<div id="loading" style="z-index: 1005;position: absolute; top:50%;left:50%; text-align:center;"> ';
    	    loadingHtml += '<div class="loading_box" style="font-size:20pt"><img src="/resources/dist/img/loading2.gif"><br>출제 중입니다.</div></div>';
    	 
    	    $('body').fadeTo( "fast", 0.4 ).append(loadingHtml);
    	    
    	    var version = $('input[name=selectRadio]:radio:checked').val();
			var titleNm = $('#titleNm').val();
			var explanation = $('#explanation').val();
			var startDate = $('#startDate').val();
			var endDate = $('#endDate').val();
			var testarray = [];	
			
			var start = parseInt(startDate);
			var end = parseInt(endDate);
			if(start>end)
				alert("시작일 보다 종료일이 빠릅니다.");
			
			
			$("input[class='levelThree']:checked").each(function(i){
				testarray.push($(this).val());
			});
    	    
    		$('body').fadeTo( "slow", 1 ).find('#loading').remove();
			
		}
	});
	
	//Date picker
	$('#startDate').datepicker({
		autoclose : true,
		format: 'yyyymmdd',
		todayHighlight: true,
		language : 'ko'	
	});
	$('#endDate').datepicker({
		autoclose : true,
		format: 'yyyymmdd',
		todayHighlight: true,
		language : 'ko'
	});
	
	
	$('#makeDoc').bind({
		click: function(e){
    		e.preventDefault();
			
    		//입력폼 값 검사
			if(!checkVal()){
				return false;
			}
			
			var version = $('input[type=radio]:checked').val();
			var titleNm = $('#titleNm').val();
			var explanation = $('#explanation').val();
			var startDate = $('#startDate').val();
			var endDate = $('#endDate').val();
			var targetSosok = [];	
			$("input[class='levelThree']:checked").each(function(i){
				targetSosok.push($(this).val());
			});

			//전송되는 값을 정리
			//부서는 선택된 lv3만 보내기
			var sendData;
			sendData = JSON.stringify({
	            "version":			version,
	            "titleNm":			titleNm,
	            "explanation": 		explanation,
	            "startDate":		startDate,
	            "endDate":			endDate,		
	            "targetSosok":		targetSosok
	        });		

			var loadingHtml = '<div id="loading" style="z-index: 1005;position: absolute; top:50%;left:50%; text-align:center;"> ';
    	    loadingHtml += '<div class="loading_box" style="font-size:20pt"><img src="/resources/dist/img/loading2.gif"><br>출제 중입니다.</div></div>';
    	 
			$.ajax({
    			url: "making/input",
    			method: "POST",
    			data: sendData,
    			dataType: "json",
    			contentType: "application/json;charset=UTF-8",
    			beforeSend: function(){
    				if(confirm('입력하시겠습니까?')){	
    					$('body').fadeTo( "fast", 0.4 ).append(loadingHtml);
						return true;
					}
					else{
						return false;
					}    				
    			},
    			complete:function(){
    				alert("출제했습니다.")
    				$('body').fadeTo( "slow", 1 ).find('#loading').remove();
    				location.href="/main";
    			}
			});
		}//end of click
	});
	

    function alertDialog(title, message){
    	bootbox.alert(message)
    	.find('.modal-content')
    	.css({color:'#f00', 'font-size':'1.1em', 'font-weight':'bold', 'background-color':'#fff'});
    };

    function checkVal(){
		var checkRadio = $('input[type=radio]:checked').val();
		var checkBox = $('input[name=departCheckbox]:checked').length;
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		
		if(checkRadio == undefined){
			alert("설문을 선택해주세요.");
			return false;	
		}else if(checkBox == 0){
			alert("설문 타켓을 선택해주세요.");
			return false;
		}else if($('#titleNm').val()==''){
			alert("제목을 입력해주세요.");
			return false;	
		}else if($('#startDate').val()==''){
			alert("시작일을 입력해주세요.");
			return false;	
		}else if($('#endDate').val()==''){
			alert("종료일을 입력해주세요.");
			return false;	
		}else if($('#explanation').val()==''){
			alert("설명을 입력해주세요.");
			return false;	
		}
		//시작일 종료일 반대 체크 부분 넣어야함.
		var start = parseInt(startDate);
		var end = parseInt(endDate);
		if(start>end){
			alert("시작일 보다 종료일이 느립니다.");
			return false;
		}
			
		
		return true;				
    };
	
});
		
$('#example2').DataTable({
	'paging'      : true,
	'lengthChange': true,
	'searching'   : false,
	'ordering'    : false,
	'info'        : true,
	'autoWidth'   : false
});



		
function showDetailQuestion(version){
	//1.version값으로 데이터를 json 가져온다
	//가져온 데이터를 모달박스에 넣어 표현해준다
	var messageFront = "<div class='table-responsive'><table class='table table-hover' id='poptable'><th class='text-center' style='padding:1.7px'>항목</th><th class='text-center' style='padding:1.7px'>순서</th><th class='text-center' style='padding:1.7px'>문장</th>";
	var messageEnd = "</table></div>";
	var bootboxForm = "";
	var sendData = {"version" : version};
			
			$.ajax({
				url: "registry/detail",
				method: "POST",
				data: sendData,
				dataType: "json",
				success: function(data){ 
					//var vdata = data.data;
					$.each(data, function(index, list){
						bootboxForm += "<tr><td class='text-center' style='padding:1.7px'>"+list.itemNm+"</td><td class='text-center' style='padding:1.7px'>"+list.sentenceSeq+"</td><td style='padding:1.7px'>"+list.sentence+"</td></tr>"
					});
					bootboxForm = messageFront + bootboxForm + messageEnd;
					bootbox.dialog({
		    	        message: bootboxForm
					}).find('.modal-content').css({'width':'800px', 'font-size':'0.9em', 'font-weight':'bold'});
					return true;
				}
			});   
			return false;
};

	</script>
</body>


</html>


