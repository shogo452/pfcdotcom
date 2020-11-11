$(function () {
  // メソッドの定義
  var methods = {
    price: function (value, element) {
      return this.optional(element) || /^\d+$/.test(value);
    },
    numbers: function (value, element) {
      return this.optional(element) || /^\d+(\.\d+)?$/.test(value);
    },

  }
  // メソッドの追加

  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
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



  // 入力欄or選択欄をフォーカスアウトしたときにバリデーションを実行
  $("#product_name, #product_protein, #product_fat, #product_carbo, #product_sugar, #product_calory, #product_price, #product_purchase_url").blur(function () {
    $(this).valid();
  });
});