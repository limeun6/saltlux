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
	  width: 90%;
  	  height: 180px;
	  max-width: 100%;
	}
	#customerChartdiv1 {
	  width: 90%;
  	  height: 180px;
	  max-width: 100%;
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
    <div class="detail-title">상담사 감정상태</div>
	<div id="counselorChartdiv1"></div>
   </div>
   <div class="detail-area-header">
    <div class="detail-title">고객 감정상태</div>
    <div id="customerChartdiv1"></div>
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
am5.ready(function() {

// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element 
var root = am5.Root.new("counselorChartdiv1");


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
  wheelY: "zoomX",
  maxTooltipDistance: 0
}));


var date = new Date();
date.setHours(0, 0, 0, 0);
var value = 100;

function generateData() {
  value = Math.round((Math.random() * 10 - 4.2) + value);
  am5.time.add(date, "day", 1);
  return {
    date: date.getTime(),
    value: value
  };
}

function generateDatas(count) {
  var data = [];
  for (var i = 0; i < count; ++i) {
    data.push(generateData());
  }
  return data;
}


// Create axes
// https://www.amcharts.com/docs/v5/charts/xy-chart/axes/
var xAxis = chart.xAxes.push(am5xy.DateAxis.new(root, {
  maxDeviation: 0.2,
  baseInterval: {
    timeUnit: "day",
    count: 1
  },
  renderer: am5xy.AxisRendererX.new(root, {}),
  tooltip: am5.Tooltip.new(root, {})
}));

var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
  renderer: am5xy.AxisRendererY.new(root, {})
}));


// Add series
// https://www.amcharts.com/docs/v5/charts/xy-chart/series/
for (var i = 0; i < 5; i++) {
  var series = chart.series.push(am5xy.LineSeries.new(root, {
    name: "Series " + i,
    xAxis: xAxis,
    yAxis: yAxis,
    valueYField: "value",
    valueXField: "date",
    legendValueText: "{valueY}",
    tooltip: am5.Tooltip.new(root, {
      pointerOrientation: "horizontal",
      labelText: "{valueY}"
    })
  }));

  date = new Date();
  date.setHours(0, 0, 0, 0);
  value = 0;

  var data = generateDatas(100);
  series.data.setAll(data);

  // Make stuff animate on load
  // https://www.amcharts.com/docs/v5/concepts/animations/
  series.appear();
}


// Add cursor
// https://www.amcharts.com/docs/v5/charts/xy-chart/cursor/
var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {
  behavior: "none"
}));
cursor.lineY.set("visible", false);

// Add legend
// https://www.amcharts.com/docs/v5/charts/xy-chart/legend-xy-series/
var legend = chart.rightAxesContainer.children.push(am5.Legend.new(root, {
  width: 200,
  paddingLeft: 15,
  height: am5.percent(100)
}));

// When legend item container is hovered, dim all the series except the hovered one
legend.itemContainers.template.events.on("pointerover", function(e) {
  var itemContainer = e.target;

  // As series list is data of a legend, dataContext is series
  var series = itemContainer.dataItem.dataContext;

  chart.series.each(function(chartSeries) {
    if (chartSeries != series) {
      chartSeries.strokes.template.setAll({
        strokeOpacity: 0.15,
        stroke: am5.color(0x000000)
      });
    } else {
      chartSeries.strokes.template.setAll({
        strokeWidth: 3
      });
    }
  })
})

// When legend item container is unhovered, make all series as they are
legend.itemContainers.template.events.on("pointerout", function(e) {
  var itemContainer = e.target;
  var series = itemContainer.dataItem.dataContext;

  chart.series.each(function(chartSeries) {
    chartSeries.strokes.template.setAll({
      strokeOpacity: 1,
      strokeWidth: 1,
      stroke: chartSeries.get("fill")
    });
  });
})

legend.itemContainers.template.set("width", am5.p100);
legend.valueLabels.template.setAll({
  width: am5.p100,
  textAlign: "right"
});

