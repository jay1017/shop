function midCheck(){
	const mid = document.getElementById("mid").value.trim();
	const midmsg = document.getElementById("midmsg");
	const Orimid = document.getElementById("Orimid").value.trim();
	
	if(mid === Orimid){
		midmsg.textContent = "아이디가 일치합니다.";
		midmsg.style.color = "green";
	}
	if(mid === ""){
		midmsg.textContent = "아이디를 입력하세요.";
		midmsg.style.color = "red";
		return;
	}else{
		midmsg.textContent = "";
	}
}

function mpwCheck(){
	const mpw = document.getElementById("mpw").value.trim();
	const mpwmsg = document.getElementById("mpwmsg");
	const Orimpw = document.getElementById("Orimpw").value.trim();

	if(mpw === Orimpw){
		mpwmsg.textContent = "비밀번호가 일치합니다.";
		mpwmsg.style.color = "green";
	}
	if(mpw === ""){
		mpwmsg.textContent = "비밀번호를 입력하세요.";
		mpwmsg.style.color = "red";
		return;
	}else if(mpw.length < 8){
		mpwmsg.textContent = "비밀번호는 8자 이상입니다.";
		mpwmsg.style.color = "red";
		return;
	}else{
		mpwmsg.textContent = "";
	}
	
}