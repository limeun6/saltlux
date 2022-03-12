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

//욕설 마스킹 처리
function masking(swear_words_arr){

	var check = 0;
	
	//문장
	var compare_text = $("input[name=customerInput]").val();
	var change = $("input[name=customerInput]").val();
	
	for (var i = 0; i < swear_words_arr.length; i++) {
		for (var j = 0; j < (compare_text.length); j++) {
			
			//단어가 같을 경우
			if (swear_words_arr[i] == compare_text.substring(j, (j + swear_words_arr[i].length)).toLowerCase()) {

				//문자열 변환
				change = change.replace(swear_words_arr[i], "***");
				check = 1;
			}
		}
	}
	
	//욕설 없음
	if (check == 0) {
		return [compare_text, check];
	} else {
		return [change, check];
	}
}

