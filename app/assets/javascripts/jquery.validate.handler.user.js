$(function () {
  // メソッドの定義
  var methods = {
    email: function (value, element) { // メールアドレスの正規表現 
      return this.optional(element) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/i.test(value);
    },
    password: function (value, element) { // パスワードの正規表現 
      return this.optional(element) || /^([a-zA-Z0-9]{6,})$/i.test(value);
    }
  }

  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行(ユーザー登録、ログイン)
  $("#new_user").validate({
    // ルール設定
    rules: {
      "user[nickname]": {
        required: true
      },
      "user[email]": {
        required: true,
        email: true 
      },
      "user[password]": {
        required: true,
        password: true
      },
      "user[password_confirmation]": {
        required: true,
        password: true,
        equalTo: "#user_password"
      },
    },
    // エラーメッセージの定義
    messages: {
      "user[nickname]": {
        required: "ニックネームを入力してください"
      },
      "user[email]": {
        required: "メールアドレスを入力してください",
        email: "フォーマットが不適切です"
      },
      "user[password]": {
        required: "パスワードを入力してください",
        password: "英数字6字以上でを入力してください"
      },
      "user[password_confirmation]": {
        required: "確認用パスワードを入力してください",
        password: "英数字6字以上でを入力してください",
        equalTo: "パスワードが一致していません"
      },
    },
    errorClass: "is-invalid",
    errorElement: "p",
    validClass: "is-valid",
  });
  $("#edit_user").validate({ // ユーザー編集
    // ルール設定
    rules: {
      "user[nickname]": {
        required: true
      },
      "user[email]": {
        required: true,
        email: true
      },
      "user[password]": {
        password: true
      },
      "user[password_confirmation]": {
        password: true,
        equalTo: "#user_password"
      },
      "user[current_password]": {
        password: true,
        required: function (element) {
          return $("#user_password").val() == "";
        }
      },
    },
    // エラーメッセージの定義
    messages: {
      "user[nickname]": {
        required: "ニックネームを入力してください"
      },
      "user[email]": {
        required: "メールアドレスを入力してください",
        email: "フォーマットが不適切です"
      },
      "user[password]": {
        password: "英数字6字以上でを入力してください"
      },
      "user[password_confirmation]": {
        password: "英数字6字以上でを入力してください",
        equalTo: "パスワードが一致していません"
      },
      "user[current_password]": {
        password: "英数字6字以上でを入力してください",
        required: "現在のパスワードを入力してください",
      },
    },
    errorClass: "is-invalid",
    errorElement: "p",
    validClass: "is-valid",
  });
  // 入力欄をフォーカスアウトしたときにバリデーションを実行
  $("#user_nickname, #user_email, #user_password, #user_current_password, #user_password_confirmation").blur(function () {
    $(this).valid();
  });
});