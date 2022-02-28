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
  <title>Saltlux three jo - ResultDetail</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
  <link rel="stylesheet" href="./style.css">

<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">


  <!-- amcharts : Comparing Different Date Values Google Analytics Style -->
  <!-- Styles -->
	<style>
	#chartdiv {
	  width: 70%;
	  height: 200px;
	}
	#chartdiv2 {
	  width: 70%;
	  height: 200px;
	}
	</style>
	
	<!-- Resources -->
	<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
	
	<!-- 비동기요청 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	$(function(){
		$("#customerInputBtn").click(function(){
			// req_url = "http://localhost:5000/ai_bot"
			req_url = "http://localhost:8080/chatting"
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
					console.log(data)
					question = $("input[name=customerInput]").val();
					$("#result").append("<div class='chat-msg'><div class='chat-msg-profile'>"+
							"<img class='chat-msg-img' src='assets/img/girl.png' alt='' />"+
							"<div class='chat-msg-date'>" + hours+":"+minutes + "</div></div>"+
							"<div class='chat-msg-content'><div class='chat-msg-text'>"+ question +"</div></div></div>");
					$("input[name=customerInput]").val("");
					
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
			req_url = "http://localhost:8080/chatting"
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
	
	<script language="JavaScript">
	function popup(){
		var url="resultDetail.jsp";
		var name="popup";
		window.open(url, name, "width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no, location=no, scrollbars=yes")
	}
	</script>
	
	<!--  
	<script>
	//javascript
	function openWindowPop(url, name){
	    var options = 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
	    window.open(url, name, options);
	}
	</script>
	-->
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
    <div class="detail-title">상담사 감정상태</div>
	<div id="chartdiv"></div>
   </div>
   <div class="detail-area-header">
    <div class="detail-title">고객 감정상태</div>
    <div id="chartdiv2"></div>
   </div>
   
   <br>
   
   <div class="detail-btn">
	<a href="javascript:openWindowPop('resultDetail.jsp', 'popup');" id="resultDetailBtn" role="button" aria-pressed="true">팝업창 열기</a>
   	<!-- <a href="resultDetail.jsp" id="resultDetailBtn" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">결과 상세보기</a> -->
   	<input onclick="popup()" type="button" value="참조">
   </div>
   
  </div>
 </div><!-- wrapper -->
</div> <!-- app -->
<!-- partial -->
  <script  src="./script.js"></script>

</body>
</html>

<%@ include file="./include/footer.jsp" %>

<!-- Chart code -->
<script>
am5.ready(function() {

// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element
var root = am5.Root.new("chartdiv");


// Set themes
// https://www.amcharts.com/docs/v5/concepts/themes/
root.setThemes([
  am5themes_Animated.new(root)
]);


// Create chart
// https://www.amcharts.com/docs/v5/charts/xy-chart/
var chart = root.container.children.push(am5xy.XYChart.new(root, {
  panX: true,
  panY: true,
  wheelX: "panX",
  wheelY: "zoomX"
}));

chart.get("colors").set("step", 3);


// Add cursor
// https://www.amcharts.com/docs/v5/charts/xy-chart/cursor/
var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {}));
cursor.lineY.set("visible", false);


// Create axes
// https://www.amcharts.com/docs/v5/charts/xy-chart/axes/
var xAxis = chart.xAxes.push(am5xy.DateAxis.new(root, {
  maxDeviation: 0.3,
  baseInterval: {
    timeUnit: "day",
    count: 1
  },
  renderer: am5xy.AxisRendererX.new(root, {}),
  tooltip: am5.Tooltip.new(root, {})
}));

var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
  maxDeviation: 0.3,
  renderer: am5xy.AxisRendererY.new(root, {})
}));


// Add series
// https://www.amcharts.com/docs/v5/charts/xy-chart/series/
var series = chart.series.push(am5xy.LineSeries.new(root, {
  name: "Series 1",
  xAxis: xAxis,
  yAxis: yAxis,
  valueYField: "value1",
  valueXField: "date",
  tooltip: am5.Tooltip.new(root, {
    labelText: "{valueX}: {valueY}\n{previousDate}: {value2}"
  })
}));

series.strokes.template.setAll({
  strokeWidth: 2
});

series.get("tooltip").get("background").set("fillOpacity", 0.5);

var series2 = chart.series.push(am5xy.LineSeries.new(root, {
  name: "Series 2",
  xAxis: xAxis,
  yAxis: yAxis,
  valueYField: "value2",
  valueXField: "date"
}));
series2.strokes.template.setAll({
  strokeDasharray: [2, 2],
  strokeWidth: 2
});

// Set date fields
// https://www.amcharts.com/docs/v5/concepts/data/#Parsing_dates
root.dateFormatter.setAll({
  dateFormat: "yyyy-MM-dd",
  dateFields: ["valueX"]
});

//Set data
var data = [{
  date: new Date(2019, 5, 12).getTime(),
  value1: 50,
  value2: 48,
  previousDate: new Date(2019, 5, 5)
}, {
  date: new Date(2019, 5, 13).getTime(),
  value1: 53,
  value2: 51,
  previousDate: "2019-05-06"
}, {
  date: new Date(2019, 5, 14).getTime(),
  value1: 56,
  value2: 58,
  previousDate: "2019-05-07"
}, {
  date: new Date(2019, 5, 15).getTime(),
  value1: 52,
  value2: 53,
  previousDate: "2019-05-08"
}, {
  date: new Date(2019, 5, 16).getTime(),
  value1: 48,
  value2: 44,
  previousDate: "2019-05-09"
}, {
  date: new Date(2019, 5, 17).getTime(),
  value1: 47,
  value2: 42,
  previousDate: "2019-05-10"
}, {
  date: new Date(2019, 5, 18).getTime(),
  value1: 59,
  value2: 55,
  previousDate: "2019-05-11"
}]

series.data.setAll(data);
series2.data.setAll(data);


// Make stuff animate on load
// https://www.amcharts.com/docs/v5/concepts/animations/
series.appear(1000);
series2.appear(1000);
chart.appear(1000, 100);

}); // end am5.ready()
</script>


