
// 카테고리 등록, 수정 화면 : 등록, 수정 시 값이 있는 지 확인
function checkCategory(event) {
	var caname = document.getElementById("caname");
	if (caname.value.trim() == "") {
		alert("값을 비워둘 수 없습니다.");
		event.preventDefault();
		return false;
	}
}

// 옵션 등록, 수정 화면 : 등록, 수정 시 값이 있는 지 확인
function checkOption(event) {
	var gocolor = document.getElementById("gocolor");
	if (gocolor.value.trim() == "") {
		alert("색상을 입력 하십시오.");
		event.preventDefault();
		return false;
	}

	var gosize = document.getElementById("gosize");
	if (gosize.value.trim() == "") {
		alert("사이즈를 입력 하십시오.");
		event.preventDefault();
		return false;
	}
}

// 상품 등록, 수정 화면 : 등록, 수정 시 값이 있는 지 확인
function checkGoods1(event) {
	var giname = document.getElementById("giname");
	if (giname.value.trim() == "") {
		alert("대표 이미지를 선택 하십시오.");
		event.preventDefault();
		return false;
	}

	var gidetail1 = document.getElementById("gidetail1");
	if (gidetail1.value.trim() == "") {
		alert("상세 이미지1은 필수 선택 값입니다.");
		event.preventDefault();
		return false;
	}
}
function checkGoods2(event) {
	var gname = document.getElementById("gname");
	if (gname.value.trim() == "") {
		alert("상품명을 입력 하십시오.");
		event.preventDefault();
		return false;
	}

	var gprice = document.getElementById("gprice");
	if (gprice.value.trim() == 0) {
		alert("가격을 입력 하십시오.");
		event.preventDefault();
		return false;
	}
}

// 삭제 공통 메시지
function deleteMsg(num, url) {
	var con = confirm("정말 삭제하시겠습니까?");
	if (con == true) {
		window.location = url + num;
	}
}

// 상품 삭제 메시지
function deleteGoods(num1, num2, num3, url1, url2, url3) {
	var con = confirm("정말 삭제하시겠습니까?");
	if (con == true) {
		window.location = url1 + num1 + url2 + num2 + url3 + num3;
	}
}