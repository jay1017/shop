//아이디 체크 js (팝업창)
function midcheck() {
	mid = document.getElementById("mid").value;
	url = "/shopping/member/midcheck.jsp?mid=" + mid;
	open(url, "midcheck", "width=400,height=300");
}

//비밀번호 체크 js(페이지화면 출력)
function pwcheck(){
	const pw = document.getElementById("pw").value.trim();
	const pwch = document.getElementById("pwch").value.trim();
	const pwmsg = document.getElementById("pwmsg");
	
	if(pw.length < 8){
		pwmsg.textContent = "비밀번호는 최소 8자 이상이어야 합니다.";
		pwmsg.style.color = "red";
		return;
	}
	if(pw === "" || pwch === ""){
		pwmsg.textContent = "비밀번호를 입력하세요.";
		pwmsg.style.color = "red";
		return;
	}
	if(pw !== pwch){
		pwmsg.textContent = "비밀번호가 일치하지 않습니다.";
		pwmsg.style.color = "red";
	}else{
		pwmsg.textContent = "비밀번호가 일치합니다.";
		pwmsg.style.color = "green";
	}
}

//전화번호 형식체크(페이지화면 출력)
function phonecheck(){
	const phoneEl = document.getElementById("phoneEl").value.trim();
	const phonemsg = document.getElementById("phonemsg");
	const phoneNum = /^010\d{7,8}$/; //010부터 시작하고 숫자7~8자리 뜻함(정규표현식)
	
	if(!phoneNum.test(phoneEl)){
		phonemsg.textContent = "010전화번호 형식으로 입력하세요.(특수문자,공백,문자는 허용되지 않습니다.)";
		phonemsg.style.color = "red";
		
	}else{
		phonemsg.textContent = "사용가능한 전화번호입니다.";
		phonemsg.style.color="green";
		
	}
}

//이메일 형식체크(페이지화면 출력)
function emailcheck(){
	const emailEl = document.getElementById("emailEl").value.trim();
	const emailmsg = document.getElementById("emailmsg");
	const emailStr = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	//아이디값([a-zA-Z0-9._%+-]+): a~z,A~Z,0~9,일부 특수문자 사용가능,(+)는 하나 이상 필수항목
	//@는 필수
	//주소값([a-zA-Z0-9.-]): a~z,A~Z,0~9,점 및 하이픈 허용,(+)는 하나 이상 필수항목
	//\. -> 점 자체의미 도메인과 확장자 구분 (Ex -> naver.com)
	//확장자[a-zA-Z]{2,} -> 영어만 허용하고 2자이상으로 작성해야함
	if(!emailStr.test(emailEl)){
		emailmsg.textContent = "올바른 이메일 형식을 사용하세요.";
		emailmsg.style.color = "red";
	}else{
		emailmsg.textContent = "사용 가능한 이메일입니다.";
		emailmsg.style.color = "green";
	}
}

//빈 공백으로 둘 경우 가입 버튼을 눌렀을 때 alert창으로 경고메세지 보여줌
//각각의 value값에 trim()을 적용하여 공백제거사용
//=== -> 값 뿐만 아닌 형태도 같아야 적용되도록 사용(자동 형변환 방지)
function membercheck(){
	const nameEl = document.getElementById("nameEl");
	const phoneEl = document.getElementById("phoneEl");
	const emailEl = document.getElementById("emailEl");
	if(nameEl.value.trim() === ""){
		alert("이름을 입력하세요.");
		nameEl.focus();
		return false;
	}else if(phoneEl.value.trim() === ""){
		alert("전화번호를 입력하세요.");
		phoneEl.focus();
		return false;
	}else if(emailEl.value.trim() === ""){
		alert("이메일을 입력하세요.");
		emailEl.focus();
		return false;
	}
	return true;
}

