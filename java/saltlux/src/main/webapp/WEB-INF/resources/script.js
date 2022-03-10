const toggleButton = document.querySelector('.dark-light');
const colors = document.querySelectorAll('.color');

colors.forEach(color => {
  color.addEventListener('click', e => {
    colors.forEach(c => c.classList.remove('selected'));
    const theme = color.getAttribute('data-color');
    document.body.setAttribute('data-theme', theme);
    color.classList.add('selected');
  });
});

//스트레스 80점 이상 경고
function checkSwear(warningCount, sep){
	// warningCount : 욕설 횟수
	// sep : 상담사 0, 고객 1
	if (warningCount == 1){
		alert("휴식을 취하세요");
	} else if(warningCount==2){
		alert("채팅이 종료되었습니다.");
		const custmoerBtn = document.getElementById("customerInputBtn");
		custmoerBtn.disabled = true;
		
		const counselorBtn = document.getElementById("counselorInputBtn");
		counselorBtn.disabled = true;
	}
}

//욕설 마스킹 처리
function masking(swear_words_arr){
	
	//문장
	var compare_text = $("input[name=customerInput]").val();
	var change = $("input[name=customerInput]").val();
	var check = 0;
	
	for (var i = 0; i < swear_words_arr.length; i++) {
		for (var j = 0; j < (compare_text.length); j++) {
			
			//단어가 같을 경우
			if (swear_words_arr[i] == compare_text.substring(j, (j + swear_words_arr[i].length)).toLowerCase()) {

				//문자열 변환
				console.log("바껴라 얍 : ", change.replaceAll(swear_words_arr[i], "***"));
				change = change.replace(swear_words_arr[i], "***");
				
				check++;
			}
		}
	}
	
	//욕설 없음
	if (check == 0){
		return compare_text;
	} else{
		return change;
	}
}
