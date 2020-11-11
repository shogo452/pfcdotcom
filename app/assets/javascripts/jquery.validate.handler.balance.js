$(function () {
  // メソッドの定義
  var methods = {
    numbers: function (value, element) {
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
  // バリデーションの実行
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
    // 入力欄or選択欄をフォーカスアウトしたときにバリデーションを実行
  $("#balance_gender, #balance_height, #balance_weight, #balance_age, #balance_activity, #balance_fitness_type").blur(function () {
    $(this).valid();
  });
});