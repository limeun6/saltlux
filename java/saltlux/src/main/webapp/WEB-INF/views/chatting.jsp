<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<% 
	Date nowTime = new Date();
	SimpleDateFormat sf1 = new SimpleDateFormat("yyyy년 MM월 dd일");
	SimpleDateFormat sf2 = new SimpleDateFormat("HH:mm"); 
%>

<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Saltlux three jo - Chatting</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
  <link rel="stylesheet" href="./style.css">

<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

  <!-- amcharts : Comparing Different Date Values Google Analytics Style -->
  <!-- Styles -->
	<style>
	#counselorChartdiv1 {
		width: 150%;
		height:130%;
	}
	#customerChartdiv1 {
	  	width: 150%;
		height: 130%;
	}
	</style>
	
	<!-- Resources -->
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/series-label.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	
	<script>
		<!-- 차트용 글로벌 변수 -->
		var counselorStressList=[0];
		var customerStressList=[0];
		
		function getListFilter(data,key,value){
			if(data.TYPE=="S"){
				return data.result.filter(function(object){
					console.log(object)
					return object[key]===value;
				})
			}else{
				alert(data.MESSAGE);
				return 1000;
			}
		}
		function set_chart(data){
			tmp = data.cate_name;
			tmp1= data.rate;
			
			for(var i=0; i<tmp.length; i++){
				var data = new Object();
				data.name = tmp[i];
				data.y = tmp1[i]*1;
				dataList.push(data);
			}
			console.log(dataList);
		}
	</script>
	<!-- 비동기요청 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	$(function(){
		$("#customerInputBtn").click(function(){
			// req_url = "http://localhost:5000/ai_bot"
			req_url = "http://localhost:5000/chatting"
			var form = $("#form1")[0];
			var form_data = new FormData(form);
			var isScrollUp = false;
			var lastScrollTop;
			var divChat = document.getElementById('div_chat');
			
			var now = new Date();	// 현재 날짜 및 시간
			var hours = now.getHours();	// 시간
			var minutes = now.getMinutes();	// 분
			var seconds = now.getSeconds();	// 초

			// 비동기요청
			$.ajax({
				url:req_url,
				async: true,
				type: "POST",
				data: form_data,
				processData: false,
				contentType: false,
				success: function(data){
					question = $("input[name=customerInput]").val();
					$("#result").append("<div class='chat-msg'><div class='chat-msg-profile'>"+
							"<img class='chat-msg-img' src='assets/img/girl.png' alt='' />"+
							"<div class='chat-msg-date'>" + hours+":"+minutes + "</div></div>"+
							"<div class='chat-msg-content'><div class='chat-msg-text'>"+ question +"</div></div></div>");
					$("input[name=customerInput]").val("");
					// 스트레스값을 저장
					//console.log(getListFilter(data,'type','stress'))
					customerStressList.push(data.result[0].score);
					// 차트에 반영
					customerChartStress.update({
						series: [{
							name: 'Stress',
							data: customerStressList
							}]
					});
					// 기본적으로 스크롤 최하단으로 이동 (애니메이션 적용)
				    if (!isScrollUp) {
				      $('#div_chat').animate({
				        scrollTop: divChat.scrollHeight - divChat.clientHeight
				      }, 100);
				    }
					
				},
				error: function(e){
					alert(e);
				}
			})
		})
	})
	</script>
	
	<script>
	$(function(){
		$("#counselorInputBtn").click(function(){
			// req_url = "http://localhost:5000/ai_bot"
			req_url = "http://localhost:5000/chatting"
			var form = $("#form2")[0];
			var form_data = new FormData(form);
			var isScrollUp = false;
			var lastScrollTop;
			var divChat = document.getElementById('div_chat');
			
			var now = new Date();	// 현재 날짜 및 시간
			var hours = now.getHours();	// 시간
			var minutes = now.getMinutes();	// 분
			var seconds = now.getSeconds();	// 초

			// 비동기요청
			$.ajax({
				url:req_url,
				async: true,
				type: "POST",
				data: form_data,
				processData: false,
				contentType: false,
				success: function(data){
					console.log(data)
					question = $("input[name=counselorInput]").val();
					$("#result").append(
							"<div class='chat-msg owner'>"+
						     "<div class='chat-msg-profile'>"+
						      "<img class='chat-msg-img' src='assets/img/operator.png' alt='' />"+
						      "<div class='chat-msg-date'>" + hours+":"+ minutes + "</div>"+
						     "</div>"+
						     "<div class='chat-msg-content'>"+
						      "<div class='chat-msg-text'>"+question+"</div>"+
						     "</div>"+
						    "</div>");
					$("input[name=counselorInput]").val("");
					// 스트레스값을 저장
					counselorStressList.push(data.result[0].score);
					// 차트에 반영
					counselorChartStress.update({
						series: [{
							name: 'Stress',
							data: counselorStressList
							}]
					});
					// 기본적으로 스크롤 최하단으로 이동 (애니메이션 적용)
				    if (!isScrollUp) {
				      $('#div_chat').animate({
				        scrollTop: divChat.scrollHeight - divChat.clientHeight
				      }, 100);
				    }
				},
				error: function(e){
					alert(e);
				}
			})
		})
	})
	</script>
	<script>
	function openWindowPop(url, name){
	    var options = 'top=10, left=10, width=1200, height=800, status=no, menubar=no, toolbar=no, resizable=no';
	    window.open(url, name, options);
	}
	</script>

