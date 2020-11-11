$(function () {
  // メソッドの定義
  var methods = {
    numbers: function (value, element) {
      return this.optional(element) || /^\d+(\.\d+)?$/.test(value);
    },
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $("#new_record").validate({
    // ルール設定
    rules: {
      "record[date]": {
        required: true
      },
      "record[weight]": {
        required: true,
        numbers: true,
        range: [0, 200]Ï
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
  // 入力欄or選択欄をフォーカスアウトしたときにバリデーションを実行
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
});