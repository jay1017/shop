// 주소 찾기 API 붙히기
function zipFind() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("address3").value = extraAddr;

			} else {
				document.getElementById("address3").value = '';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('zip').value = data.zonecode;
			document.getElementById("address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("address2").focus();
		}
	}).open();
}

// 쿠폰 변경 이벤트
let priceBuy = 0;
function cpnumChange() {
	// 쿠폰 번호
	const cpnum = document.getElementById("cpnum").value;
	// 변경 전 가격(input)
	const before_price = document.getElementById("before_price");
	// 카카오로 보내줄 가격(input)
	const total_amount = document.getElementById("total_amount");
	// 사용자에게 보여주는 변경 전 가격과 변경 후 가격
	const before_total_amount = document.getElementById("before_total_amount");
	const after_total_amount = document.getElementById("after_total_amount");
	const total_amount_wrap = document.getElementById("total_amount_wrap");
	const won = document.getElementById("won");

	let paramPrice = 0;

	if (priceBuy == 0) {
		paramPrice = before_price.value;
	} else {
		paramPrice = priceBuy;
	}
	if (cpnum != 0) {
		fetch("/shop/buy/coupon.jsp?cpnum=" + cpnum + "&total=" + paramPrice)
			.then(response => response.json())
			.then(data => {
				before_total_amount.classList.add("cancle");
				total_amount.value = data.total_amount;
				total_amount_wrap.style.display = "block";
				after_total_amount.innerHTML = "&#8361;" + data.total_amount.toLocaleString('ko-KR');
				priceBuy = data.total_amount;
			})
			.catch(error => {
				console.error("쿠폰 계산 오류:", error);
				alert("쿠폰 적용 중 오류가 발생했습니다:\n" + error.message);
			});
	} else {
		before_total_amount.classList.remove("cancle");
		after_total_amount.innerHTML = "";
		total_amount.value = before_price.value;
	}
}

// 유효성 검사
function checkBuy(event) {
	var address = document.getElementById("address");
	if (address.value == null || address.value == "") {
		alert("주소를 입력 하세요");
		event.preventDefault();
		return false;
	}
	var accessOrder = document.getElementById("accessOrder");
	if (!accessOrder.checked) {
		alert("상품 구매에 동의 해 주세요.");
		event.preventDefault();
		return false;
	}
}

//포인트 사용 계산식(쿠폰 포함)
function selectPoint() {
	const pointInput = document.getElementById("minusPoint");
	const hiddenPoint = document.getElementById("allpoint");
	const appliedPoint = document.getElementById("applied_point");
	const applyBtn = document.getElementById("pointApplyBtn"); // 버튼 DOM 가져오기

	const point = parseInt(pointInput.value.trim().replace(/[^0-9]/g, ""), 10);
	const available = parseInt(hiddenPoint.value.trim(), 10);

	const total_amount = document.getElementById("total_amount");
	const before_total_amount = document.getElementById("before_total_amount");
	const after_total_amount = document.getElementById("after_total_amount");
	const total_amount_wrap = document.getElementById("total_amount_wrap");

	const before_price = parseInt(document.getElementById("before_price").value, 10);

	let paramPrice = 0;

	if (priceBuy == 0) {
		paramPrice = before_price;
	} else {
		paramPrice = priceBuy;
	}

	if (isNaN(point) || point <= 0) {
		alert("사용할 포인트를 입력하세요.");
		return;
	}

	if (point > available) {
		alert("포인트는 " + available + "원까지만 사용 가능합니다.");
		pointInput.value = "";
		return;
	}

	let finalAmount = paramPrice - point;
	if (finalAmount < 0) finalAmount = 0;

	appliedPoint.value = point;
	total_amount.value = finalAmount;
	total_amount_wrap.style.display = "block";
	after_total_amount.innerText = `₩${finalAmount.toLocaleString()}`;
	before_total_amount.classList.add("cancle");

	// ✅ 버튼 비활성화
	applyBtn.disabled = true;
	applyBtn.classList.add("disabled"); // 필요 시 시각적 효과용
	priceBuy = finalAmount;
}

