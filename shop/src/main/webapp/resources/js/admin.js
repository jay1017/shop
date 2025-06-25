
// 카테고리 등록, 수정 화면 : 등록, 수정 시 값이 있는 지 확인
function checkCategory(event) {
	var caname = document.getElementById("caname");
	if (caname.value.trim() == "") {
		alert("값을 비워둘 수 없습니다.");
		event.preventDefault();
	}
}

// 옵션 등록, 수정 화면 : 등록, 수정 시 값이 있는 지 확인
function checkOption(event) {
	var gocolor = document.getElementById("gocolor");
	if (gocolor.value.trim() == "") {
		alert("색상을 입력 하십시오.");
		event.preventDefault();
	}

	var gosize = document.getElementById("gosize");
	if (gosize.value.trim() == "") {
		alert("사이즈를 입력하십시오.");
		event.preventDefault();
	}
}

function deleteMsg(num, url) {
	var con = confirm("정말 삭제하시겠습니까?");
	if (con == true) {
		window.location = url + num;
	}
}