<!-- Chart code -->
<script>
am5.ready(function() {

// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element
var root = am5.Root.new("chartdiv2");


// Set themes
// https://www.amcharts.com/docs/v5/concepts/themes/
root.setThemes([
  am5themes_Animated.new(root)
]);


// Create chart
// https://www.amcharts.com/docs/v5/charts/xy-chart/
var chart = root.container.children.push(am5xy.XYChart.new(root, {
  panX: true,
  panY: true,
  wheelX: "panX",
  wheelY: "zoomX"
}));

chart.get("colors").set("step", 3);


// Add cursor
// https://www.amcharts.com/docs/v5/charts/xy-chart/cursor/
var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {}));
cursor.lineY.set("visible", false);


// Create axes
// https://www.amcharts.com/docs/v5/charts/xy-chart/axes/
var xAxis = chart.xAxes.push(am5xy.DateAxis.new(root, {
  maxDeviation: 0.3,
  baseInterval: {
    timeUnit: "day",
    count: 1
  },
  renderer: am5xy.AxisRendererX.new(root, {}),
  tooltip: am5.Tooltip.new(root, {})
}));

var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
  maxDeviation: 0.3,
  renderer: am5xy.AxisRendererY.new(root, {})
}));


// Add series
// https://www.amcharts.com/docs/v5/charts/xy-chart/series/
var series = chart.series.push(am5xy.LineSeries.new(root, {
  name: "Series 1",
  xAxis: xAxis,
  yAxis: yAxis,
  valueYField: "value1",
  valueXField: "date",
  tooltip: am5.Tooltip.new(root, {
    labelText: "{valueX}: {valueY}\n{previousDate}: {value2}"
  })
}));

series.strokes.template.setAll({
  strokeWidth: 2
});

series.get("tooltip").get("background").set("fillOpacity", 0.5);

var series2 = chart.series.push(am5xy.LineSeries.new(root, {
  name: "Series 2",
  xAxis: xAxis,
  yAxis: yAxis,
  valueYField: "value2",
  valueXField: "date"
}));
series2.strokes.template.setAll({
  strokeDasharray: [2, 2],
  strokeWidth: 2
});

// Set date fields
// https://www.amcharts.com/docs/v5/concepts/data/#Parsing_dates
root.dateFormatter.setAll({
  dateFormat: "yyyy-MM-dd",
  dateFields: ["valueX"]
});

//Set data
var data = [{
  date: new Date(2019, 5, 12).getTime(),
  value1: 50,
  value2: 48,
  previousDate: new Date(2019, 5, 5)
}, {
  date: new Date(2019, 5, 13).getTime(),
  value1: 53,
  value2: 51,
  previousDate: "2019-05-06"
}, {
  date: new Date(2019, 5, 14).getTime(),
  value1: 56,
  value2: 58,
  previousDate: "2019-05-07"
}, {
  date: new Date(2019, 5, 15).getTime(),
  value1: 52,
  value2: 53,
  previousDate: "2019-05-08"
}, {
  date: new Date(2019, 5, 16).getTime(),
  value1: 48,
  value2: 44,
  previousDate: "2019-05-09"
}, {
  date: new Date(2019, 5, 17).getTime(),
  value1: 47,
  value2: 42,
  previousDate: "2019-05-10"
}, {
  date: new Date(2019, 5, 18).getTime(),
  value1: 59,
  value2: 55,
  previousDate: "2019-05-11"
}]

series.data.setAll(data);
series2.data.setAll(data);


// Make stuff animate on load
// https://www.amcharts.com/docs/v5/concepts/animations/
series.appear(1000);
series2.appear(1000);
chart.appear(1000, 100);

}); // end am5.ready()
</script>
