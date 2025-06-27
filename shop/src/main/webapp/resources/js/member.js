//회원정보 수정하기 전 비밀번호를 확인하는 팝업창 연결
function updateMpwCheck(){
	window.open("/shop/member/updateMpwCheck.jsp", "회원정보 수정", "width=500, height=250");
}

//아이디 체크 js (팝업창)
function midCheck() {
	const midInput = document.getElementById("mid");
	const mid = midInput.value.trim();
	
	if(mid === ""){
		alert("아이디를 입력하세요.");
		midInput.focus();
		return;
	}
	
	document.getElementById("butcheck").value = "true";
	
	url = "/shop/member/midCheck.jsp?mid=" + encodeURIComponent(mid); 
	// encodeURIComponent -> 만약 아이디에 특수문자가 입력되었을 때 url주소로 잘못 넘어갈 수 있기에 사용
	window.open(url, "midCheck", "width=400,height=300");
}

//비밀번호 체크 js(페이지화면 출력)
function pwcheck() {
	const pw = document.getElementById("pw").value.trim();
	const pwch = document.getElementById("pwch").value.trim();
	const pwmsg = document.getElementById("pwmsg");

	if (pw.length < 8) {
		pwmsg.textContent = "비밀번호는 최소 8자 이상이어야 합니다.";
		pwmsg.style.color = "red";
		return;
	}
	if (pw === "" || pwch === "") {
		pwmsg.textContent = "비밀번호를 입력하세요.";
		pwmsg.style.color = "red";
		return;
	}
	if (pw !== pwch) {
		pwmsg.textContent = "비밀번호가 일치하지 않습니다.";
		pwmsg.style.color = "red";
	} else {
		pwmsg.textContent = "비밀번호가 일치합니다.";
		pwmsg.style.color = "green";
	}
}

//이름 공백 체크(페이지화면 출력)
function namecheck(){
	const nameEl = document.getElementById("nameEl").value.trim();
	const namemsg = document.getElementById("namemsg");
	
	if(nameEl === ""){
		namemsg.textContent = "이름을 입력하세요.";
		namemsg.style.color = "red";
	}else{
		namemsg.textContent = "";
	}
}

//전화번호 형식체크(페이지화면 출력)
function phonecheck() {
	const phoneEl = document.getElementById("phoneEl").value.trim();
	const phonemsg = document.getElementById("phonemsg");
	const phoneNum = /^01\d{8,9}$/; //010부터 시작하고 숫자7~8자리 뜻함(정규표현식)

	if (!phoneNum.test(phoneEl)) {
		phonemsg.textContent = "핸드폰 번호로 입력하세요.(특수문자,공백,문자는 허용되지 않습니다.)";
		phonemsg.style.color = "red";

	} else {
		phonemsg.textContent = "사용가능한 전화번호입니다.";
		phonemsg.style.color = "green";

	}
}

//이메일 형식체크(페이지화면 출력)
function emailcheck() {
	const emailEl = document.getElementById("emailEl").value.trim();
	const emailmsg = document.getElementById("emailmsg");
	const emailStr = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	//아이디값([a-zA-Z0-9._%+-]+): a~z,A~Z,0~9,일부 특수문자 사용가능,(+)는 하나 이상 필수항목
	//@는 필수
	//주소값([a-zA-Z0-9.-]): a~z,A~Z,0~9,점 및 하이픈 허용,(+)는 하나 이상 필수항목
	//\. -> 점 자체의미 도메인과 확장자 구분 (Ex -> naver.com)
	//확장자[a-zA-Z]{2,} -> 영어만 허용하고 2자이상으로 작성해야함
	if (!emailStr.test(emailEl)) {
		emailmsg.textContent = "올바른 이메일 형식을 사용하세요.";
		emailmsg.style.color = "red";
	} else {
		emailmsg.textContent = "사용 가능한 이메일입니다.";
		emailmsg.style.color = "green";
	}
}

//더블 체크를 하기 위해서 위에선 단순히 글로만 경고문구를 보여 줬지만
//전부 무시하고 가입버튼을 누를수도 있기 때문에 별도로 가입 버튼을 눌렀을 때도 알림창으로 보여주고 다시 회원가입 페이지로 이동함
//각각의 value값에 trim()을 적용하여 공백제거사용
//=== -> 값 뿐만 아닌 형태도 같아야 적용되도록 사용(자동 형변환 방지)
function membercheck() {
	const mid = document.getElementById("mid");
	const pw = document.getElementById("pw");
	const pwch = document.getElementById("pwch");
	const nameEl = document.getElementById("nameEl");
	const phoneEl = document.getElementById("phoneEl");
	const emailEl = document.getElementById("emailEl");
	const phoneNum = /^01\d{8,9}$/;
	const emailStr = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	const butcheck = document.getElementById("butcheck").value;
	if(mid.value.trim() === ""){
		alert("아이디를 입력하세요.");
		mid.focus();
		return false;
	}
	if(butcheck !== "true"){
		alert("아이디 중복확인을 해주세요.");
		mid.focus();
		return false;
	}
	if(pw.value.trim() === ""){
		alert("비밀번호를 입력하세요.");
		pw.focus();
		return false;
	}
	if(pwch.value.trim() === ""){
		alert("비밀번호를 확인하세요.");
		pwch.focus();
		return false;
	}
	if(pw.value.length < 8){
		alert("비밀번호는 8자리 이상입니다.");
		pw.focus();
		return false;
	}
	if(pw.value !== pwch.value){
		alert("비밀번호가 일치하지 않습니다.");
		pw.focus();
		return false;
	}
	if(nameEl.value.trim() === ""){
		alert("이름을 입력하세요.");
		nameEl.focus();
		return false;
	}
	if(phoneEl.value.trim() === ""){
		alert("전화번호를 입력하세요.");
		phoneEl.focus();
		return false;
	}
	if(!phoneNum.test(phoneEl.value.trim())){
		// ▲전화번호 입력값이 해당 형식이 아니라면▲
		alert("번호형식이 올바르지 않습니다. (예: 01012345678)");
		phoneEl.focus();
		return false;
	}
	if(emailEl.value.trim() !== ""){
		if(!emailStr.test(emailEl.value.trim())){
			alert("올바른 이메일 형식을 입력하세요.");
			emailEl.focus();
			return false;
		}
	}
	return true;
}

