// 전역 변수 생성
let idx = 0;
let idx2 = 0;
let idx3 = 0;

// 질문을 찾아주는 메소드
function findQuestion(cate, button) {
	// 사용자가 클릭한 내용 출력
	const chatbox = document.getElementById("chat-box");
	const user = document.createElement("div");
	const category = cate;
	user.classList.add('user-message');
	user.innerHTML = category;
	chatbox.appendChild(user);

	// 사용자가 누르면 버튼 비활성화
	const msg = document.getElementById("msgType");
	const mc = msg.childNodes;
	for (let i = 0; i < mc.length; i++) {
		button.classList.add('hide');
		button.nextElementSibling.classList.add('hide');
	}

	// 사용자가 클릭한 내용을 토대로 조회
	setTimeout(function() {
		fetch('/shop/chat/findQuestion.jsp?type=' + encodeURIComponent(category))
			.then(res => res.json())
			.then(data => {
				// 감싸주는 div 생성
				const msgType = document.createElement("div");
				msgType.id = "msgType" + idx;
				chatbox.appendChild(msgType);

				const div = document.getElementById("msgType" + idx);
				// 돌아가기 버튼 생성
				const back = document.createElement("button");
				back.innerHTML = "처음 메뉴로 돌아가기";
				back.classList.add('primary-btn');
				back.classList.add('chatbotBtn');
				back.classList.add('mr-2');
				back.onclick = () => backMenu(back);
				div.appendChild(back);

				// btn 생성
				for (let i = 0; i < data.length; i++) {
					const btn = document.createElement("button");
					const question = data[i].question;
					btn.innerHTML = question;
					btn.onclick = () => findAnswer(question, category);
					btn.classList.add('primary-btn');
					btn.classList.add('chatbotBtn');
					btn.classList.add('mr-2');
					div.appendChild(btn);
				}

				idx++;
			})
			.catch(err => {
				alert("데이터를 불러오지 못했습니다.");
				console.error(err);
			});
	}, 500);

	setTimeout(function() {
		chatbox.scrollTop = chatbox.scrollHeight;
	}, 1000);
}

// 처음으로 돌아가는 버튼
function backMenu(back) {
	const chatbox = document.getElementById("chat-box");
	const msgType = document.getElementById("msgType");
	const backMenu = back.innerHTML;

	// 보낸 내용 대입
	setTimeout(function() {
		const sendMsg = document.createElement("div");
		sendMsg.classList.add("user-message");
		sendMsg.innerHTML = backMenu;
		chatbox.appendChild(sendMsg);
	}, 500);

	setTimeout(function() {
		// 원래 메뉴 대입
		const div = document.createElement("div");
		div.id = "backMenu" + idx3;
		let child = msgType.childNodes;
		for (let i = 0; i < child.length; i++) {
			div.appendChild(child[i].cloneNode(true));
		}
		chatbox.appendChild(div);

		// 사용자의 버튼 활성화
		const backMenu = document.getElementById("backMenu" + idx3);
		const backBtn = backMenu.querySelectorAll('.hide');
		for (let i = 0; i < backBtn.length; i++) {
			backBtn[i].classList.remove('hide');
		}
		idx3++;
	}, 1000);
}

// 답변을 찾아주는 함수
function findAnswer(question, category) {
	// 사용자가 클릭한 내용 출력
	const chatbox = document.getElementById("chat-box");
	const user = document.createElement("div");
	user.classList.add('user-message');
	user.innerHTML = question;
	chatbox.appendChild(user);

	// 사용자가 누르면 버튼 비활성화
	const msg = document.getElementById("msgType" + (idx - 1));
	const mc = msg.childNodes;
	for (let i = 0; i < mc.length - 1; i++) {
		mc[i].classList.add('hide');
		mc[i].nextElementSibling.classList.add('hide');
	}

	// 사용자가 클릭한 내용을 토대로 조회
	setTimeout(function() {
		fetch('/shop/chat/findAnswer.jsp?question=' + encodeURIComponent(question) + '&type=' + encodeURIComponent(category))
			.then(res => res.json())
			.then(data => {
				// 감싸주는 div 생성
				const msgType = document.createElement("div");
				msgType.id = "msgTypes" + idx2;
				chatbox.appendChild(msgType);
				const div = document.getElementById("msgTypes" + idx2);

				// btn 생성
				for (let i = 0; i < data.length; i++) {
					const ans = document.createElement("div");
					const answer = data[i].answer;
					ans.innerHTML = answer;
					ans.classList.add("bot-message");
					div.appendChild(ans);
				}

				// 돌아가기 버튼 생성
				const back = document.createElement("button");
				back.innerHTML = "처음 메뉴로 돌아가기";
				back.classList.add('primary-btn');
				back.classList.add('chatbotBtn');
				back.classList.add('mr-2');
				back.onclick = () => backMenu(back);
				div.appendChild(back);

				idx2++;
			})
			.catch(err => {
				alert("데이터를 불러오지 못했습니다.");
				console.error(err);
			});
	}, 500);

	setTimeout(function() {
		chatbox.scrollTop = chatbox.scrollHeight;
	}, 1000);
}

// 버튼 이벤트 : 버튼 클릭 시 챗봇 박스 보여주거나 사라지게 하는 것
const toggleBtn = document.getElementById('chatBot');
const chatContainer = document.getElementById('chatBotBox');

toggleBtn.addEventListener('click', () => {
	const isVisible = chatContainer.style.display === 'block';
	chatContainer.style.display = isVisible ? 'none' : 'block';
	toggleBtn.innerHTML = isVisible ? "<i class='fa fa-commenting-o'></i>" : "<i class='fa fa-times' aria-hidden='true'></i>";
});