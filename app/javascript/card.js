const pay = () => {
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY); //公開鍵の設定(vimで追加済み)
  const elements = payjp.elements(); //elementsインスタンスは、フォームを生成するためのcreate()メソッドを使えます。
// 入力フォームを作成、指定したフォームのtypeのelementインスタンスを生成 始
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');
// 入力フォームを作成、指定したフォームのtypeのelementインスタンスを生成 終

// mount => 指定した要素とelementインスタンスが情報を持つフォームとを置き換えるメソッド IDを使用する 始
  numberElement.mount('#card-number');
  expiryElement.mount('#card-expiry');
  cvcElement.mount('#card-cvc');
// mount => 指定した要素とelementインスタンスが情報を持つフォームとを置き換えるメソッド IDを使用する 終

  // フォームの送信ボタンをクリックしたら、イベントが発火する
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();

    //createToken => 戻り値としてカード情報のトークンを取得, カード情報のnumberElementを指定
    payjp.createToken(numberElement).then(function (response) { // than以降にレスポンスを受け取った後の処理を記載
      if (response.error) {
      } else {
        const token = response.id; //response.idとすることでトークンの値がtokenに代入される
        const renderDom = document.getElementById("charge-form"); //charge-formにトークンを含める
        const tokenObj = `<input value="${token}" name='order_form[token]' type="hidden">`; //order_form[token]の値をtokenに入れる,hiddenでトークンの値を非表示にする
        renderDom.insertAdjacentHTML("beforeend", tokenObj); //フォームの中に作成したinput要素を追加
      }
      //下記記述でフォームに存在するクレジットカードの各情報を削除する
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay); //ページが読み込まれた時に、payという変数に代入したアロー関数が実行されるようにする