// It's is important to set legend data after all the events are set on template, otherwise events won't be copied
legend.data.setAll(chart.series.values);


// Make stuff animate on load
// https://www.amcharts.com/docs/v5/concepts/animations/
chart.appear(1000, 100);

}); // end am5.ready()
</script>


<script>
am5.ready(function() {

// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element 
var root = am5.Root.new("customerChartdiv1");


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
  wheelY: "zoomX",
  maxTooltipDistance: 0
}));


var date = new Date();
date.setHours(0, 0, 0, 0);
var value = 100;

function generateData() {
  value = Math.round((Math.random() * 10 - 4.2) + value);
  am5.time.add(date, "day", 1);
  return {
    date: date.getTime(),
    value: value
  };
}

function generateDatas(count) {
  var data = [];
  for (var i = 0; i < count; ++i) {
    data.push(generateData());
  }
  return data;
}


// Create axes
// https://www.amcharts.com/docs/v5/charts/xy-chart/axes/
var xAxis = chart.xAxes.push(am5xy.DateAxis.new(root, {
  maxDeviation: 0.2,
  baseInterval: {
    timeUnit: "day",
    count: 1
  },
  renderer: am5xy.AxisRendererX.new(root, {}),
  tooltip: am5.Tooltip.new(root, {})
}));

var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
  renderer: am5xy.AxisRendererY.new(root, {})
}));


// Add series
// https://www.amcharts.com/docs/v5/charts/xy-chart/series/
for (var i = 0; i < 5; i++) {
  var series = chart.series.push(am5xy.LineSeries.new(root, {
    name: "Series " + i,
    xAxis: xAxis,
    yAxis: yAxis,
    valueYField: "value",
    valueXField: "date",
    legendValueText: "{valueY}",
    tooltip: am5.Tooltip.new(root, {
      pointerOrientation: "horizontal",
      labelText: "{valueY}"
    })
  }));

  date = new Date();
  date.setHours(0, 0, 0, 0);
  value = 0;

  var data = generateDatas(100);
  series.data.setAll(data);

  // Make stuff animate on load
  // https://www.amcharts.com/docs/v5/concepts/animations/
  series.appear();
}


// Add cursor
// https://www.amcharts.com/docs/v5/charts/xy-chart/cursor/
var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {
  behavior: "none"
}));
cursor.lineY.set("visible", false);

// Add legend
// https://www.amcharts.com/docs/v5/charts/xy-chart/legend-xy-series/
var legend = chart.rightAxesContainer.children.push(am5.Legend.new(root, {
  width: 200,
  paddingLeft: 15,
  height: am5.percent(100)
}));

// When legend item container is hovered, dim all the series except the hovered one
legend.itemContainers.template.events.on("pointerover", function(e) {
  var itemContainer = e.target;

  // As series list is data of a legend, dataContext is series
  var series = itemContainer.dataItem.dataContext;

  chart.series.each(function(chartSeries) {
    if (chartSeries != series) {
      chartSeries.strokes.template.setAll({
        strokeOpacity: 0.15,
        stroke: am5.color(0x000000)
      });
    } else {
      chartSeries.strokes.template.setAll({
        strokeWidth: 3
      });
    }
  })
})

// When legend item container is unhovered, make all series as they are
legend.itemContainers.template.events.on("pointerout", function(e) {
  var itemContainer = e.target;
  var series = itemContainer.dataItem.dataContext;

  chart.series.each(function(chartSeries) {
    chartSeries.strokes.template.setAll({
      strokeOpacity: 1,
      strokeWidth: 1,
      stroke: chartSeries.get("fill")
    });
  });
})

legend.itemContainers.template.set("width", am5.p100);
legend.valueLabels.template.setAll({
  width: am5.p100,
  textAlign: "right"
});

// It's is important to set legend data after all the events are set on template, otherwise events won't be copied
legend.data.setAll(chart.series.values);


// Make stuff animate on load
// https://www.amcharts.com/docs/v5/concepts/animations/
chart.appear(1000, 100);

}); // end am5.ready()
</script>