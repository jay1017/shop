function selectRadio(value) {
    document.getElementById("gonum1").value = value;
    document.getElementById("gonum2").value = value;
}

function checkLogin(event) {
    var sid = document.getElementById("sid");
    var ccount = document.getElementById("ccount");
    var bcount = document.getElementById("bcount");
    
    var gonum = document.getElementsByName("gonum");
    var gonum1 = document.getElementById("gonum1");
    var gonum2 = document.getElementById("gonum2");
    
    for(var i = 0; i < gonum.length; i++) {
        if(gonum[i].checked) {
            gonum1.value = gonum[i].value;
            gonum2.value = gonum[i].value;
        }
    }
    
    bcount.value = ccount.value;
    
    if(gonum1.value == null || gonum1.value == "" || gonum2.value == null || gonum2.value == "") {
        alert("상품 옵션을 선택 해 주세요.");
        event.preventDefault();
    }
    
    if(sid.value.trim() == 'null') {
        alert("로그인 이후 가능합니다.");
        event.preventDefault();
        location.href="/shop/member/loginForm.jsp";
    }
}

// 리뷰 작성 폼 토글 함수
function toggleReviewForm() {
    const reviewForm = document.getElementById('reviewForm');
    const toggleBtn = document.getElementById('reviewToggleBtn');
    
    if (reviewForm.style.display === 'none') {
        reviewForm.style.display = 'block';
        toggleBtn.textContent = '작성 취소';
        toggleBtn.className = 'btn btn-secondary btn-sm';
    } else {
        reviewForm.style.display = 'none';
        toggleBtn.textContent = '리뷰 작성하기';
        toggleBtn.className = 'btn btn-primary btn-sm';
        // 폼 초기화
        document.getElementById('rcontent').value = '';
    }
}

// 리뷰 작성 취소 함수
function cancelReviewForm() {
    document.getElementById('reviewForm').style.display = 'none';
    document.getElementById('reviewToggleBtn').textContent = '리뷰 작성하기';
    document.getElementById('reviewToggleBtn').className = 'btn btn-primary btn-sm';
    // 폼 초기화
    document.getElementById('rcontent').value = '';
}

// 리뷰 페이지 로딩 함수
function loadReviewPage(gnum, pageNum) {
    fetch("/shop/review/reviewPagePro.jsp?gnum=" + gnum + "&pageNum=" + pageNum)
        .then(response => response.text())
        .then(html => {
            document.getElementById("reviewContainer").innerHTML = html;
        })
        .catch(err => {
            console.error("리뷰 로딩 실패:", err);
            document.getElementById("reviewContainer").innerHTML = '<p style="color: #dc3545;">리뷰를 불러오는 중 오류가 발생했습니다.</p>';
        });
}

// 페이지 로드 시 리뷰 목록 로딩 - 수정된 부분
document.addEventListener("DOMContentLoaded", function () {
    // JSP에서 설정한 전역 변수 사용
    if (typeof window.currentGnum !== 'undefined') {
        loadReviewPage(window.currentGnum, 1);
    } else {
        console.error('gnum이 설정되지 않았습니다.');
        document.getElementById("reviewContainer").innerHTML = '<p style="color: #dc3545;">상품 정보를 불러올 수 없습니다.</p>';
    }
});

// 리뷰 수정 함수
function editReview(rnum, content) {
    try {
        // 기존 내용 숨기기
        document.getElementById('content-' + rnum).style.display = 'none';
        // 수정 폼 보이기
        document.getElementById('edit-form-' + rnum).style.display = 'block';
        // 텍스트 영역에 기존 내용 설정
        var textarea=document.getElementById('edit-content-' + rnum);
        textarea.value=content;
        
        setTimeout(function() { //setTimeOut을 쓰는 이유는 리뷰를 수정할때 기존내용의 맨 끝에 마우스 커서가 자동으로 위치하도록 해야하기 때문입니다  
            textarea.focus();
            textarea.setSelectionRange(textarea.value.length,textarea.value.length);
        },10);    
    } catch(e) {
        console.error('editReview error:', e);
    }
}

// 수정 취소 함수
function cancelEdit(rnum) {
    try {
        // 수정 폼 숨기기
        document.getElementById('edit-form-' + rnum).style.display = 'none';
        // 기존 내용 보이기
        document.getElementById('content-' + rnum).style.display = 'block';
    } catch(e) {
        console.error('cancelEdit error:', e);
    }
}

// 수정 저장 함수
function saveEdit(rnum) {
    try {
        const newContent = document.getElementById('edit-content-' + rnum).value.trim();
        
        if(newContent === '') {
            alert('리뷰 내용을 입력해주세요.');
            return;
        }
        
        // URLSearchParams를 사용하여 파라미터 전송
        const params = new URLSearchParams();
        params.append('rnum', rnum);
        params.append('rcontent', newContent);
        
        fetch('/shop/review/reviewUpdatePro.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: params
        })
        .then(response => response.text())
        .then(result => {
            const trimmedResult = result.trim();
            console.log('Update result:', trimmedResult); // 디버깅용
            
            if(trimmedResult === 'OK') {
                // 성공 시 화면 업데이트
                document.getElementById('content-' + rnum).innerHTML = '<p style="margin: 0; line-height: 1.6; color: #555;">' + newContent.replace(/\n/g, '<br>') + '</p>';
                cancelEdit(rnum);
                alert('리뷰가 수정되었습니다.');
            } else if(trimmedResult === 'NO_PERMISSION') {
                alert('수정 권한이 없습니다.');
            } else if(trimmedResult === 'NOT_LOGGED_IN') {
                alert('로그인이 필요합니다.');
                window.location.href = '/shop/member/loginForm.jsp';
            } else {
                alert('리뷰 수정에 실패했습니다. (' + trimmedResult + ')');
            }
        })
        .catch(error => {
            console.error('saveEdit error:', error);
            alert('리뷰 수정 중 오류가 발생했습니다.');
        });
    } catch(e) {
        console.error('saveEdit error:', e);
        alert('리뷰 수정 중 오류가 발생했습니다.');
    }
}

// 리뷰 삭제 함수
function deleteReview(rnum, gnum) {
    if(!confirm('정말로 이 리뷰를 삭제하시겠습니까?')) {
        return;
    }
    
    try {
        fetch('/shop/review/reviewDelete.jsp?rnum=' + rnum + '&gnum=' + gnum, {
            method: 'GET'
        })
        .then(response => response.text())
        .then(result => {
            const trimmedResult = result.trim();
            console.log('Delete result:', trimmedResult); // 디버깅용
            
            if(trimmedResult === 'OK') {
                alert('리뷰가 삭제되었습니다.');
                // 리뷰 목록 새로고침
                loadReviewPage(gnum, 1);
            } else if(trimmedResult === 'NO_PERMISSION') {
                alert('삭제 권한이 없습니다.');
            } else if(trimmedResult === 'NOT_LOGGED_IN') {
                alert('로그인이 필요합니다.');
                window.location.href = '/shop/member/loginForm.jsp';
            } else {
                alert('리뷰 삭제에 실패했습니다. (' + trimmedResult + ')');
            }
        })
        .catch(error => {
            console.error('deleteReview error:', error);
            alert('리뷰 삭제 중 오류가 발생했습니다.');
        });
    } catch(e) {
        console.error('deleteReview error:', e);
        alert('리뷰 삭제 중 오류가 발생했습니다.');
    }
}