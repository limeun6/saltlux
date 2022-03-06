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
  <link rel="stylesheet" href="./popupStyle.css">

<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- Ajax -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
  <!-- amcharts : Comparing Different Date Values Google Analytics Style -->
  <!-- Styles -->
	<style>
	#EmotionSentenceChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	#EmotionSingleChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	#EmotionMultiChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	#EmotionFinalChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	#SensitivitySentenceChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	#SensitivitySingleChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	#SensitivityMultiChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	#SensitivityFinalChart {
	  width: 100%;
  	  height: 280px;
	  max-width: 100%;
	}
	</style>
	
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/series-label.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<script src="https://code.highcharts.com/modules/accessibility.js"></script>
	
	<script src="https://code.highcharts.com/highcharts-3d.js"></script>
	
  
<script>	
	<!-- 비동기요청 -->
	function windowonload(){		
				req_url = "http://localhost:5000/resultDetail";
				var sentence_emotion_list = [0][0];
				var single_emotion_list = [0][0];
				var multi_emotion_list = [0][0];
				var sentence_sentiment_list = [0][0];
				var single_sentiment_list = [0][0];
				var multi_emotion_list = [0][0];
				// 비동기요청
				$.ajax({
					url:req_url,
					async: true,
					type: "GET",
					processData: false,
					contentType: false,
					success: function(data){
						var test = JSON.parse(data)
						// 스트레스값을 저장
						<!-- sentence_emotion_list.push(JSON.parse(data)) -->
						<!--customerStressList.push(JSON.parse(data).Stress); -->
						SentenceEmotion = test.sentence_emotion;
						SentenceSentiment = test.sentence_sentiment;
						SingleEmotion = test.single_emotion;
						SingleSentiment = test.single_sentiment;
						MultiEmotion = test.multi_emotion;
						MultiSentiment = test.multi_sentiment;
						console.log(SentenceEmotion, SentenceSentiment, SingleEmotion,
								SingleSentiment, MultiEmotion, MultiSentiment)
						
						one = SetenceEmotion.number0;
						console.log(one);
						
						// 차트에 갱신

						customerChartStress.update({
							series: [{
								name: 'Stress',
								data: customerStressList
										}]
								});
							},
					// 애러 발생시 경고창
					error: function(e){
					alert(e);
							}
						})

}
window.onload = windowonload;
</script>

</head>
<body>
<!-- partial:index.partial.html -->
<div class="resultDetailAll">
<div class="app">
 <div class="header">
    <h1><a href="/" style="font-size: 30px; margin: 0; line-height: 1; font-weight: 400; letter-spacing: 2px; color: #5777ba;
  text-decoration: none;">three jo</a></h1>
 </div>
 

  <div class="headerTitle"> [ <%= sf1.format(nowTime) %> 감정/감성 분석 결과 ]</div>
  <br>
  <div class="totalresult">
  <div class="area-header-title"> 감정 상세결과 </div>
    <div class="resultContent">
    
 	<div id="b1-1" class="detail-area-header" style="width: 40%; margin:10px;">
    	<div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="EmotionSentenceChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
    </div>
 	
 	<div id="b1-2" class="detail-area-header" style="width: 40%; margin:10px;">
    	<div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="EmotionSingleChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
	</div>
	
	<div id="b1-3" class="detail-area-header" style="width: 40%; margin:0 10px 10px 10px;">
   		<div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="EmotionMultiChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
    </div>
    
    <div id="b1-4" class="detail-area-header" style="width: 40%; margin:0 10px 10px 10px;">
    	<div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="EmotionFinalChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
    </div>
  </div> <!-- resultContent -->
   
   <div id="box2" class="area-header-title"> 감성 상세결과 </div>
    <div class="resultContent">
 	<div id="b2-1" class="detail-area-header" style="width: 40%; margin:10px;">
	    <div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="SensitivitySentenceChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
	</div>
 	
 	<div id="b2-2" class="detail-area-header" style="width: 40%; margin:10px;">
   		<div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="SensitivitySingleChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
    </div>
	
	<div id="b2-3" class="detail-area-header" style="width: 40%; margin:0 10px 10px 10px;">
   		<div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="SensitivityMultiChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
    </div>
    
    <div id="b2-4" class="detail-area-header" style="width: 40%; margin:0 10px 10px 10px;">
   		<div class="detail-title"></div>
			<figure class="highcharts-figure">
			  <div id="SensitivityFinalChart" style="border:1px solid #38b2ac;"></div>
			  <p class="highcharts-description">
			  </p>
			</figure>
    </div>
  </div> <!-- resultContent -->
  
  </div> <!-- totalresult -->
  
</div> <!-- app -->
<!-- partial -->
  <script  src="./script.js"></script>

<%@ include file="./include/footer.jsp" %>

