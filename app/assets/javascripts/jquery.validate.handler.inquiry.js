$(function () {
  // メソッドの定義
  var methods = {
    email: function (value, element) { // メールアドレスの正規表現 
      return this.optional(element) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/i.test(value);
    }
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $("#new_inquiry").validate({
    // ルール設定
    rules: {
      "inquiry[name]": {
        required: true
      },
      "inquiry[email]": {
        required: true,
        email: true,
      }
    },
    // エラーメッセージの定義
    messages: {
      "inquiry[name]": {
        required: "名前もしくはニックネームを入力してください"
      },
      "inquiry[email]": {
        required: "メールアドレスを入力してください",
        email: "フォーマットが不適切です"
      }
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
  });
  // 入力欄をフォーカスアウトしたときにバリデーションを実行
  $("#inquiry_name, #inquiry_email").blur(function () {
    $(this).valid();
  });
});