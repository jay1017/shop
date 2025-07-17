// cart.js

document.addEventListener("DOMContentLoaded", function () {
    const selectedBuyForm = document.getElementById("selectedBuyForm");
    const checkboxes = document.querySelectorAll("input[name='selected']");
    const totalDisplay = document.getElementById("selectedTotal");
    
    function calculateSelectedTotal() {
        let total = 0;

        checkboxes.forEach(cb => {
            if (cb.checked) {
                const cardBody = cb.closest(".card-body");
                const discountText = cardBody.querySelector(".card-text:nth-of-type(3)");
                const countInput = cardBody.querySelector("input[name='ccount']");

                const discount = parseInt(discountText.textContent.replace(/[^0-9]/g, ""), 10) || 0;
                const count = parseInt(countInput.value, 10) || 1;

                total += discount * count;
            }
        });

        if (totalDisplay) {
            totalDisplay.textContent = "₩" + total.toLocaleString();
        }
    }

    checkboxes.forEach(cb => {
        cb.addEventListener("change", calculateSelectedTotal);
    });

    document.querySelectorAll("input[name='ccount']").forEach(input => {
        input.addEventListener("input", calculateSelectedTotal);
    });

	if (selectedBuyForm) {
	    selectedBuyForm.addEventListener("submit", function (e) {
	        e.preventDefault();
	        selectedBuyForm.querySelectorAll("input[type='hidden']").forEach(el => el.remove());

	        const checkedItems = document.querySelectorAll("input[name='selected']:checked");

	        if (checkedItems.length === 0) {
	            alert("구매할 상품을 선택하세요.");
	            return;
	        }

	        const gnumList = [];
	        const bcountList = [];
	        const gonumList = [];

	        checkedItems.forEach(cb => {
	            const gnum = cb.value;
	            const cardBody = cb.closest(".card-body");
	            const ccountInput = cardBody.querySelector("input[name='ccount']");
	            const gonumInput = cardBody.querySelector("input[name='gonum']");

	            const bcount = ccountInput ? ccountInput.value : 1;
	            const gonum = gonumInput ? gonumInput.value : "";

	            gnumList.push(gnum);
	            bcountList.push(bcount);
	            gonumList.push(gonum);
	        });

	        const makeHiddenInput = (name, value) => {
	            const input = document.createElement("input");
	            input.type = "hidden";
	            input.name = name;
	            input.value = value;
	            selectedBuyForm.appendChild(input);
	        };

	        makeHiddenInput("gnum", gnumList.join(","));
	        makeHiddenInput("bcount", bcountList.join(","));
	        makeHiddenInput("gonum", gonumList.join(","));

	        selectedBuyForm.submit();
	    });
	}
});