</div>
<!-- Chart code -->
<!-- 감정 문장별 상세결과 -->
<script>
Highcharts.chart('EmotionSentenceChart', {

	  title: {
	    text: '문장별 상세결과'
	  },

	  subtitle: {
	    text: ''
	  },

	  yAxis: {
	    title: {
	      text: 'emotion score'
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
	      pointStart: 2010
	    }
	  },

	  series: [{
	    name: '기쁨',
	    data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
	  }, {
	    name: '행복',
	    data: [24916, 24064, 29742, 29851, 32490, 30282, 138121, 9434]
	  }, {
	    name: '중립',
	    data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
	  }, {
	    name: '분노',
	    data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
	  }, {
	    name: '슬픔',
	    data: [12908, 5948, 8105, 11248, 89089, 11816, 18274, 18111]
	  }, {
		    name: '놀람',
		    data: [12908, 5948, 8105, 1148, 28989, 11816, 15274, 181101]
	  }, {
		    name: '혐오',
		    data: [9208, 5048, 6105, 11248, 18989, 11416, 1874, 18111]
	  }, {
		    name: '상처',
		    data: [3908, 3148, 4805, 7248, 38989, 1816, 7274, 1111]
	  }, {
		    name: '당황',
		    data: [12908, 5948, 8105, 11248, 28989, 11816, 18274, 18111]
	  }, {
		    name: '불안',
		    data: [3908, 5948, 8105, 2248, 4989, 7816, 8274, 1811]
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


<!-- 감정 싱글턴 결과 -->
<script>
Highcharts.chart('EmotionSingleChart', {

	  title: {
	    text: '싱글턴 상세결과'
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
	      pointStart: 2010
	    }
	  },

	  series: [{
		    name: '기쁨',
		    data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
		  }, {
		    name: '행복',
		    data: [24916, 24064, 29742, 29851, 32490, 30282, 138121, 9434]
		  }, {
		    name: '중립',
		    data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
		  }, {
		    name: '분노',
		    data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
		  }, {
		    name: '슬픔',
		    data: [12908, 5948, 8105, 11248, 89089, 11816, 18274, 18111]
		  }, {
			    name: '놀람',
			    data: [12908, 5948, 8105, 1148, 28989, 11816, 15274, 181101]
		  }, {
			    name: '혐오',
			    data: [9208, 5048, 6105, 11248, 18989, 11416, 1874, 18111]
		  }, {
			    name: '상처',
			    data: [3908, 3148, 4805, 7248, 38989, 1816, 7274, 1111]
		  }, {
			    name: '당황',
			    data: [12908, 5948, 8105, 11248, 28989, 11816, 18274, 18111]
		  }, {
			    name: '불안',
			    data: [3908, 5948, 8105, 2248, 4989, 7816, 8274, 1811]
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


<!-- 감정 멀티턴 상세결과 -->
<script>
Highcharts.chart('EmotionMultiChart', {

	  title: {
	    text: '멀티턴 상세결과'
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
	      pointStart: 2010
	    }
	  },

	  series: [{
		    name: '기쁨',
		    data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
		  }, {
		    name: '행복',
		    data: [24916, 24064, 29742, 29851, 32490, 30282, 138121, 9434]
		  }, {
		    name: '중립',
		    data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
		  }, {
		    name: '분노',
		    data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
		  }, {
		    name: '슬픔',
		    data: [12908, 5948, 8105, 11248, 89089, 11816, 18274, 18111]
		  }, {
			    name: '놀람',
			    data: [12908, 5948, 8105, 1148, 28989, 11816, 15274, 181101]
		  }, {
			    name: '혐오',
			    data: [9208, 5048, 6105, 11248, 18989, 11416, 1874, 18111]
		  }, {
			    name: '상처',
			    data: [3908, 3148, 4805, 7248, 38989, 1816, 7274, 1111]
		  }, {
			    name: '당황',
			    data: [12908, 5948, 8105, 11248, 28989, 11816, 18274, 18111]
		  }, {
			    name: '불안',
			    data: [3908, 5948, 8105, 2248, 4989, 7816, 8274, 1811]
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


<!-- 감정 최종 상세결과 -->
<script>
Highcharts.chart('EmotionFinalChart', {
  chart: {
    type: 'pie',
    options3d: {
      enabled: true,
      alpha: 45
    }
  },
  title: {
    text: '최종 상세결과'
  },
  subtitle: {
    text: ''
  },
  plotOptions: {
    pie: {
      innerSize: 100,
      depth: 45
    }
  },
  series: [{
    name: 'Delivered amount',
    data: [
      ['기쁨', 8],
      ['행복', 3],
      ['중립', 5],
      ['분노', 6],
      ['슬픔', 8],
      ['놀람', 4],
      ['혐오', 4],
      ['상처', 1],
      ['당황', 1],
      ['불안', 2]
    ]
  }]
});
</script>


<!-- 감성 문장별 상세결과 -->
<script>
Highcharts.chart('SensitivitySentenceChart', {

	  title: {
	    text: '문장별 상세결과'
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
	      pointStart: 2010
	    }
	  },

	  series: [{
	    name: '긍정',
	    data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
	  }, {
	    name: '부정',
	    data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
	  }, {
	    name: '중립',
	    data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
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


<!-- 감성 싱글턴 상세결과 -->
<script>
Highcharts.chart('SensitivitySingleChart', {

	  title: {
	    text: '싱글턴 상세결과'
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
	      pointStart: 2010
	    }
	  },

	  series: [{
		    name: '긍정',
		    data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
		  }, {
		    name: '부정',
		    data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
		  }, {
		    name: '중립',
		    data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
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


<!-- 감성 멀티턴 상세결과 -->
<script>
Highcharts.chart('SensitivityMultiChart', {

	  title: {
	    text: '멀티턴 상세결과'
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
	      pointStart: 2010
	    }
	  },

	  series: [{
		    name: '긍정',
		    data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
		  }, {
		    name: '부정',
		    data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
		  }, {
		    name: '중립',
		    data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
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

<!--  감성 최종 상세결과 -->
<script>
Highcharts.chart('SensitivityFinalChart', {
  chart: {
    type: 'pie',
    options3d: {
      enabled: true,
      alpha: 45
    }
  },
  title: {
    text: '최종 상세결과'
  },
  subtitle: {
    text: ''
  },
  plotOptions: {
    pie: {
      innerSize: 100,
      depth: 45
    }
  },
  series: [{
    name: 'Delivered amount',
    data: [
      ['긍정', 8],
      ['부정', 3],
      ['중립', 10]
    ]
  }]
});
</script>