</head>
<body>
<!-- partial:index.partial.html -->
<div class="app">
 <div class="header">
    <h1><a href="/" style="font-size: 30px; margin: 0; line-height: 1; font-weight: 400; letter-spacing: 2px; color: #5777ba;
  text-decoration: none;">three jo</a></h1> 
  <div class="user-settings">
   <div class="dark-light">
    <svg viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5" fill="none" stroke-linecap="round" stroke-linejoin="round">
     <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" /></svg>
   </div>
   
  </div>
 </div>
 <div class="wrapper">
  <div class="chat-area">
   <div class="chat-area-main" id="div_chat">
   <div id="chatDate">
   	<%= sf1.format(nowTime) %>
   </div>
   <div class="chat-msg owner">
     <div class="chat-msg-profile">
      <img class="chat-msg-img" src="assets/img/operator.png" alt="" />
      <div class="chat-msg-date"><%= sf2.format(nowTime) %></div>
     </div>
     <div class="chat-msg-content">
      <div class="chat-msg-text">안녕하세요 고객님~ 무엇을 도와드릴까요? </div>
     </div>
    </div> <!-- chat-msg owner -->
    <div id="result"></div>
   </div> <!-- chat-area-main -->
   
   <div class="chat-area-footer">
   <form action="#" method="POST" id="form1">
    <input type="text" name="customerInput" placeholder="고객 채팅 입력..." />
	<input type="button" value="전송" id="customerInputBtn" class="btn btn-primary" style="width=20%; border: #9F7AEA; background: #9F7AEA "></button>
   </form>
   <form action="#" method="POST" id="form2">
    <input type="text" name="counselorInput" placeholder="상담사 채팅 입력..." />
	<input type="button" value="전송" id="counselorInputBtn" class="btn btn-primary" style="width=20%; border: #38b2ac; background: #38b2ac"></button>
   </form>
   </div> <!-- chat-area-footer -->
   
  </div> <!-- chat-area -->
  
  <div class="detail-area">
   <div class="detail-area-header">
	<figure class="highcharts-figure">
    	<div id="counselorChartStress"></div>
	</figure>
   </div>
   <div class="detail-area-header">
    <figure class="highcharts-figure">
    	<div id="customerChartStress"></div>
	</figure>
   </div>
   
   <br>
  
   <div class="detail-btn">
	<a href="javascript:openWindowPop('resultDetail', 'popup');" id="resultDetailBtn" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">결과 상세보기</a>
   </div>
   
  </div>
 </div><!-- wrapper -->
</div> <!-- app -->
<!-- partial -->
  <script  src="./script.js"></script>


<%@ include file="./include/footer.jsp" %>

<!-- Chart code -->
<script>
const counselorChartStress = Highcharts.chart('counselorChartStress', {

    title: {
        text: '상담사감정상태'
    },

    subtitle: {
        text: ''
    },

    yAxis: {
        title: {
            text: 'Number of Employees'
        }
    },

    xAxis: {
        accessibility: {
            rangeDescription: 'Range: 2010 to 2017'
        }
    },

    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    plotOptions: {
        series: {
            label: {
                connectorAllowed: false
            },
            pointStart: 1
        }
    },

    series: [{
        name: 'Stress',
        data: counselorStressList
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});
</script>
<script>
const customerChartStress = Highcharts.chart('customerChartStress', {

    title: {
        text: '고객감정상태'
    },

    subtitle: {
        text: ''
    },

    yAxis: {
        title: {
            text: 'Number of Employees'
        }
    },

    xAxis: {
        accessibility: {
            rangeDescription: 'Range: 2010 to 2017'
        }
    },

    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    plotOptions: {
        series: {
            label: {
                connectorAllowed: false
            },
            pointStart: 1
        }
    },

    series: [{
        name: 'Stress',
        data: customerStressList
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});
</script>