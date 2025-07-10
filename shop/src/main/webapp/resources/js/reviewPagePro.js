// 상위 페이지의 loadReviewPage 함수를 호출하는 헬퍼 함수
function loadReviewPageFromContainer(gnum, pageNum) {
    try {
        // 상위 창의 함수 호출 시도
        if (window.parent && window.parent.loadReviewPage) {
            window.parent.loadReviewPage(gnum, pageNum);
        } else if (window.loadReviewPage) {
            window.loadReviewPage(gnum, pageNum);
        } else {
            // 직접 페이지 로딩
            fetch("/shop/review/reviewPagePro.jsp?gnum=" + gnum + "&pageNum=" + pageNum)
                .then(response => response.text())
                .then(html => {
                    const container = document.getElementById("reviewContainer");
                    if (container) {
                        container.innerHTML = html;
                    }
                })
                .catch(err => {
                    console.error("리뷰 로딩 실패:", err);
                });
        }
    } catch(e) {
        console.error('loadReviewPageFromContainer error:', e);
    }
}

// 리뷰 삭제 함수 (reviewPagePro.jsp용) - 매개변수 수정
function deleteReview(rnum, gnum) {
    try {
        // 상위 창의 함수 호출 시도
        if (window.parent && window.parent.deleteReview) {
            window.parent.deleteReview(rnum, gnum);
        } else if (window.deleteReview) {
            window.deleteReview(rnum, gnum);
        } else {
            // 직접 삭제 처리
            if(!confirm('정말로 이 리뷰를 삭제하시겠습니까?')) {
                return;
            }
            
            fetch('/shop/review/reviewDelete.jsp?rnum=' + rnum + '&gnum=' + gnum, {
                method: 'GET'
            })
            .then(response => response.text())
            .then(result => {
                const trimmedResult = result.trim();
                console.log('Delete result:', trimmedResult);
                
                if(trimmedResult === 'OK') {
                    alert('리뷰가 삭제되었습니다.');
                    // 리뷰 목록 새로고침
                    loadReviewPageFromContainer(gnum, 1);
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
        }
    } catch(e) {
        console.error('deleteReview error:', e);
        alert('리뷰 삭제 중 오류가 발생했습니다.');
    }
}

// 리뷰 수정 함수 (reviewPagePro.jsp용)
function editReview(rnum, content) {
    try {
        // 상위 창의 함수 호출 시도
        if (window.parent && window.parent.editReview) {
            window.parent.editReview(rnum, content);
        } else if (window.editReview) {
            window.editReview(rnum, content);
        } else {
            // 직접 수정 처리
            // 기존 내용 숨기기
            document.getElementById('content-' + rnum).style.display = 'none';
            // 수정 폼 보이기
            document.getElementById('edit-form-' + rnum).style.display = 'block';
            // 텍스트 영역에 기존 내용 설정
            var textarea = document.getElementById('edit-content-' + rnum);
            textarea.value = content;
            
            setTimeout(function() {
                textarea.focus();
                textarea.setSelectionRange(textarea.value.length, textarea.value.length);
            }, 10);
        }
    } catch(e) {
        console.error('editReview error:', e);
    }
}

// 수정 취소 함수 (reviewPagePro.jsp용)
function cancelEdit(rnum) {
    try {
        // 상위 창의 함수 호출 시도
        if (window.parent && window.parent.cancelEdit) {
            window.parent.cancelEdit(rnum);
        } else if (window.cancelEdit) {
            window.cancelEdit(rnum);
        } else {
            // 직접 취소 처리
            // 수정 폼 숨기기
            document.getElementById('edit-form-' + rnum).style.display = 'none';
            // 기존 내용 보이기
            document.getElementById('content-' + rnum).style.display = 'block';
        }
    } catch(e) {
        console.error('cancelEdit error:', e);
    }
}

// 수정 저장 함수 (reviewPagePro.jsp용)
function saveEdit(rnum) {
    try {
        // 상위 창의 함수 호출 시도
        if (window.parent && window.parent.saveEdit) {
            window.parent.saveEdit(rnum);
        } else if (window.saveEdit) {
            window.saveEdit(rnum);
        } else {
            // 직접 저장 처리
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
                console.log('Update result:', trimmedResult);
                
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
        }
    } catch(e) {
        console.error('saveEdit error:', e);
        alert('리뷰 수정 중 오류가 발생했습니다.');
    }
}