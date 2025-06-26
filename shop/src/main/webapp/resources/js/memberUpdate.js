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

function sendMpw(){
	const pw = document.getElementById("newPw").value.trim();
	const pwch = document.getElementById("newPwCh").value.trim();
	
	if(pw === "" || pwch === ""){
		alert("비밀번호를 입력하세요.");
		pw.focus();
		return false;
	}
	if(pw.length < 8){
		alert("비밀번호는 8자 이상입니다.");
		pw.focus();
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