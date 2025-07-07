function enableEdit(rnum, mname) {
    const content = document.getElementById('rcontent-' + rnum).innerText;
    const reviewDiv = document.getElementById('review-' + rnum);
    const gnum = new URLSearchParams(window.location.search).get('gnum');

    reviewDiv.innerHTML = `
        <form action="/shop/review/reviewUpdatePro.jsp" method="post">
            <input type="hidden" name="rnum" value="${rnum}">
            <input type="hidden" name="gnum" value="${gnum}">
            <textarea name="rcontent" rows="3" cols="50">${content}</textarea><br>
            <button type="submit">저장</button>
            <button type="button" onclick="cancelEdit(${rnum}, \`${content}\`, '${mname}')">취소</button>
        </form>
    `;
}

function cancelEdit(rnum, content, mname) {
    const reviewDiv = document.getElementById('review-' + rnum);
    reviewDiv.innerHTML = `
        <p>
            <strong>${mname}</strong><br>
            <span id="rcontent-${rnum}">${content}</span>
        </p>
        <button onclick="enableEdit(${rnum}, '${mname}')">수정</button>
    `;
}

/*리뷰 수정 시 사용*/

