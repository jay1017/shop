//아이디 체크(페이지 화면 출력)
function loginIdCheck() {
	const loginmid = document.getElementById("loginmid").value.trim();
	const loginmidmsg = document.getElementById("loginmidmsg");

	if (loginmid === "") {
		loginmidmsg.textContent = "아이디를 입력하세요.";
		loginmidmsg.style.color = "red";
	} else {
		loginmidmsg.textContent = "";
	}

}

//비밀번호 체크(페이지 화면 출력)
function loginPwCheck() {
	const loginmpw = document.getElementById("loginpw").value.trim();
	const loginmpwmsg = document.getElementById("loginmpwmsg");
	if (loginmpw === "") {
		loginmpwmsg.textContent = "비밀번호를 입력하세요.";
		loginmpwmsg.style.color = "red";
		return;
	} else if (loginmpw.length < 8) {
		loginmpwmsg.textContent = "아이디는 8자 이상입니다.";
		loginmpwmsg.style.color = "red";
		return;
	} else {
		loginmpwmsg.textContent = "";
	}
}