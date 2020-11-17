$(function () {
  // メソッドの定義
  var methods = {
    email: function (value, element) { // メールアドレスの正規表現 
      return this.optional(element) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/i.test(value);
    },
    password: function (value, element) { // パスワードの正規表現 
      return this.optional(element) || /^([a-zA-Z0-9]{6,})$/i.test(value);
    },
    price: function (value, element) { // 金額の正規表現
      return this.optional(element) || /^\d+$/.test(value);
    },
    numbers: function (value, element) { //半角小数の正規表現
      return this.optional(element) || /^\d+(\.\d+)?$/.test(value);
    },
    valueNotEquals: function (value, element, arg) { // プルダウンリストが選択されているかの確認
      return arg !== value;
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
    $("#new_message").validate({
    // ルール設定
    rules: {
      "message[message]": {
        required: true
      }
    },
    // エラーメッセージの定義
    messages: {
      "message[message]": {
        required: "メッセージを入力してください"
      }
    },
    errorClass: "is-invalid",
    errorElement: "p",
    validClass: "is-valid",
    });
  
  $("#new_product, .edit_product, #new_review").validate({
    // ルール設定
    rules: {
      "product[name]": {
        required: true
      },
      "product[protein]": {
        required: true,
        numbers: true,
        range: [0, 999]
      },
      "product[fat]": {
        required: true,
        numbers: true,
        range: [0, 999]
      },
      "product[carbo]": {
        required: true,
        numbers: true,
        range: [0, 999]
      },
      "product[sugar]": {
        numbers: true,
        range: [0, 999]
      },
      "product[price]": {
        price: true,
        range: [0, 999]
      },
      "product[calory]": {
        numbers: true,
        range: [0, 999]
      },
      "product[purchase_url]": {
        url: true,
      },
    },
    // エラーメッセージの定義
    messages: {
      "product[name]": {
        required: "名前を入力してください"
      },
      "product[protein]": {
        required: "タンパク質量を入力してください",
        numbers: "半角数字で入力してください",
        range: "0以上999以下で入力してください"
      },
      "product[fat]": {
        required: "脂質量を入力してください",
        numbers: "半角数字で入力してください",
        range: "0以上999以下で入力してください"
      },
      "product[carbo]": {
        required: "炭水化物量を入力してください",
        numbers: "半角数字で入力してください",
        range: "0以上999以下で入力してください"
      },
      "product[sugar]": {
        numbers: "半角数字で入力してください",
        range: "0以上999以下で入力してください"
      },
      "product[calory]": {
        numbers: "半角数字で入力してください",
        range: "0以上999以下で入力してください"
      },
      "product[price]": {
        price: "半角数字で入力してください",
        range: "0以上999以下で入力してください"
      },
      "product[purchase_url]": {
        url: "正しいURLを入力してください"
      }
    },
    errorClass: "is-invalid",
    errorElement: "p",
    validClass: "is-valid",
  });

  $("#new_record").validate({
    // ルール設定
    rules: {
      "record[date]": {
        required: true
      },
      "record[weight]": {
        required: true,
        numbers: true,
        range: [0, 200]
      },
      "record[body_fat_percentage]": {
        numbers: true,
        range: [0, 100]
      },
    },
    // エラーメッセージの定義
    messages: {
      "record[date]": {
        required: "日付を選択してください"
      },
      "record[weight]": {
        required: "体重を入力してください",
        numbers: "体重を半角数字で入力してください",
        range: "0以上200以下で入力してください"
      },
      "record[body_fat_percentage]": {
        numbers: "体脂肪率を半角数字で入力してください",
        range: "0以上100以下で入力してください"
      },
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
    errorPlacement: function (error, element) {
        error.appendTo("#record_error");
    }
  });

  $(".new_balance, .edit_balance").validate({
    // ルール設定
    rules: {
      "balance[gender]": {
        valueNotEquals: "noselect"
      },
      "balance[height]": {
        required: true,
        numbers: true,
        range: [0, 250]
      },
      "balance[weight]": {
        required: true,
        numbers: true,
        range: [0, 200]
      },
      "balance[age]": {
        required: true,
        numbers: true,
        range: [0, 150]
      },
      "balance[activity]": {
        valueNotEquals: "noselect"
      },
      "balance[fitness_type]": {
        valueNotEquals: "noselect"
      },
    },
    // エラーメッセージの定義
    messages: {
      "balance[gender]": {
        valueNotEquals: "性別を選択してください"
      },
      "balance[height]": {
        required: "身長を入力してください",
        numbers: "半角数字で入力してください",
        range: "0以上250以下で入力してください"
      },
      "balance[weight]": {
        required: "体重を入力してください",
        numbers: "半角数字で整数に切り上げて入力してください",
        range: "0以上200以下で入力してください"
      },
      "balance[age]": {
        required: "年齢を入力してください",
        numbers: "半角数字で入力してください",
        range: "0以上150以下で入力してください"
      },
      "balance[activity]": {
        valueNotEquals: "アクティブ度を選択してください"
      },
      "balance[fitness_type]": {
        valueNotEquals: "目的を選択してください"
      }
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
  });

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
  $("#user_nickname, #user_email, #user_password, #user_current_password, #user_password_confirmation, #message_message").blur(function () {
    $(this).valid();
  });
  $("#product_name, #product_protein, #product_fat, #product_carbo, #product_sugar, #product_calory, #product_price, #product_purchase_url").blur(function () {
    $(this).valid();
  });
  $("#record_date").blur(function () {
    $("#record_date-error").remove();
    $(this).valid();
  });
  $("#record_weight").blur(function () {
    $("#record_weight-error").remove();
    $(this).valid();
  });
  $("#record_body_fat_percentage").blur(function () {
    $("#record_body_fat_percentage-error").remove();
    $(this).valid();
  });
  $("#balance_gender, #balance_height, #balance_weight, #balance_age, #balance_activity, #balance_fitness_type").blur(function () {
    $(this).valid();
  });
  $("#inquiry_name, #inquiry_email").blur(function () {
    $(this).valid();
  });

});