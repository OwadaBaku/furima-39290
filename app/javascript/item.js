document.addEventListener("DOMContentLoaded", function() {
	// 価格の入力フィールドのID
  const priceInput = document.getElementById("item-price");
	// 販売手数料要素のID
	const commissionSpan = document.getElementById("add-tax-price");
	// 販売利益要素のID
	const profitSpan = document.getElementById("profit");

	// 価格に入力をしたらイベントを発火させる
  priceInput.addEventListener("input", function() {
		// 価格をpriceに代入
		const price = parseFloat(priceInput.value);
		// Math.floorで小数点以下切り捨て。その後括弧内で価格の10%を計算する。
    const commission = Math.floor(price * 0.1);
		// 販売利益を計算しprofitに代入
		const profit = price - commission;

		// 販売手数料を条件分岐
		// 価格の入力がない場合、販売手数料を空欄にする
		if (isNaN(commission)) {
      commissionSpan.textContent = "";
		// 価格の入力がある場合、販売手数料を表示する
		} else {
    commissionSpan.textContent = commission;
		}
		// 販売利益を条件分岐
		// 価格の入力がない場合、販売利益を空欄にする
		if (isNaN(profit)) {
      profitSpan.textContent = "";
		// 価格の入力がある場合、販売利益を表示する
		} else {
      profitSpan.textContent = profit;
    }
	});
});
