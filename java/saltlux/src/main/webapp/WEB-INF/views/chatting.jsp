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
<html>

<head>
    <meta charset="UTF-8">
    <title>Saltlux three jo - Chatting</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel="stylesheet" href="./style.css">

    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <style>
        #counselorChartStress {
            width: 100%;
            height: 230px;
            max-width: 100%;
        }

        #customerChartStress {
            width: 100%;
            height: 230px;
            max-width: 100%;
        }

    </style>

    <!-- highcharts Resources -->
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <!-- Ajax -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>
        // 스트레스 차트값 저장공간
        var counselorStressList = [0];
        var customerStressList = [0];
        var swearCount = 0;

       // 욕설 리스트 불러오기
       var swear_words_arr = new Array();
    </script>

    <script>
        $(document).ready(function() {
           
            // 엔터키 처리
            $("#customerInput").keydown(function(key) {
                if (key.keyCode == 13) {
                    $("#customerInputBtn").click();
                }
            });

            $("#counselorInput").keydown(function(key) {
                if (key.keyCode == 13) {
                    $("#counselorInputBtn").click();
                }
            });

            // 비속어 사전 읽기
            $("#swearList").load("swear_word.txt", function(txt, status) {
                if (status == "success") {
                    txt2 = txt.split("\r\n");
                    var count = 0;
                    for (var i = 0; i < txt2.length; i++) {
                        if (txt2[i] == "\r" || txt2[i] == "\n") {
                            continue;
                        } else {
                            swear_words_arr[count] = txt2[i];
                        }
                        count++;
                    }
                }
            });
        });

    </script>


    <!-- 고객 비동기 요청 -->
    <script>
        $(function() {
            $("#customerInputBtn").click(function() {
               
               // 사용자 구별
               $("#sep").attr("value", <%= request.getParameter("number") %>);
               
                if ($("#customerInput").val() == '') {
                    alert("내용을 입력하세요.")
                } else {
                    req_url = "http://localhost:5000/chatting";
                    var form = $("#form1")[0];
                    var form_data = new FormData(form);
                    
                    // 채팅창 스크롤 관련
                    var isScrollUp = false;
                    var lastScrollTop;
                    var divChat = document.getElementById('div_chat');

                    var now = new Date(); // 현재 날짜 및 시간
                    var hours = now.getHours(); // 시간
                    var minutes = now.getMinutes(); // 분
                    var seconds = now.getSeconds(); // 초

                    function processFile(file) {
                        var reader = new FileReader();
                        reader.onload = function() {
                            output.innerText = reader.result;
                        };
                        reader.readAsText(file, /* optional */ "euc-kr");
                    }

                    // 비동기요청
                    $.ajax({
                        url: req_url,
                        async: true,
                        type: "POST",
                        data: form_data,
                        processData: false,
                        contentType: false,
                        success: function(data) {

                            var stressScore = JSON.parse(data).stress;

                            // 마스킹
                            changeSentence = masking(swear_words_arr)[0];
                            swearCount = masking(swear_words_arr)[1];
                            console.log(changeSentence, swearCount)

                            //욕설 감지, 0 없음, 1 있음
                            if (swearCount == 0) {
                                $("#result").append(
                                    "<div class='chat-msg'>" +
                                       "<div class='chat-msg-profile'>" +
                                          "<img class='chat-msg-img' src='assets/img/girl.png' alt='' />" +
                                          "<div class='chat-msg-date'>" + hours + ":" + minutes + "</div>" +
                                       "</div>" +
                                       "<div class='chat-msg-content'>" +
                                          "<div class='chat-msg-text'>" + changeSentence + "</div>" +
                                       "</div>" +
                                    "</div>");
                            } else {
                                $("#result").append(
                                    "<div class='chat-msg'>" +
                                       "<div class='chat-msg-profile'>" +
                                          "<img class='chat-msg-img' src='assets/img/girl.png' alt='' />" +
                                          "<div class='chat-msg-date'>" + hours + ":" + minutes + "</div>" +
                                       "</div>" +
                                       "<div class='chat-msg-content'>" +
                                          "<div class='chat-msg-text'>" + changeSentence + "</div>" +
                                       "</div>" +
                                   "</div>" +
                                    "<div class='chat-msg' style='width:90%; justify-content: center; margin:0 auto;'>" +
                                       "<div class='chat-msg-content'>" +
                                          "<div class='chat-msg-profile'>" +
                                             "<img class='chat-msg-img' src='assets/img/siren.png' alt=''/ style='margin: 0px 5px 5px 0px; border-radius: 0%;'>" +
                                          "</div>" +
                                          "<div class='chat-msg-text' style='background-color: #FD5F5F; border-radius:20px;'>욕설이 감지되었습니다. 주의하세요. </div>" +
                                         "</div>" +
                                    "</div>");
                            }

                            $("input[name=customerInput]").val("");

                            // 스트레스값을 저장
                            customerStressList.push(stressScore);

                            // 차트에 갱신
                            customerChartStress.update({
                                series: [{
                                    name: 'Stress',
                                    data: customerStressList
                                }]
                            });

                            // 스트레스에 따른 이모티콘
                            var stress = JSON.parse(data).stress;
                            if (stress >= 85) {
                                $('.customerEmoji').attr('src', 'assets/img/angry.png')
                            } else if (stress >= 60) {
                                $('.customerEmoji').attr('src', 'assets/img/sad.png')
                            } else if (stress >= 30) {
                                $('.customerEmoji').attr('src', 'assets/img/soso.png')
                            } else {
                                $('.customerEmoji').attr('src', 'assets/img/smile.png')
                            }

                            // 기본적으로 스크롤 최하단으로 이동 (애니메이션 적용)
                            if (!isScrollUp) {
                                $('#div_chat').animate({
                                    scrollTop: divChat.scrollHeight - divChat.clientHeight
                                }, 100);
                            }
                        },
                        // 애러 발생시 경고창
                        error: function(e) {
                            alert(e);
                        }
                    });
                }
            });
        });

    </script>

    <!-- 상담사 비동기 요청 -->
    <script>
        $(function() {
            $("#counselorInputBtn").click(function() {
               
               // 사용자 구별
               $("#sep2").attr("value", <%= request.getParameter("number") %>);
               
                if ($("#counselorInput").val() == '') {
                    alert("내용을 입력하세요.");
                } else {
                    req_url = "http://localhost:5000/chatting";
                    var form = $("#form2")[0];
                    var form_data = new FormData(form);

                    // 채팅창 스크롤 관련
                    var isScrollUp = false;
                    var lastScrollTop;
                    var divChat = document.getElementById('div_chat');

                    var now = new Date(); // 현재 날짜 및 시간
                    var hours = now.getHours(); // 시간
                    var minutes = now.getMinutes(); // 분
                    var seconds = now.getSeconds(); // 초

                    // 비동기요청
                    $.ajax({
                        url: req_url,
                        async: true,
                        type: "POST",
                        data: form_data,
                        processData: false,
                        contentType: false,
                        success: function(data) {
                            var stressScore = JSON.parse(data).stress;

                            question = $("input[name=counselorInput]").val();
                            $("#result").append(
                                "<div class='chat-msg owner'>" +
                                   "<div class='chat-msg-profile'>" +
                                      "<img class='chat-msg-img' src='assets/img/operator.png' alt='' />" +
                                      "<div class='chat-msg-date'>" + hours + ":" + minutes + "</div>" +
                                   "</div>" +
                                   "<div class='chat-msg-content'>" +
                                      "<div class='chat-msg-text'>" + question + "</div>" +
                                   "</div>" +
                                "</div>");
                            $("input[name=counselorInput]").val("");

                            // 스트레스값을 저장
                            counselorStressList.push(stressScore);

                            // 차트에 갱신
                            counselorChartStress.update({
                                series: [{
                                    name: 'Stress',
                                    data: counselorStressList
                                }]
                            });

                            var stressComment = document.getElementById("comment");
                            
                            // 스트레스에 따른 이모티콘
                            if (stressScore >= 80) {
                                alert("위험이 감지되었습니다. 주의하세요.");
                                $('.counselorEmoji').attr('src', 'assets/img/angry.png');
                                stressComment.innerHTML = "\" 휴식이 필요합니다. 힘내세요. \"";
                            } else if (stressScore >= 60) {
                                $('.counselorEmoji').attr('src', 'assets/img/sad.png');
                            } else if (stressScore >= 30) {
                                $('.counselorEmoji').attr('src', 'assets/img/soso.png');
                                stressComment.innerHTML = "\" 오늘도 좋은하루 되세요. \"";
                            } else {
                                $('.counselorEmoji').attr('src', 'assets/img/smile.png');
                            }

                            // 기본적으로 스크롤 최하단으로 이동 (애니메이션 적용)
                            if (!isScrollUp) {
                                $('#div_chat').animate({
                                    scrollTop: divChat.scrollHeight - divChat.clientHeight
                                }, 100);
                            }
                        },

                        // 애러발생시 경고창
                        error: function(e) {
                            alert(e);
                        }
                    });
                }
            });
        });

    </script>

    <!-- 상세보기 버튼을  눌렀을때 팝업창을 띄움 -->
    <script>
        function openWindowPop(url, name) {
            var options = 'top=10, left=10, width=1200, height=800, status=no, menubar=no, toolbar=no, resizable=no';
            window.open(url, name, options);
        }

    </script>
