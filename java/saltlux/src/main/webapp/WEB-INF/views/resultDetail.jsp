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
		// 감정 - 문장
		var sentenceEmotionAnger = [];
		var sentenceEmotionSad = [];
		var sentenceEmotionSurprise = [];
		var sentenceEmotionHurt = [];
		var sentenceEmotionPanic = [];
		var sentenceEmotionAnxiety = [];
		var sentenceEmotionJoy = [];
		var sentenceEmotionNeutrality = [];
		
		// 감정 - 싱글턴
		var singleEmotionAnger = [];
		var singleEmotionSad = [];
		var singleEmotionSurprise = [];
		var singleEmotionHurt = [];
		var singleEmotionPanic = [];
		var singleEmotionAnxiety = [];
		var singleEmotionJoy = [];
		var singleEmotionNeutrality = [];
		
		// 감정 - 멀티턴
		var multiEmotionAnger = [];
		var multiEmotionSad = [];
		var multiEmotionSurprise = [];
		var multiEmotionHurt = [];
		var multiEmotionPanic = [];
		var multiEmotionAnxiety = [];
		var multiEmotionJoy = [];
		var multiEmotionNeutrality = [];
		
		// 감정 - 최종
		var EmotionResult = [];
		
		// 감성 - 문장별
		var sentenceSentimentPositive = [];
		var sentenceSentimentNegative = [];
		var sentenceSentimentMiddle = [];
		
		// 감성 - 싱글턴
		var singleSentimentPositive = [];
		var singleSentimentNegative = [];
		var singleSentimentMiddle = [];
		
		// 감성 - 멀티턴
		var multiSentimentPositive = [];
		var multiSentimentNegative = [];
		var multiSentimentMiddle = [];
		
		// 감성 - 최종
		var SentimentResult = [];
		
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
				AllEmotion = test.all_emotion;
				AllSentiment = test.all_sentiment;
				console.log(SentenceEmotion, SentenceSentiment, SingleEmotion,
						SingleSentiment, MultiEmotion, MultiSentiment,
						AllEmotion, AllSentiment);
				
				//one = SentenceEmotion.number0;
				//console.log(one);
				// console.log(SentenceEmotion.number0.emotion.anger);
				
				// 감정 - 문장별
				for(var ele in SentenceEmotion){
					for(var ele2 in SentenceEmotion[ele]){
						// console.log(SentenceEmotion[ele][ele2].anger);
						sentenceEmotionAnger.push(SentenceEmotion[ele][ele2].anger);
						sentenceEmotionSad.push(SentenceEmotion[ele][ele2].sad);
						sentenceEmotionSurprise.push(SentenceEmotion[ele][ele2].surprise);
						sentenceEmotionHurt.push(SentenceEmotion[ele][ele2].hurt);
						sentenceEmotionPanic.push(SentenceEmotion[ele][ele2].panic);
						sentenceEmotionAnxiety.push(SentenceEmotion[ele][ele2].anxiety);
						sentenceEmotionJoy.push(SentenceEmotion[ele][ele2].joy);
						sentenceEmotionNeutrality.push(SentenceEmotion[ele][ele2].neutrality);
					}
				}
				
				// 감정 - 싱글턴
				for(var ele in SingleEmotion){
					for(var ele2 in SingleEmotion[ele]){
						singleEmotionAnger.push(SingleEmotion[ele][ele2].anger);
						singleEmotionSad.push(SingleEmotion[ele][ele2].sad);
						singleEmotionSurprise.push(SingleEmotion[ele][ele2].surprise);
						singleEmotionHurt.push(SingleEmotion[ele][ele2].hurt);
						singleEmotionPanic.push(SingleEmotion[ele][ele2].panic);
						singleEmotionAnxiety.push(SingleEmotion[ele][ele2].anxiety);
						singleEmotionJoy.push(SingleEmotion[ele][ele2].joy);
						singleEmotionNeutrality.push(SingleEmotion[ele][ele2].neutrality);
					}
				}
				
				// 감정 - 멀티턴
				for(var ele in MultiEmotion){
					for(var ele2 in MultiEmotion[ele]){
						multiEmotionAnger.push(MultiEmotion[ele][ele2].anger);
						multiEmotionSad.push(MultiEmotion[ele][ele2].sad);
						multiEmotionSurprise.push(MultiEmotion[ele][ele2].surprise);
						multiEmotionHurt.push(MultiEmotion[ele][ele2].hurt);
						multiEmotionPanic.push(MultiEmotion[ele][ele2].panic);
						multiEmotionAnxiety.push(MultiEmotion[ele][ele2].anxiety);
						multiEmotionJoy.push(MultiEmotion[ele][ele2].joy);
						multiEmotionNeutrality.push(MultiEmotion[ele][ele2].neutrality);
					}
				}
				
				// 감정 - 최종
			
				
					angry = ['분노', AllEmotion.emotion.anger];
					EmotionResult.push(angry);
					sad = ['슬픔', AllEmotion.emotion.sad];
					EmotionResult.push(sad);
					surprise = ['놀람', AllEmotion.emotion.surprise];
					EmotionResult.push(surprise);
					hurt = ['상처', AllEmotion.emotion.hurt];
					EmotionResult.push(hurt);
					panic = ['당황', AllEmotion.emotion.panic];
					EmotionResult.push(panic);
					anxiety = ['불안', AllEmotion.emotion.anxiety];
					EmotionResult.push(anxiety);
					joy = ['기쁨', AllEmotion.emotion.joy];
					EmotionResult.push(joy);
					neutrality = ['중립', AllEmotion.emotion.neutrality];
					EmotionResult.push(neutrality);
					console.log(EmotionResult);
					
					
				// 감성 - 문장별
				for(var ele in SentenceSentiment){
					for(var ele2 in SentenceSentiment[ele]){
						console.log(SentenceSentiment[ele][ele2].anger);
						sentenceSentimentPositive.push(SentenceSentiment[ele][ele2].positive);
						sentenceSentimentNegative.push(SentenceSentiment[ele][ele2].negative);
						sentenceSentimentMiddle.push(SentenceSentiment[ele][ele2].middle);
					}
				}
				
				// 감성 - 싱글턴
				for(var ele in SingleSentiment){
					for(var ele2 in SingleSentiment[ele]){
						singleSentimentPositive.push(SingleSentiment[ele][ele2].positive);
						singleSentimentNegative.push(SingleSentiment[ele][ele2].negative);
						singleSentimentMiddle.push(SingleSentiment[ele][ele2].middle);
					}
				}
				
				// 감성 - 멀티턴
				for(var ele in MultiSentiment){
					for(var ele2 in MultiSentiment[ele]){
						multiSentimentPositive.push(MultiSentiment[ele][ele2].positive);
						multiSentimentNegative.push(MultiSentiment[ele][ele2].negative);
						multiSentimentMiddle.push(MultiSentiment[ele][ele2].middle);
					}
				}
				
				// 감성 - 최종
					positive = ['긍정', AllSentiment.sentiment.positive];
					SentimentResult.push(positive);
					negative = ['부정', AllSentiment.sentiment.negative];
					SentimentResult.push(negative);
					middle = ['중립', AllSentiment.sentiment.middle];
					SentimentResult.push(middle);
				
				// 차트에 갱신 - 감정 문장별
				EmotionSentenceChart.update({
					series: [{
						name: '분노',
						data: sentenceEmotionAnger
					  }, {
					    name: '슬픔',
					    data: sentenceEmotionSad
					  }, {
					    name: '놀람',
					    data: sentenceEmotionSurprise
					  },{
					    name: '상처',
					    data: sentenceEmotionHurt
					  }, {
					    name: '당황',
					    data: sentenceEmotionPanic
					  }, {
					    name: '불안',
					    data: sentenceEmotionAnxiety
					  }, {
					    name: '기쁨',
					    data: sentenceEmotionJoy
					  },{
					    name: '중립',
					    data:sentenceEmotionNeutrality
					  }]
				});
				
				// 차트에 갱신 - 감정 싱글턴
				EmotionSingleChart.update({
					series: [{
						name: '분노',
						data: singleEmotionAnger
					  }, {
					    name: '슬픔',
					    data: singleEmotionSad
					  }, {
					    name: '놀람',
					    data: singleEmotionSurprise
					  },{
					    name: '상처',
					    data: singleEmotionHurt
					  }, {
					    name: '당황',
					    data: singleEmotionPanic
					  }, {
					    name: '불안',
					    data: singleEmotionAnxiety
					  }, {
					    name: '기쁨',
					    data: singleEmotionJoy
					  },{
					    name: '중립',
					    data: singleEmotionNeutrality
					  }]
				});
				
				// 차트에 갱신 - 감정 멀티턴
				EmotionMultiChart.update({
					series: [{
						name: '분노',
						data: multiEmotionAnger
					  }, {
					    name: '슬픔',
					    data: multiEmotionSad
					  }, {
					    name: '놀람',
					    data: multiEmotionSurprise
					  },{
					    name: '상처',
					    data: multiEmotionHurt
					  }, {
					    name: '당황',
					    data: multiEmotionPanic
					  }, {
					    name: '불안',
					    data: multiEmotionAnxiety
					  }, {
					    name: '기쁨',
					    data: multiEmotionJoy
					  },{
					    name: '중립',
					    data: multiEmotionNeutrality
					  }]
				});
				
				// 차트에 갱신 - 감정 최종
				EmotionFinalChart.update({
					series: [{
						name: 'EmotionResult',
						data: EmotionResult
					  }]
				});
				
				// 차트에 갱신 - 감성 대화별
				SensitivitySentenceChart.update({
					series: [{
						name: '긍정',
						data: sentenceSentimentPositive
					  }, {
					    name: '부정',
					    data: sentenceSentimentNegative
					  }, {
					    name: '중립',
					    data: sentenceSentimentMiddle
					  }]
				});
				
				// 차트에 갱신 - 감성 싱글턴
				SensitivitySingleChart.update({
					series: [{
						name: '긍정',
						data: singleSentimentPositive
					  }, {
					    name: '부정',
					    data: singleSentimentNegative
					  }, {
					    name: '중립',
					    data: singleSentimentMiddle
					  }]
				});
				
				// 차트에 갱신 - 감성 멀티턴
				SensitivityMultiChart.update({
					series: [{
						name: '긍정',
						data: multiSentimentPositive
					  }, {
					    name: '부정',
					    data: multiSentimentNegative
					  }, {
					    name: '중립',
					    data: multiSentimentMiddle
					  }]
				});
				
				// 차트에 갱신 - 감성 최종
				SensitivityFinalChart.update({
					series: [{
						name: 'SentimentResult',
						data: SentimentResult
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
const EmotionSentenceChart = Highcharts.chart('EmotionSentenceChart', {
	  title: {
	    text: '문장별 상세결과'
	  },
	  credits: {enabled: false},
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
	      rangeDescription: 'Range: 1 to 30'
	    },
        tickInterval: 1
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
		    name: '분노',
		    data: [0]
	  }, {
		    name: '슬픔',
		    data: [0]
		  }, {
		    name: '놀람',
		    data: [0]
		  },{
		    name: '상처',
		    data: [0]
		  }, {
		    name: '당황',
		    data: [0]
		  }, {
		    name: '불안',
		    data: [0]
		  }, {
		    name: '기쁨',
		    data: [0]
		  },{
		    name: '중립',
		    data: [0]
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
const EmotionSingleChart = Highcharts.chart('EmotionSingleChart', {

	  title: {
	    text: '싱글턴 상세결과'
	  },
	  credits: {enabled: false},
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
	      rangeDescription: 'Range: 1 to 30'
	    },
        tickInterval: 1
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
		    name: '분노',
		    data: [0]
	  }, {
		    name: '슬픔',
		    data: [0]
		  }, {
		    name: '놀람',
		    data: [0]
		  },{
		    name: '상처',
		    data: [0]
		  }, {
		    name: '당황',
		    data: [0]
		  }, {
		    name: '불안',
		    data: [0]
		  }, {
		    name: '기쁨',
		    data: [0]
		  },{
		    name: '중립',
		    data: [0]
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
const EmotionMultiChart = Highcharts.chart('EmotionMultiChart', {

	  title: {
	    text: '멀티턴 상세결과'
	  },
	  credits: {enabled: false},
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
	      rangeDescription: 'Range: 1 to 30'
	    },
        tickInterval: 1
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
		    name: '분노',
		    data: [0]
	  }, {
		    name: '슬픔',
		    data: [0]
		  }, {
		    name: '놀람',
		    data: [0]
		  }, {
		    name: '상처',
		    data: [0]
		  }, {
		    name: '당황',
		    data: [0]
		  }, {
		    name: '불안',
		    data: [0]
		  }, {
		    name: '기쁨',
		    data: [0]
		  }, {
		    name: '중립',
		    data: [0]
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
const EmotionFinalChart = Highcharts.chart('EmotionFinalChart', {
  chart: {
    type: 'pie',
    options3d: {
      enabled: true,
      alpha: 45
    }
  },
  credits: {enabled: false},
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
    name: 'EmotionResult',
    data: [
      ['분노', 0],
      ['슬픔', 0],
      ['놀람', 0],
      ['상처', 0],
      ['당황', 0],
      ['불안', 0],
      ['기쁨', 0],
      ['중립', 0]
    ]
  }]
});
</script>


<!-- 감성 문장별 상세결과 -->
<script>
const SensitivitySentenceChart = Highcharts.chart('SensitivitySentenceChart', {

	  title: {
	    text: '문장별 상세결과'
	  },
	  credits: {enabled: false},
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
	      rangeDescription: 'Range: 1 to 30'
	    },
        tickInterval: 1
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
	    name: '긍정',
	    data: [0]
	  }, {
	    name: '부정',
	    data: [0]
	  }, {
	    name: '중립',
	    data: [0]
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
const SensitivitySingleChart = Highcharts.chart('SensitivitySingleChart', {

	  title: {
	    text: '싱글턴 상세결과'
	  },
	  credits: {enabled: false},
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
	      rangeDescription: 'Range: 1 to 30'
	    },
        tickInterval: 1
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
		    name: '긍정',
		    data: [0]
		  }, {
		    name: '부정',
		    data: [0]
		  }, {
		    name: '중립',
		    data: [0]
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
const SensitivityMultiChart = Highcharts.chart('SensitivityMultiChart', {

	  title: {
	    text: '멀티턴 상세결과'
	  },
	  credits: {enabled: false},
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
	      rangeDescription: 'Range: 1 to 30'
	    },
        tickInterval: 1
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
		    name: '긍정',
		    data: [0]
		  }, {
		    name: '부정',
		    data: [0]
		  }, {
		    name: '중립',
		    data: [0]
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
const SensitivityFinalChart = Highcharts.chart('SensitivityFinalChart', {
  chart: {
    type: 'pie',
    options3d: {
      enabled: true,
      alpha: 45
    }
  },
  credits: {enabled: false},
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
    name: 'SentimentResult',
    data: [
      ['긍정', 0],
      ['부정', 0],
      ['중립', 0]
    ]
  }]
});
</script>
