//비밀번호 변경시
//페이지화면 비밀번호 확인
function newPwCheck(){
	const pw = document.getElementById("newPw").value.trim();
	const pwch = document.getElementById("newPwCh").value.trim();
	const pwmsg = document.getElementById("pwmsg");
	
	if(pw.length < 8){
		pwmsg.textContent = "비밀번호는 8자 이상입니다.";
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

//비밀번호 변경시
// 설정확인 버튼을 눌렀을때 alert경고창
function sendMpw(){
	const pw = document.getElementById("newPw").value.trim();
	const pwch = document.getElementById("newPwCh").value.trim();
	
	if(pw === ""){
		alert("비밀번호를 입력하세요.");
		pw.focus();
		return false;
	}
	if(pw.length < 8){
			alert("비밀번호는 8자 이상입니다.");
			pw.focus();
			return false;
		}
	if(pwch === ""){
		alert("비밀번호를 확인해주세요.");
		pwch.focus();
		return false;
	}
	
	if(pw !== pwch){
		alert("비밀번호가 일치하지 않습니다.");
		pw.focus();
		return false;
	}else{
		alert("비밀번호가 수정되었습니다.");
		window.opener.document.getElementById("mpw").value = pw;
		window.close();
		return false; //실제로 form에 전송되지 않도록 막음
	}
}

//회원정보 수정 시 비밀번호 변경 팝업창 연결
function updateMpw(){
	window.open("/shop/member/updateMpw.jsp", "비밀번호 변경", "width=500, height=250");
}

//이름 공백 체크(페이지화면 출력)
function namecheck(){
	const mname = document.getElementById("mname").value.trim();
	const namemsg = document.getElementById("namemsg");
	
	if(mname === ""){
		namemsg.textContent = "이름을 입력하세요.";
		namemsg.style.color = "red";
	}else{
		namemsg.textContent = "";
	}
}

//전화번호 형식체크(페이지화면 출력)
function phonecheck() {
	const mphone = document.getElementById("mphone").value.trim();
	const phonemsg = document.getElementById("phonemsg");
	const phoneNum = /^01\d{8,9}$/;

	if (!phoneNum.test(mphone)) {
		phonemsg.textContent = "핸드폰 번호로 입력하세요.(특수문자,공백,문자는 허용되지 않습니다.)";
		phonemsg.style.color = "red";

	} else {
		phonemsg.textContent = "사용가능한 전화번호입니다.";
		phonemsg.style.color = "green";
	}
}

//이메일 형식체크(페이지화면 출력)
function emailcheck() {
	const memail = document.getElementById("memail").value.trim();
	const emailmsg = document.getElementById("emailmsg");
	const emailStr = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if(memail === ""){
		emailmsg.textContent ="";
	}else if (!emailStr.test(memail)) {
		emailmsg.textContent = "올바른 이메일 형식을 사용하세요.";
		emailmsg.style.color = "red";
	} else {
		emailmsg.textContent = "사용 가능한 이메일입니다.";
		emailmsg.style.color = "green";
	}
}

//회원정보 수정시 변경사항 저장을 눌렀을 때
function UpdateMember(){
	const mname = document.getElementById("mname").value.trim();
	const mphone = document.getElementById("mphone").value.trim();
	const memail = document.getElementById("memail").value.trim();
	
}