</head>

<body>
    <!-- partial:index.partial.html -->
    <div class="app">
        <div class="header">
            <h1>
                <a href="/" style="font-size: 30px; margin: 0; line-height: 1; font-weight: 400; letter-spacing: 2px; color: #5777ba; text-decoration: none;">three jo</a>
            </h1>
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
                    </div>
                    <!-- chat-msg owner -->
                    <div id="result"></div>
                </div>
                <!-- chat-area-main -->
                <div class="chat-area-footer">
                    <div id="inputForm1" style="text-align: center;">
                        <form action="#" method="POST" id="form1">
                            <input type="text" name="customerInput" id="customerInput" placeholder="고객 채팅 입력..." />
                            <input type="text" style="display:none;">
                            <input type="button" value="전송" id="customerInputBtn" class="btn btn-primary" style="border: #9F7AEA; background: #9F7AEA " />
                            <input type="hidden" name="sep" id="sep" value="">
                        </form>
                    </div>
                    <div id="inputForm2" style="text-align: center;">
                        <form action="#" method="POST" id="form2">
                            <input type="text" name="counselorInput" id="counselorInput" placeholder="상담사 채팅 입력..." />
                            <input type="text" style="display:none;">
                            <input type="button" value="전송" id="counselorInputBtn" class="btn btn-primary" style="border: #38b2ac; background: #38b2ac" />
                            <input type="hidden" name="sep" id="sep2" value="">
                        </form>
                    </div>
                </div>
                <!-- chat-area-footer -->
            </div>
            <!-- chat-area -->
            <div class="detail-area">
                <div class="detail-area-header" style="align-items: flex-start; margin-bottom: 50px;">
                    <div class="detail-title" style="width: 100%; ">상담사 스트레스 지수
                        <span id="counselorResultEmoji"><img class="counselorEmoji" src="assets/img/soso.png" alt="" style="width:30px; height:30px; margin-left:20px; vertical-align: middle;" /></span>
                        <span id="comment" style="float: right; margin-top: 3.5px; font-size: 16px;">" 오늘도 좋은 하루 되세요. "</span>
                    </div>

                    <figure class="highcharts-figure">
                        <div id="counselorChartStress"></div>
                    </figure>
                </div>
                <div class="detail-area-header" style="align-items: flex-start;">
                    <div class="detail-title">고객 불쾌 지수
                        <span id="customerResultEmoji"><img class="customerEmoji" src="assets/img/soso.png" alt="" style="width:30px; height:30px; margin-left:20px;" /></span>
                    </div>
                    <div class="customerEmoji"></div>
                    <figure class="highcharts-figure">
                        <div id="customerChartStress"></div>
                    </figure>
                </div>
                <br>
                <div class="detail-btn">
                    <a href="javascript:openWindowPop('resultDetail', 'popup');" id="resultDetailBtn" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">결과 상세보기</a>
                </div>
            </div>
        </div>
        <!-- wrapper -->
    </div>
    <!-- app -->
    <!-- partial -->

    <div class="auto_filter"></div>
    <script src="./script.js"></script>

    <%@ include file="./include/footer.jsp" %>

    <!-- Chart setting -->
    <script>
        const counselorChartStress = Highcharts.chart('counselorChartStress', {

            title: {
                text: ''
            },
            credits: {
                enabled: false
            },
            subtitle: {
                text: ''
            },

            yAxis: {
                title: {
                    text: '스트레스 지수'
                },
                max: 100
            },

            xAxis: {
                accessibility: {
                    rangeDescription: 'Range: 2010 to 2017'
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
                text: ''
            },
            credits: {
                enabled: false
            },
            subtitle: {
                text: ''
            },

            yAxis: {
                title: {
                    text: '스트레스 지수'
                },
                max: 100

            },

            xAxis: {
                accessibility: {
                    rangeDescription: 'Range: 2010 to 2017'
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